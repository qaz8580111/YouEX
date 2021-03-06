USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateOrderXml]    Script Date: 02/04/2016 10:19:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateOrderXml]
(
	@OrderId			int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @OrderNo			nvarchar(50),
			@DepotId			int,
			@UserId				int,
			@StorageNo			nvarchar(50),
			@AgentId			int,
			@Type				int,
			@Status				int,
			@CreateTime			datetime,
			@PackageCount		int,
			@ArrivedPackage		int,
			@DeliveryCount		int,
			@RealDeliveryCount	int,
			@Insurance			int,
			@Invoice			int,
			@AutoPay			int,
			@HoldPacking		int,
			@WarningInfo		nvarchar(200),
			
			@OrderContent		Xml;

	Select @OrderNo = OrderNo,
		   @CreateTime = OrderTime,
		   @DepotId = 1,
		   @UserId = UserId,
		   @AgentId = 0,
		   @Type = 1,
		   @Status = case StatusId
						When 1 then 3
						When 2 then 11
						else case ShippingStatus
								When 1 then 9
								When 3 then 8
								When 2 then case PaymentStatus
												When 0 then 6
												When 1 then 7
											end
								else 2
							 end
						end,
	       @Insurance = Insurance,
	       @Invoice = NeedInvoice,
	       @AutoPay = AutoPay,
	       @HoldPacking = 1-IsBUd,
	       @WarningInfo = ''
		From maj_fedroad.dbo.Maj_Order Where OrderId = @OrderId;
	Select @StorageNo = StorageNo From maj_fedroad.dbo.Maj_User Where UserId = @UserId;
	Select @PackageCount = COUNT(*) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = @OrderId;
	Select @ArrivedPackage = COUNT(*) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = @OrderId And IsConfirmed = 1;
	Select @DeliveryCount = COUNT(*), @RealDeliveryCount = COUNT(*) From maj_fedroad.dbo.Maj_Delivery Where OrderId = @OrderId;

	If (@PackageCount > @ArrivedPackage) and @Status = 2
		Select @Status = 1;
	
	Select @OrderContent = '<Root><Order><OrderId/><OrderNo/><DepotId/><UserId/><StorageNo/><AgentId/><Type/><Status/><CreateTime/><PackageCount/><ArrivedPackage/><DeliveryCount/><RealDeliveryCount/><Insurance/><Invoice/><AutoPay/><HoldPacking/><WarningInfo/></Order></Root>';

	Set @OrderContent.modify('insert text{sql:variable("@OrderId")} into (/Root/Order/OrderId)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@OrderNo")} into (/Root/Order/OrderNo)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@DepotId")} into (/Root/Order/DepotId)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@UserId")} into (/Root/Order/UserId)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@StorageNo")} into (/Root/Order/StorageNo)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@AgentId")} into (/Root/Order/AgentId)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@Type")} into (/Root/Order/Type)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@Status")} into (/Root/Order/Status)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@CreateTime")} into (/Root/Order/CreateTime)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@PackageCount")} into (/Root/Order/PackageCount)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@ArrivedPackage")} into (/Root/Order/ArrivedPackage)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@DeliveryCount")} into (/Root/Order/DeliveryCount)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@RealDeliveryCount")} into (/Root/Order/RealDeliveryCount)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@Insurance")} into (/Root/Order/Insurance)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@Invoice")} into (/Root/Order/Invoice)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@AutoPay")} into (/Root/Order/AutoPay)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@HoldPacking")} into (/Root/Order/HoldPacking)[1]');
	Set @OrderContent.modify('insert text{sql:variable("@WarningInfo")} into (/Root/Order/WarningInfo)[1]');

	Declare @Result int,
			@BillContent Xml,
			@PackageGoods Xml,
			@LogContent Xml;

	Exec @Result = sy_CreateBillXml @OrderId, '';

	Exec @Result = sy_CreateGoodsXml @OrderId, 0, 0, @PackageGoods Output;
	Set @OrderContent.modify('insert sql:variable("@PackageGoods") as last into (/Root)[1]');

	Exec @Result = sy_CreateLogXml @OrderId, @LogContent Output;
	Set @OrderContent.modify('insert sql:variable("@LogContent") as last into (/Root)[1]');

	Declare @ServiceList Xml, @ServiceContent xml;
	Select @ServiceList = '<OrderService/>';

	--Add Package
	Declare @PackageId int;
	Select @PackageId = MIN(OrderGoodsId) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = @OrderId;
	While @PackageId is not null
	Begin
		Declare @ShippingNo nvarchar(50), @PackageNo nvarchar(50);
		Select @ShippingNo = ShippingOrder From maj_fedroad.dbo.Maj_OrderGoodsExtend Where OrderGoodsId = @PackageId;

		Exec sy_CreatePackageXml @PackageId, 0, @PackageNo Output;
		
		--Add OrderService
		Exec @Result = sy_CreateServiceXml @ShippingNo, @PackageNo, '', @ServiceContent Output;
		Declare @Service Xml;
		Select @Service = @ServiceContent.query('//Service');
		Set @ServiceList.modify('insert sql:variable("@Service") as last into (/OrderService)[1]');

		Select @PackageId = MIN(OrderGoodsId) From maj_fedroad.dbo.Maj_OrderGoods Where OrderId = @OrderId and OrderGoodsId > @PackageId;
	End

	Set @OrderContent.modify('insert sql:variable("@ServiceList") as last into (/Root)[1]');

	Exec Sy_CreateOrder @OrderId, @OrderNo, @DepotId, @UserId, @StorageNo, @AgentId, @Type, @Status, @CreateTime, @PackageCount, @ArrivedPackage, @DeliveryCount, @RealDeliveryCount, @OrderContent;

	Return 1;
END
