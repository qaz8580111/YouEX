USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_CodeResource]    Script Date: 02/04/2016 10:12:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_CodeResource]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,
	@Result			nvarchar(50) Output,

	@Id				int,
	@ResName		nvarchar(50),
	@DepotId		int,
	@GateId			int,
	@Prefix			nvarchar(50),
	@Postfix		nvarchar(50),
	@CodeLength		int,
	@BeginIndex		int,
	@EndIndex		int,
	@CurIndex		int,
	@Status			int,
	@CreateTime		DateTime
)
AS
BEGIN
	SET NOCOUNT ON;

	IF (@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_CodeResource WHERE (ResName = @ResName) and (Prefix = @Prefix) and (Postfix = @Postfix) and (BeginIndex = @BeginIndex) and (EndIndex = @EndIndex))
			Return -1;

		INSERT INTO YouEx_CodeResource (ResName, DepotId, GateId, Prefix, Postfix, CodeLength, BeginIndex, EndIndex, CurIndex, [Status], CreateTime)
				VALUES(@ResName, @DepotId, @GateId, @Prefix, @Postfix, @CodeLength, @BeginIndex, @EndIndex, @CurIndex, @Status, @CreateTime);

		Return @@IDENTITY;
	End

	IF (@CommandType = 2)
	Begin
		IF Not EXISTS(SELECT * FROM YouEx_CodeResource WHERE Id = @Id)
			Return -1;

		Update YouEx_CodeResource Set
				BeginIndex = @BeginIndex,
				EndIndex = @EndIndex,
				CurIndex = @CurIndex,
				[Status] = @Status
			Where Id = @Id;

		Return 1;
	End
		
	IF (@CommandType = 3)
	Begin
		IF Not Exists(Select * From YouEx_CodeResource Where Id = @Id)
			Return -1;

		Delete From YouEx_CodeResource Where Id = @Id;
		Return 1;
	End
	
	IF (@CommandType = 4)
	Begin
		IF @SelectType = 1
		Begin
			Declare	@CodeNo	nvarchar(50);
			Declare @ResId int;
			Select @ResId = Value From YouEx_SystemEnum Where [Type] = 'Resource' And Name = @ResName;

			IF Not Exists(Select * From YouEx_CodeResource Where (ResName = @ResName) and ([Status] = 1) and ((DepotId = 0) or (DepotId = @DepotId)))
			Begin
				Select @Result = '';
				Return -1;
			End

			IF @ResId > 1000
			Begin
				-- ResId > 1000的作为内部单号（订单号、包裹号等）
				IF @ResName = 'StorageNo' or @ResName = 'AgentStorage'
					Select TOP(1) @Id = Id,	@CodeNo = Prefix + SUBSTRING('000000000000', 1, CodeLength - LEN(CurIndex)) + STR(CurIndex, LEN(CurIndex)) + Postfix
						From YouEx_CodeResource Where ResName = @ResName and [Status] = 1;
				Else
					Select TOP(1) @Id = Id,	@CodeNo = Prefix + left('000', (3-LEN(@DepotId))) + STR(@DepotId, LEN(@DepotId))
							+ SUBSTRING('000000000000', 1, CodeLength - LEN(CurIndex)) + STR(CurIndex, LEN(CurIndex)) + Postfix
						From YouEx_CodeResource Where ResName = @ResName and [Status] = 1;
				
				Update YouEx_CodeResource Set
						CurIndex = CurIndex + 1,
						[Status] = Case When CurIndex >= EndIndex Then 2 Else 1 End
					Where Id = @Id;

				Select @Result = @CodeNo;
				Return 1;
			End
			Else
			Begin
				-- 分配运单ShippingNo

				-- 在预分配表中删除已使用的运单
				Delete From YouEx_CodePreAlloc Where ShippingNo in (Select ShippingNo From YouEx_Package Where [Type] >= 2);

				-- 在预分配表中查询分配超时的运单，改变状态，可以进行再次分配
				Declare @ShippingNoTimeOut	int;
				Select @ShippingNoTimeOut = Value From YouEx_SystemEnum Where [Type] = 'Config' and Name = 'ShippingNoTimeOut';
				Update YouEx_CodePreAlloc Set [Status] = 1 Where [Status] = 0 and DATEDIFF(day, AllocTime, GETUTCDATE()) > @ShippingNoTimeOut;

				Begin Tran CreateShippingNo;
				
				IF Exists(Select * From YouEx_CodePreAlloc Where [Status] = 1 and ResName = @ResName And DepotId = @DepotId)
				Begin
					Select TOP(1) @CodeNo = ShippingNo From YouEx_CodePreAlloc Where [Status] = 1 and ResName = @ResName And DepotId = @DepotId;
					Update YouEx_CodePreAlloc Set [Status] = 0, DepotId = @DepotId, AllocTime = GETUTCDATE() Where ShippingNo = @CodeNo;
				End
				Else
				Begin
					Select TOP(1) @Id = Id,	@CodeNo = Prefix + SUBSTRING('000000000000', 1, CodeLength - LEN(CurIndex)) + STR(CurIndex, LEN(CurIndex)) + Postfix
						From YouEx_CodeResource Where ResName = @ResName and [Status] = 1 And DepotId = @DepotId;

					Insert Into YouEx_CodePreAlloc(ResName, ShippingNo, DepotId, GateId, AllocTime, [Status])
						(Select ResName, @CodeNo, @DepotId, @GateId, GETUTCDATE(), 0 From YouEx_CodeResource Where Id = @Id);

					Update YouEx_CodeResource Set
							CurIndex = CurIndex + 1,
							[Status] = Case When CurIndex >= EndIndex Then 2 Else 1 End
						Where Id = @Id;
				End
				
				Commit Tran;

				Select @Result = @CodeNo;
				Return 1;
			End
		End

		IF @SelectType = 2
		Begin
			Select * From YouEx_CodeResource Where Id = @Id;
			Return 2;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		-- 按ResName值查询
		IF (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' ResName = ' + ltrim(str(@ResName)) + ' And';
	
		-- 按Status值查询
		IF (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' [Status] = ' + ltrim(str(@Status)) + ' And';
		
		-- 按起止时间查询
		IF (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		IF @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_CodeResource Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End
	
	Return 0;
END
