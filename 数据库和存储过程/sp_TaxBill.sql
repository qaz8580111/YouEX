USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_TaxBill]    Script Date: 02/04/2016 10:14:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_TaxBill]
(
	@CommandType		int,
	@SelectType			int,
	@BeginTime			datetime,
	@EndTime			datetime,

	@TaxId				int,
	@TaxNo				nvarchar(50),
	@UserId				int,
	@ShippingNo			nvarchar(50),
	@PayStatus			int,
	@Image				nvarchar(50),
	@Money				decimal(18, 2),
	@PayId				nvarchar(50),
	@Phone				nvarchar(50),
	@NoticeTime			int,
	@CreateTime			datetime,
	@PayTime			datetime
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_TaxBill WHERE TaxNo = @TaxNo)
			Return -1;

		INSERT INTO YouEx_TaxBill(TaxNo, UserId, ShippingNo, PayStatus, [Image], [Money], PayId, Phone, NoticeTime, CreateTime, PayTime)
			VALUES(@TaxNo, @UserId, @ShippingNo, @PayStatus, @Image, @Money, @PayId, @Phone, @NoticeTime, @CreateTime, @PayTime);
		
		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_TaxBill WHERE TaxNo = @TaxNo)
			Return -1;

		Update YouEx_TaxBill Set 
				UserId = @UserId,
				ShippingNo = @ShippingNo,
				PayStatus = @PayStatus,
				[Image] = @Image,
				[Money] = @Money,
				PayId = @PayId,
				Phone = @Phone,
				NoticeTime	= @NoticeTime,
				CreateTime = @CreateTime,
				PayTime = @PayTime
			Where TaxNo = @TaxNo;
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_TaxBill WHERE TaxNo = @TaxNo)
			Return -1;
		Delete From YouEx_TaxBill WHERE TaxNo = @TaxNo;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按TaxId查询
		If (@SelectType = 1)
		Begin
			Select * From YouEx_TaxBill Where TaxId = @TaxId;
			Return 1;
		End

		-- 按TaxNo查询
		If (@SelectType = 2)
		Begin
			Select * From YouEx_TaxBill Where TaxNo = @TaxNo;
			Return 2;
		End
		
		-- 按UserId查询
		If (@SelectType = 3)
		Begin
			Select * From YouEx_TaxBill Where UserId = @UserId;
			Return 3;
		End
		
		-- 按ShippingNo查询
		If (@SelectType = 4)
		Begin
			Select * From YouEx_TaxBill Where ShippingNo = @ShippingNo;
			Return 4;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';
		
		-- 支付状态
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' PayStatus = ''' + LTRIM(@PayStatus) + ''' And';

		-- 按CreateTime查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		Select @strCmd = 'Select * From YouEx_TaxBill Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 3;
	End
	
	Return 0;

END
