USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateOrderForcast]    Script Date: 02/04/2016 10:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateOrderForcast]
(
	@PackageId		int,
	@PackageNo		nvarchar(50),
	@OrderNo		nvarchar(50) Output
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @OrderId			int,
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
			
			@IsArrived			int,
			@IsPayed			int,
			@ShippingNo			nvarchar(50),
			@OrderContent		Xml;

	Exec @OrderId = rm_GetIdentify 'Order', 1, 0, @OrderNo Output;
	
	Select @CreateTime = AddTime,
		   @DepotId = 1,
		   @UserId = UserId,
		   @StorageNo = StorageNo,
		   @AgentId = 0,
		   @Type = 1,
		   @Status = 1,
	       @Insurance = 0,
	       @Invoice = 0,
	       @AutoPay = 0,
	       @HoldPacking = 0,
	       @PackageCount = 1,
	       @ArrivedPackage = 0,
	       @DeliveryCount = 0,
	       @RealDeliveryCount = 0,
	       @WarningInfo = '',
	       @IsArrived = IsConfirmed,
	       @IsPayed = IsPayed,
	       @ShippingNo = ShippingOrder
		From maj_fedroad.dbo.Maj_OrderGoods A inner Join maj_fedroad.dbo.Maj_OrderGoodsExtend B On A.OrderGoodsId = B.OrderGoodsId Where A.OrderGoodsId = @PackageId;
	
	IF @IsArrived = 1
	Begin
		Select @Status = 2;
		
		IF Exists(Select * From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo and ServiceId = 13)
		Begin
			Select @Status = 23;
			IF Exists(Select * From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo and ServiceId = 13 and StatusId = 1)
				Select @Status = 24;
		End
	End

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
/*
	IF @IsPayed = 2
	Begin
		Exec @Result = sy_CreateBillXml 0, @ShippingNo, @BillContent Output;
		Set @OrderContent.modify('insert sql:variable("@BillContent") as last into (/Root)[1]');
	End

	Exec @Result = sy_CreateLogXml @OrderId, @LogContent Output;
	Set @OrderContent.modify('insert sql:variable("@LogContent") as last into (/Root)[1]');
*/



	IF Exists(Select * From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo)
	Begin
		Declare @ServiceContent xml;
		Exec @Result = sy_CreateServiceXml @ShippingNo, @PackageNo, '', @ServiceContent Output;
		Set @OrderContent.modify('insert sql:variable("@ServiceContent") as last into (/Root)[1]');
	End


	Exec Sy_CreateOrder @OrderId, @OrderNo, @DepotId, @UserId, @StorageNo, @AgentId, @Type, @Status, @CreateTime, @PackageCount, @ArrivedPackage, @DeliveryCount, @RealDeliveryCount, @OrderContent;

	Return 1;
END
