USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateAddressXml]    Script Date: 02/04/2016 10:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateAddressXml]
(
	@DeliveryId		int,
	@AddressContent	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare @AddressId		int,
			@Name			nvarchar(50),
			@Email			nvarchar(100),
			@Phone			nvarchar(100),
			@Mobile			nvarchar(100),
			@WeiXin			nvarchar(100),
			@Recipients		nvarchar(100),
			@RecipientsEn	nvarchar(100),
			@Country		int,
			@Province		int,
			@City			int,
			@Address		nvarchar(200),
			@AddressEn		nvarchar(200),
			@ZipCode		nvarchar(50),
			@IdCard			nvarchar(50),
			@IdFront		int,
			@IdBack			int,
	
			@UserId			int,
			@CreateTime		datetime,
			@strIdFront		nvarchar(100),
			@strIdBack		nvarchar(100),
			@strFileName	nvarchar(50),
			@strFilePath	nvarchar(100);
			

	Select @AddressId = 0,
		   @Name = '',
		   @Email = Email,
		   @Phone = Mobile,
		   @Mobile = Tel,
		   @WeiXin = '',
		   @Recipients = ShipTo,
		   @RecipientsEn = '',
		   @Country = Country,
		   @Province = Province,
		   @City = City,
		   @Address = [Address],
		   @AddressEn = '',
		   @ZipCode = Zipcode,
		   @IdCard = IdCard,
		   @strIdFront = IdPositive,
		   @strIdBack = IdObverse,
		   @UserId = UserId,
		   @CreateTime = AddTime
		From maj_fedroad.dbo.Maj_Delivery Where DeliveryId = @DeliveryId;

	Declare @Title nvarchar(100);
	Select @Title = 'IDCard_Front_' + ltrim(str(@UserId));
	Exec @IdFront = sy_UpdateFile 1, @UserId, @Title, 3, @CreateTime, @strIdFront;
	Select @Title = 'IDCard_Back_' + ltrim(str(@UserId));
	Exec @IdBack = sy_UpdateFile 1, @UserId, @Title, 3, @CreateTime, @strIdBack;

	Select @AddressId = ShippingId, @Name = AddressName, @RecipientsEn = ShipToEn, @AddressEn = AddressEn From maj_fedroad.dbo.Maj_ShippingAddress
		Where (UserId = @UserId) and (((IdNo <> '') and (IdNo = @IdCard)) or ((IdNo = '') and (ShipTo = @Recipients) and ([Address] = @Address)));

	Select @Country = B.Id From maj_fedroad.dbo.Maj_Area A inner join YouEx_Area B On A.Name = B.Name Where A.Id = @Country;
	Select @Province = B.Id From maj_fedroad.dbo.Maj_Area A inner join YouEx_Area B On A.Name = B.Name Where A.Id = @Province;
	Select @City = B.Id From maj_fedroad.dbo.Maj_Area A inner join YouEx_Area B On A.Name = B.Name Where A.Id = @City;

	Select @AddressContent = '<PackageAddress><AddressId/><Name/><Email/><Phone/><Mobile/><WeiXin/><Recipients/><RecipientsEn/><Country/><Province/><City/><Address/><AddressEn/><ZipCode/><IdCard/><IdFront/><IdBack/></PackageAddress>';

	Set @AddressContent.modify('insert text{sql:variable("@AddressId")} into (/PackageAddress/AddressId)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Name")} into (/PackageAddress/Name)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Email")} into (/PackageAddress/Email)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Phone")} into (/PackageAddress/Phone)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Mobile")} into (/PackageAddress/Mobile)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@WeiXin")} into (/PackageAddress/WeiXin)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Recipients")} into (/PackageAddress/Recipients)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@RecipientsEn")} into (/PackageAddress/RecipientsEn)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Country")} into (/PackageAddress/Country)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Province")} into (/PackageAddress/Province)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@City")} into (/PackageAddress/City)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@Address")} into (/PackageAddress/Address)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@AddressEn")} into (/PackageAddress/AddressEn)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@ZipCode")} into (/PackageAddress/ZipCode)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@IdCard")} into (/PackageAddress/IdCard)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@IdFront")} into (/PackageAddress/IdFront)[1]');
	Set @AddressContent.modify('insert text{sql:variable("@IdBack")} into (/PackageAddress/IdBack)[1]');

END
