USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreatePackageForcast]    Script Date: 02/04/2016 10:19:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreatePackageForcast]
(
	@PackageId		int
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare	@OrderNo		nvarchar(50),
			@PackageNo		nvarchar(50),
			@DepotId		int,
			@Type			int,
			@Status			int,
			@ShippingNo		nvarchar(50),
			@ShippingName	nvarchar(50),
			@ShippingId		int,
			@GateId			int,
			@Recipients		nvarchar(50),
			@CreateTime		datetime,
			@UserId			int,
			@StorageNo		nvarchar(50),
			@StorageTime	datetime,
			@Phone			nvarchar(50),
			@NotifyType		int,
			@NotifyInfo		nvarchar(50),
			@IsPak			int,
			@Weight			decimal,
			@Length			decimal,
			@Width			decimal,
			@Height			decimal,
			@Remark			nvarchar(200),
			
			@PackageContent	Xml;

	IF Not Exists(Select * From maj_fedroad.dbo.Maj_OrderGoodsExtend Where OrderGoodsId = @PackageId)
		Return 0;

	Select @DepotId = 1,
		   @UserId = UserId,
		   @StorageNo = StorageNo,
		   @Type = 1,
		   @Status = Case IsShipped
						When 1 then 5
						else Case IsConfirmed
								When 1 then 2
								else 1
							 end
					end,
		   @ShippingNo = ShippingOrder,
		   @ShippingName = ShippingName,
		   @ShippingId = 0,
		   @GateId = 0,
		   @Recipients = '',
		   @CreateTime = AddTime,
		   @StorageTime = OrderTime,
		   @Phone = ShippingTel,
		   @NotifyType = 0,
		   @NotifyInfo = '',
		   @IsPak = IsPak,
		   @Weight = [Weight],
		   @Length = [Length],
		   @Width = Width,
		   @Height = Height,
		   @Remark = Remark
	   From maj_fedroad.dbo.Maj_OrderGoods A Left Join maj_fedroad.dbo.Maj_OrderGoodsExtend B On A.OrderGoodsId = B.OrderGoodsId Where A.OrderGoodsId = @PackageId and IsCenceled = 0;

	Exec rm_GetIdentify 'Package', 1, 0, @PackageNo Output;
	IF Exists(Select * From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo)
		Exec sy_CreateOrderForcast @PackageId, @PackageNo, @OrderNo Output;
	Else
		Select @OrderNo = '';
		
	Select @PackageContent = '<Root><Package><PackageNo/><OrderNo/><DepotId/><Type/><Status/><ShippingNo/><ShippingName/><ShippingId/><GateId/><Recipients/><CreateTime/><UserId/><StorageNo/><StorageTime/><Phone/><NotifyType/><NotifyInfo/><IsPak/><Weight/><Length/><Width/><Height/><Remark/></Package></Root>';

	Set @PackageContent.modify('insert text{sql:variable("@PackageNo")} into (/Root/Package/PackageNo)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@OrderNo")} into (/Root/Package/OrderNo)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@DepotId")} into (/Root/Package/DepotId)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Type")} into (/Root/Package/Type)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Status")} into (/Root/Package/Status)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@ShippingNo")} into (/Root/Package/ShippingNo)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@ShippingName")} into (/Root/Package/ShippingName)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@GateId")} into (/Root/Package/GateId)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Recipients")} into (/Root/Package/Recipients)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@CreateTime")} into (/Root/Package/CreateTime)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@UserId")} into (/Root/Package/UserId)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@StorageNo")} into (/Root/Package/StorageNo)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@StorageTime")} into (/Root/Package/StorageTime)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Phone")} into (/Root/Package/Phone)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@NotifyType")} into (/Root/Package/NotifyType)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@IsPak")} into (/Root/Package/IsPak)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Weight")} into (/Root/Package/Weight)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Length")} into (/Root/Package/Length)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Width")} into (/Root/Package/Width)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Height")} into (/Root/Package/Height)[1]');
	Set @PackageContent.modify('insert text{sql:variable("@Remark")} into (/Root/Package/Remark)[1]');

	Declare @Result int,
			@PackageGoods Xml;

	Exec @Result = sy_CreateGoodsXml 0, @PackageId, 0, @PackageGoods Output;
	Set @PackageContent.modify('insert sql:variable("@PackageGoods") as last into (/Root)[1]');

	Exec sy_CreatePackage @PackageNo, @OrderNo, @DepotId, @Type, @Status, @ShippingNo, @CreateTime, @UserId, @StorageNo, @StorageTime, @PackageContent;

	Return 1;

END
