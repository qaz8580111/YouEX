USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Payment]    Script Date: 02/04/2016 10:14:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Payment]
(
	@CommandType		int,
	@SelectType			int,
	@BeginTime			datetime,
	@EndTime			datetime,

	@PayId				int,
	@UserId				int,
	@AgentId			int,
	@AdminId			int,
	@BillNo				nvarchar(50),
	@PayType			int,
	@PayStatus			int,
	@CnyAmount			decimal(18, 2),
	@Amount				decimal(18, 2),
	@CurrencyCode		nvarchar(50),
	@Charge				decimal(18, 2),
	@PaymentName		nvarchar(50),
	@CreateTime			datetime,
	@ConfirmTime		dateTime,
	@UserInfo			nvarchar(300),
	@AdminInfo			nvarchar(300)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		INSERT INTO YouEx_Payment(UserId, AgentId, AdminId, BillNo, PayType, PayStatus, CnyAmount, Amount, CurrencyCode, Charge, PaymentName, CreateTime, ConfirmTime, UserInfo, AdminInfo)
			VALUES(@UserId, @AgentId, @AdminId, @BillNo, @PayType, @PayStatus, @CnyAmount, @Amount, @CurrencyCode, @Charge, @PaymentName, @CreateTime, @ConfirmTime, @UserInfo, @AdminInfo);

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Payment WHERE PayId = @PayId)
			Return 0;

		Update YouEx_Payment Set 
				UserId = @UserId,
				AgentId = @AgentId,
				AdminId = @AdminId,
				BillNo = @BillNo,
				PayType = @PayType,
				PayStatus = @PayStatus,
				CnyAmount = @CnyAmount,
				Amount = @Amount,
				CurrencyCode = @CurrencyCode,
				Charge = @Charge,
				PaymentName = @PaymentName,
				CreateTime = @CreateTime,
				ConfirmTime = @ConfirmTime,
				UserInfo = @UserInfo,
				AdminInfo = @AdminInfo
			Where PayId = @PayId;
		
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Payment WHERE PayId = @PayId)
			Return 0;
		Delete From YouEx_Payment Where PayId = @PayId;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按PayId查询订单
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Payment Where PayId = @PayId;
			Return 1;
		End
		
		-- 按BillNo查询订单
		If (@SelectType = 2)
		Begin
			Select * From YouEx_Payment Where BillNo = @BillNo;
			Return 2;
		End
		
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		-- 按UserId查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';
			
		-- 按AgentId查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' AgentId = ' + ltrim(str(@AgentId)) + ' And';
			
		-- 按AdminId查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' AdminId = ' + ltrim(str(@AdminId)) + ' And';

		-- 按PayType查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' PayType = ' + ltrim(str(@PayType)) + ' And';
			
		-- 按PayStatus查询
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' PayStatus = ' + ltrim(str(@PayStatus)) + ' And';
			
		-- 按PaymentName查询
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' PaymentName = ''' + ltrim(@PaymentName) + ''' And';

		-- 按CreateTime查询
		If (@SelectType & 256) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';


		Select @strCmd = 'Select * From YouEx_Payment Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 3;
	End
	
	Return 0;

END
