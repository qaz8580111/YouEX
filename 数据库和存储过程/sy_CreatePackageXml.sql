USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreatePackageXml]    Script Date: 02/04/2016 10:19:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreatePackageXml]
(
	@PackageId		int,
	@DeliveryId		int,
	@PackageNo		nvarchar(50) Output
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare	@OrderNo		nvarchar(50),
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

	Select @PackageContent = '<Root><Package><PackageNo/><OrderNo/><DepotId/><Type/><Status/><ShippingNo/><ShippingName/><ShippingId/><GateId/><Recipients/><CreateTime/><UserId/><StorageNo/><StorageTime/><Phone/><NotifyType/><NotifyInfo/><IsPak/><Weight/><Length/><Width/><Height/><Remark/></Package></Root>';

	IF @PackageId = 0 and @DeliveryId = 0
		Return 0;

	IF @PackageId <> 0
	Begin
		Select @OrderNo = OrderNo,
			   @DepotId = 1,
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
	End
	
	IF @DeliveryId <> 0
	Begin
		Declare @strIdFront nvarchar(100),
				@strIdBack nvarchar(100);

		Select @OrderNo = OrderNo,
			   @DepotId = 1,
			   @UserId = UserId,
			   @Type = 2,
			   @Status = Case DeliveryNo
							When '' then 11
							else Case StatusId
									When 1 then 14
									else 12
								 end
						 end,
			   @ShippingNo = DeliveryNo,
			   @ShippingName = ShippingName,
			   @ShippingId = ShippingId,
			   @Recipients = '',
			   @CreateTime = AddTime,
			   @StorageTime = AddTime,
			   @Phone = '',
			   @NotifyType = 0,
			   @NotifyInfo = '',
			   @IsPak = IsPak,
			   @Weight = [Weight],
			   @Length = [Length],
			   @Width = Width,
			   @Height = Height,
			   @Remark = Remark
		   From maj_fedroad.dbo.Maj_Delivery Where DeliveryId = @DeliveryId;
		
		Select @StorageNo = StorageNo From maj_fedroad.dbo.Maj_User Where UserId = @UserId;

		Select @GateId = 0;
		IF (@ShippingNo <> '') and (LEN(@ShippingNo) > 5)
		Begin
			Declare @NoHead nvarchar(10);
			Select @NoHead = UPPER(SUBSTRING(@ShippingNo, 0, 5));
			IF @NoHead = '14202'
				Select @GateId = 2;
			IF @NoHead = '17000' or @NoHead = '90009'
				Select @GateId = 1;
			IF @NoHead = 'FRDUS' or @NoHead = 'CF218'
				Select @GateId = 5;
			IF @NoHead = 'FRDUP' or @NoHead = 'EZ164'
				Select @GateId = 6;
			IF @NoHead = 'HE500'
				Select @GateId = 3;
		End
	End

	Exec rm_GetIdentify 'Package', 1, 0, @PackageNo Output;

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

	Exec @Result = sy_CreateGoodsXml 0, @PackageId, @DeliveryId, @PackageGoods Output;
	Set @PackageContent.modify('insert sql:variable("@PackageGoods") as last into (/Root)[1]');
	
	IF @DeliveryId <> 0
	Begin
		Declare @AddressContent Xml;
		Exec @Result = sy_CreateAddressXml @DeliveryId, @AddressContent Output;
		Set @PackageContent.modify('insert sql:variable("@AddressContent") as last into (/Root)[1]');

		Declare @TrackContent Xml;
		Exec @Result = sy_CreateTrackXml @DeliveryId, @TrackContent Output;
		Set @PackageContent.modify('insert sql:variable("@TrackContent") as last into (/Root)[1]');
	End


	Exec sy_CreatePackage @PackageNo, @OrderNo, @DepotId, @Type, @Status, @ShippingNo, @CreateTime, @UserId, @StorageNo, @StorageTime, @PackageContent;
	
	IF @PackageId <> 0
		Return 1;
	Else
		Return 2;

END
