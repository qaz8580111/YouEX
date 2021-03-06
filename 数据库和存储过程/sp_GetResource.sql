USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetResource]    Script Date: 02/04/2016 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_GetResource]
(
	@ResName		nvarchar(50),
	@DepotId		int,
	@GateId			int,
	@Result			nvarchar(50) out
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare	@CodeNo	nvarchar(50),
			@ResId	int,
			@Id		int;
			
	Select @ResId = Value From YouEx_SystemEnum Where [Type] = 'Resource' And Name = @ResName;

	Begin Tran CreateShippingNo;

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

		Select @Result = @CodeNo;
	End
	Commit Tran;
	Return 1;

END

