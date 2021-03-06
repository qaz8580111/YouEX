USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlBill]    Script Date: 02/04/2016 10:15:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlBill]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,

	@BillNo			nvarchar(50),
	@Type			int,
	@IndexNo		nvarchar(50),
	@DepotId		int,
	@UserId			int,
	@AgentId		int,
	@AutoPay		int,
	@PayStatus		int,
	@PayMode		int,
	@CreateTime		DateTime,
	@PayTime		DateTime,
	@Content		Xml
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@CommandType <= 2)
	Begin
		Select @BillNo = @Content.value('(/Root/Bill/BillNo)[1]', 'nvarchar(50)');
		Select @Type = @Content.value('(/Root/Bill/Type)[1]', 'int');
		Select @IndexNo = @Content.value('(/Root/Bill/IndexNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Bill/DepotId)[1]', 'int');
		Select @UserId = @Content.value('(/Root/Bill/UserId)[1]', 'int');
		Select @AgentId = @Content.value('(/Root/Bill/AgentId)[1]', 'int');
		Select @AutoPay = @Content.value('(/Root/Bill/AutoPay)[1]', 'int');
		Select @PayStatus = @Content.value('(/Root/Bill/PayStatus)[1]', 'int');
		Select @PayMode = @Content.value('(/Root/Bill/PayMode)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Bill/CreateTime)[1]', 'DateTime');
		Select @PayTime = @Content.value('(/Root/Bill/PayTime)[1]', 'DateTime');
	End
	
	IF(@CommandType = 1)
	Begin
		IF Exists(Select * From YouEx_XmlBill Where BillNo = @BillNo)
			Return -1;

		INSERT INTO YouEx_XmlBill (BillNo, [Type], IndexNo, DepotId, UserId, AgentId, AutoPay, PayStatus, PayMode, CreateTime, PayTime, Content)
			VALUES(@BillNo, @Type, @IndexNo, @DepotId, @UserId, @AgentId, @AutoPay, @PayStatus, @PayMode, @CreateTime, @PayTime, @Content);

		Return 1;
	End
	

	IF(@CommandType = 2)
	Begin
		If Not Exists(Select * From YouEx_XmlBill Where BillNo = @BillNo)
			Return 0;
		
		Update YouEx_XmlBill Set
				[Type] = @Type,
				IndexNo = @IndexNo,
				DepotId = @DepotId,
				UserId = @UserId,
				AgentId = @AgentId,
				AutoPay = @AutoPay,
				PayStatus = @PayStatus,
				PayMode = @PayMode,
				CreateTime = @CreateTime,
				PayTime = @PayTime,
				Content = @Content
			Where BillNo = @BillNo;
		Return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_XmlBill Where BillNo = @BillNo)
			Return 0;

		Delete From YouEx_XmlBill Where BillNo = @BillNo;
		return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按BillNo查询
		If @SelectType = 1
		Begin
			Select * From YouEx_XmlBill Where BillNo = @BillNo;
			Return 1;
		End
		
		-- 按OrderNo查询
		If @SelectType = 2
		Begin
			Select * From YouEx_XmlBill Where (IndexNo = @IndexNo) and ([Type] = 1);
			Return 2;
		End

		-- 按ServiceNo查询
		If @SelectType = 3
		Begin
			Select * From YouEx_XmlBill Where (IndexNo = @IndexNo) and ([Type] = 2);
			Return 3;
		End
		
		-- 按TaxNo查询
		If @SelectType = 4
		Begin
			Select * From YouEx_XmlBill Where (IndexNo = @IndexNo) and ([Type] = 3);
			Return 4;
		End
		
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		-- 按DepotId查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' DepotId = ' + ltrim(str(@DepotId)) + ' And';

		-- 按UserId查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';

		-- 按AgentId查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' AgentId = ' + ltrim(str(@AgentId)) + ' And';

		-- 按PayStatus查询
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' PayStatus = ' + ltrim(str(@PayStatus)) + ' And';

		-- 按CreateTime查询
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		-- 按PayTime查询
		If (@SelectType & 256) <> 0
			Select @strCmd = @strCmd + ' PayTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And PayTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';
		
		If @strCmd = ''
			return -1;

		Select @strCmd = 'Select * From YouEx_XmlBill Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End
	
	Return 0;
END

