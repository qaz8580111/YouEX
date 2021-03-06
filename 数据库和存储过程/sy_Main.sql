USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_Main]    Script Date: 02/04/2016 10:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_Main]
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare	@OrderId int;
	Declare @PackageNo nvarchar(50);
	Declare @DeliveryId int;
	Declare @PackageId int;

	-- 处理预报包裹数据
	Select @PackageId = MIN(OrderGoodsId) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = -1 and IsCenceled = 0;
	while @PackageId is not null
	Begin
		Exec sy_CreatePackageForcast @PackageId;
		Select @PackageId = MIN(OrderGoodsId) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = -1 and IsCenceled = 0 and OrderGoodsId > @PackageId;
	End


	-- 处理有订单的包裹、运单等数据
	Select @OrderId = MIN(OrderId) From maj_fedroad.dbo.Maj_Order;
	while @OrderId is not null
	Begin
		Exec Sy_CreateOrderXml @OrderId;

		--Add Delivery
		Select @DeliveryId = MIN(DeliveryId) From maj_fedroad.dbo.Maj_Delivery Where OrderId = @OrderId;
		While @DeliveryId is not null
		Begin
			Exec sy_CreatePackageXml 0, @DeliveryId, @PackageNo Output;
			Select @DeliveryId = MIN(DeliveryId) From maj_fedroad.dbo.Maj_Delivery Where OrderId = @OrderId and DeliveryId > @DeliveryId;
		End

	Select @OrderId = MIN(OrderId) From maj_fedroad.dbo.Maj_Order Where OrderId > @OrderId;
	End
	
	
	Return 0;
END
