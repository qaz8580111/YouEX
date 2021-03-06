USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateBillXml]    Script Date: 02/04/2016 10:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateBillXml]
(
	@OrderId		int,
	@ShippingNo		nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare @DeliveryNo nvarchar(50);
	Declare	@OrderNo nvarchar(50);

	Declare @IsPak int;
	Declare @AutoPay int;
	Declare @HoldingPack int;
	Declare @Weight decimal(18, 2);
	Declare @Length decimal(18, 2);
	Declare @Width decimal(18, 2);
	Declare @Height decimal(18, 2);
	
	Declare @RealWeight decimal(18, 2);
	Declare @HeavyWeight decimal(18, 2);
	Declare @CostWeight decimal(18, 2);
	Declare @HeavyFee decimal(18, 2);
	Declare @ShippingFee decimal(18, 2);

	Declare @Remark nvarchar(300);
	Declare @DetailContent Xml;
	
	Declare @Status int;
	Declare @CreateTime datetime;
	Declare @ConfirmTime datetime;
	Declare @PayTime datetime;
	Declare @PayMode int;
	Declare @TotalCost decimal(18, 2);
	Declare @CurrencyId int;
	Declare @MaxFly int;
	Declare @PayCash decimal(18, 2);
	Declare @PayFly int;
	Declare @PayTicket decimal(18, 2);
	
	Declare @ShippingPrice decimal(18, 2);
	Declare @GoodsPrice decimal(18, 2);
	Declare @OptionPrice decimal(18, 2);
	Declare @ServicePrice decimal(18, 2);
	Declare @Insurance decimal(18, 2);
	Declare @BillContent Xml;
	
	IF Not Exists(Select * From maj_fedroad.dbo.Maj_Order Where OrderId = @OrderId and StatusId <> 1 and PaymentStatus <> 99)
		Return 0;

	Select @OrderNo = OrderNo,
		   @CreateTime = OrderTime,
		   @PayMode = 0,
		   @TotalCost = TotalPrice,
		   @CurrencyId = 1,
		   @MaxFly = 0,
		   @PayCash = 0,
		   @PayFly = 0,
		   @PayTicket = 0,
		   @ShippingPrice = ShippingPrice,
		   @GoodsPrice = GoodsPrice,
		   @OptionPrice = OptionPrice,
		   @ServicePrice = ServicePrice,
		   @AutoPay = AutoPay,
		   @Insurance = Case NeedInsurance When 1 then Insurance else 0 end,
		   @HoldingPack = 1-IsBUd,
		   @Status = Case PaymentStatus When 99 then 1 When 1 then 3 else 2 end
		From maj_fedroad.dbo.Maj_Order Where OrderId = @OrderId;
	
	Select @PayTime = ChangeTime,
		   @PayCash = UserMoney,
		   @PayFly = PayPoints
		From maj_fedroad.dbo.Maj_User_Acount_Log Where ItemId = @OrderId and ActionCode = 'PAY';
	
	Select @PayTime = ChangeTime,
		   @PayTicket = FrozenMoney
		From maj_fedroad.dbo.Maj_User_Acount_Log Where ItemId = @OrderId and ActionCode = 'AGIO';

	Select @Remark = '订单：' + @OrderNo +'，运费：$' + ltrim(str(@ShippingPrice, 18, 2)) + ' + 系统服务费：$' + ltrim(str(@OptionPrice, 18, 2)) + '
				+ 增值服务费：$' + ltrim(str(@ServicePrice, 18, 2)) + '保险费用：$' + ltrim(str(@Insurance, 18, 2)) + ' = 合计费用：$' + ltrim(str(@TotalCost, 18, 2));
	
	Declare @DeliveryId int;
	Declare @Index int;
	Declare @BillDetail xml;
	Select @BillDetail = '<BillDetail/>';
	Select @Index = 1;
	Select @DeliveryId = MIN(DeliveryId) From maj_fedroad.dbo.Maj_Delivery Where OrderId = @OrderId;
	While @DeliveryId is not null
	Begin
		Select @DeliveryNo = DeliveryNo,
			   @Width = Width,
			   @Length = [Length],
			   @Height = Height,
			   @RealWeight = RealWeight,
			   @CostWeight = [Weight],
			   @HeavyWeight = HeavyWeight,
			   @HeavyFee = HeavyFee,
			   @ShippingFee = ShippingFee,
			   @IsPak = IsPak
			From maj_fedroad.dbo.Maj_Delivery Where DeliveryId = @DeliveryId;
		
		Select @Remark = '运单编号：' + @DeliveryNo + '，长宽高(inch)：' + ltrim(str(@Length, 18, 2)) + '*' + ltrim(str(@Width, 18, 2)) + '*' + ltrim(str(@Height, 18, 2))
				+ '；实际重量(LBS)：' + ltrim(str(@RealWeight, 18, 2)) + '，计费重量(LBS)：' + ltrim(str(@CostWeight, 18, 2)) + '，计泡重量(LBS)：' + ltrim(str(@HeavyWeight, 18, 2))
				+ '；实际运输费用：$' + ltrim(str(@ShippingFee, 18, 2));

		IF @HeavyFee > 0
		Begin
			IF @HoldingPack = 1
				Select @Remark = @Remark + '（因客户要求保留原包装，故增加计泡费用：$' + ltrim(str(@HeavyFee, 18, 2)) + '）';
			Else
				Select @Remark = @Remark + '（其中，计泡费用：$' + ltrim(str(@HeavyFee, 18, 2)) + '）';
		End

		Select @DetailContent = dbo.GetBillDetailXml(@Index, '运费', @ShippingFee, @Remark);
		Set @BillDetail.modify('insert sql:variable("@DetailContent") as last into (/BillDetail)[1]');
		
		Select @Index = @Index + 1;
		Select @DeliveryId = MIN(DeliveryId) From maj_fedroad.dbo.Maj_Delivery Where OrderId = @OrderId and DeliveryId > @DeliveryId;
	End
	
	Select @BillContent = dbo.GetBillXml(@OrderNo, @OrderNo, '', 1, @AutoPay, @Status-1, @CreateTime, @ConfirmTime, @PayTime, @PayMode, @TotalCost, @CurrencyId, 0, @PayCash, @PayFly, @PayTicket, @Remark, @BillDetail);
	
	INSERT INTO YouEx_XmlBill (BillNo, OrderNo, ServiceNo, DepotId, AutoPay, PayStatus, PayMode, CreateTime, PayTime, Content)
		VALUES(@OrderNo, @OrderNo, '', 1, @AutoPay, @Status-1, @PayMode, @CreateTime, @PayTime, @BillContent);

	
	Return 1;

END
