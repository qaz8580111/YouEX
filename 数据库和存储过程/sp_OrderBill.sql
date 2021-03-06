USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_OrderBill]    Script Date: 03/11/2016 16:12:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		TorkyChan
-- Create date: 2016-2-25
-- Modify date: 2016-3-2
-- Description:	计算账单
-- =============================================
ALTER PROCEDURE [dbo].[sp_OrderBill]
(
	@OrderNo		nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare	@DepotId		int,
			@AutoPay		int,
			@PackageNo		nvarchar(50),
			@AgentId		int,
			@UserId			int,
			@HoldingPack	int,
			@ShippingId		int,

			@ShippingFee	decimal(18, 2),

			@Remark			nvarchar(300),
			@BillDetail		Xml,
			@Content		Xml;

	Declare @ServiceNo		nvarchar(50),
			@ServiceName	nvarchar(50),
			@SvrPrice		decimal(18, 2),
			@ServicePrice	decimal(18, 2);

	Declare @BillNo			nvarchar(50),
			@CnyCost		decimal(18, 2),
			@TotalCost		decimal(18, 2),
			@ShippingPrice	decimal(18, 2),
			@GoodsPrice		decimal(18, 2),
			@OptionPrice	decimal(18, 2),

			@NeedInsurance	int,
			@Insurance		decimal(18, 2);

	Declare @PriceId		int;

	Declare @Index			int,
			@Return_Value	int;

	Declare	@CurrencyCode	nvarchar(50),
			@CurrencyUnit	nvarchar(50);

	IF Not Exists(Select * From YouEx_Order Where OrderNo = @OrderNo and AccessStatus = 2 and PayStatus = 0)
		Return -1;

	-- 获取订单信息
	Select @DepotId = DepotId,
		   @AgentId = AgentId,
		   @UserId = UserId,
		   @AutoPay = AutoPay,
		   @HoldingPack = @HoldingPack,
		   @NeedInsurance = Insurance
		From YouEx_Order Where OrderNo = @OrderNo;
	
	Begin Transaction;

	-- 遍历订单中的包裹
	Select @BillDetail = '<BillDetail/>';
	Select @Index = 1, @Insurance = 0, @ServicePrice = 0, @ShippingPrice = 0;

	Select @PackageNo = MIN(PackageNo) From YouEx_Package Where OrderNo = @OrderNo and [Type] = 2 and [Status] = 12;
	While @PackageNo is not null
	Begin
		-- 获取包裹信息
		Select @ShippingId = ShippingId, @GoodsPrice = Content.value('sum(//Goods/Price)', 'decimal(18, 2)') From YouEx_Package Where PackageNo = @PackageNo;

		-- 获取线路价格等配置参数
		Select @PriceId = dbo.GetShippingPrice(@ShippingId, @UserId, @AgentId);
		IF @PriceId = 0
		Begin
			Rollback Transaction;
			Return -3;
		End
		
		-- 计算包裹运费
		Select @Content = dbo.CalcShippingPrice(@DepotId, @Index, @PriceId, @PackageNo, @HoldingPack);
		Select @ShippingFee = @Content.value('(//Cost)[1]', 'decimal(18, 2)')
		IF @ShippingFee > 0
		Begin
			Set @BillDetail.modify('insert sql:variable("@Content") as last into (/BillDetail)[1]');
			Select @ShippingPrice = @ShippingPrice + @ShippingFee;
			Select @Index = @Index + 1;
		End

		-- 保险费用
		IF @NeedInsurance = 1
			Select @Insurance = @Insurance + @GoodsPrice * InsuranceRate * 0.01 From YouEx_ShippingPrice Where PriceId = @PriceId;

		-- 增值服务费
		IF Exists(Select * From YouEx_Service Where PackageNo = @PackageNo and AccessStatus = 1 and PayStatus = 0)
		Begin
			Select @ServiceNo = MIN(ServiceNo) From YouEx_Service Where PackageNo = @PackageNo and AccessStatus = 1 and PayStatus = 0;
			While @ServiceNo is not null
			Begin
				Select @ServiceName = ServiceName, @SvrPrice = dbo.GetServicePrice(ServiceCode, @DepotId, @UserId, @AgentId) From YouEx_Service Where ServiceNo = @ServiceNo;
				Select @ServicePrice = @ServicePrice + @SvrPrice;
				Select @Content = dbo.GetBillDetail(@Index, '增值服务费（' + @ServiceName + '）', @SvrPrice, '包裹编号：' + @PackageNo);
				Set @BillDetail.modify('insert sql:variable("@Content") as last into (/BillDetail)[1]');
				Update YouEx_Service Set PayStatus = 1 Where ServiceNo = @ServiceNo;

				Select @Index = @Index + 1;
				Select @ServiceNo = MIN(ServiceNo) From YouEx_Service Where PackageNo = @PackageNo and AccessStatus = 1 and PayStatus = 0 and ServiceNo > @ServiceNo;
			End
		End


		Select @PackageNo = MIN(PackageNo) From YouEx_Package Where OrderNo = @OrderNo and [Type] = 2 and [Status] = 12 and PackageNo > @PackageNo;
	End

	-- 计算系统服务费（分合箱）
	Select @OptionPrice = dbo.CalcSystemPrice(@OrderNo);
	IF @OptionPrice > 0
	Begin
		Select @Content = dbo.GetBillDetail(@Index, '系统服务费（分合箱）', @OptionPrice, '');
		Set @BillDetail.modify('insert sql:variable("@Content") as last into (/BillDetail)[1]');
		Select @Index = @Index + 1;
	End

	-- 获取货币单位
	Select @CurrencyCode = CurrencyCode, @CurrencyUnit = CurrencyUnit From YouEx_Depot Where DepotId = @DepotId;

	-- 更新数据库账单信息
	Select @TotalCost = @ShippingPrice + @ServicePrice + @OptionPrice + @Insurance;
	Select @CnyCost = @TotalCost * ExchangeRate From YouEx_Currency Where Code = @CurrencyCode;
	Select @Remark = '订单：' + @OrderNo +'，运费：' + @CurrencyUnit + ltrim(str(@ShippingPrice, 18, 2)) + ' + 系统服务费：' + @CurrencyUnit + ltrim(str(@OptionPrice, 18, 2))
		 + ' + 增值服务费：' + @CurrencyUnit + ltrim(str(@ServicePrice, 18, 2)) + ' + 保险费用：' + @CurrencyUnit + ltrim(str(@Insurance, 18, 2)) + ' = 合计费用：' + @CurrencyUnit + ltrim(str(@TotalCost, 18, 2));
	IF @CurrencyCode != 'CNY'
		Select @Remark = @Remark + '，人民币：' + ltrim(str(@CnyCost, 18, 2));
		
	Exec sp_GetResource 'BillNo', @DepotId, 0, @BillNo out;
	Insert Into YouEx_OrderBill (BillNo, [Type], IndexNo, DepotId, UserId, AgentId, AutoPay, PayStatus, PayMode, CreateTime, ConfirmTime, PayTime, CnyCost, TotalCost, CurrencyCode, PayBank, PayCash, PayFly, PayCoupon, CouponNo, Remark, Content)
		Values(@BillNo, 1, @OrderNo, @DepotId, @UserId, @AgentId, @AutoPay, 1, 0, GETUTCDATE(), '1900-01-01', '1900-01-01', @CnyCost, @TotalCost, @CurrencyCode, 0, 0, 0, 0, '', '', @BillDetail);

	Update YouEx_Order Set PayStatus = 1 Where OrderNo = @OrderNo;
	
	Commit Transaction;
	
	-- 自动支付
	IF @AutoPay <> 0
	Begin
		Exec @Return_Value = sp_BillPay @BillNo;
		IF @Return_Value <> 1
			Return 2
	End
	
	
	Return 1;
END
