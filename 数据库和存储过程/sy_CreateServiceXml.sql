USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateServiceXml]    Script Date: 02/04/2016 10:20:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateServiceXml]
(
	@ShippingNo		nvarchar(50),
	@PackageNo		nvarchar(50),
	@DeliveryNo		nvarchar(50),
	@ServiceList	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;

	Select @ServiceList = '<OrderService/>';
	Declare @ServiceNo		nvarchar(50),
			@Status			int,
			@TypeId			int,
			@TypeName		nvarchar(50),
			@Request		nvarchar(300),
			@Phone			nvarchar(50),
			@AdminId		int,
			@AccessResult	nvarchar(300),
			@Attach			nvarchar(300),
			@CreateTime		datetime,
			@AccessTime		datetime,
			
			@UserId			int,
			@ServiceId		int,
			@ServiceContent	xml;

	Select @ServiceId = MIN(RecordId) From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo;
	While @ServiceId is not null
	Begin
		Select @ServiceNo = RecordNo,
			   @Status = StatusId + 1,
			   @TypeId = ServiceId,
			   @TypeName = ServiceName,
			   @Request = [Description],
			   @Phone = '',
			   @AdminId = AdminId,
			   @AccessResult = Case IsPhoto when 0 then [Attach] else '' end,
			   @Attach = Case IsPhoto when 1 then [Attach] else '' end,
			   @CreateTime = AddTime,
			   @AccessTime = CheckTime,
			   @UserId = UserId
			From maj_fedroad.dbo.Maj_OrderService Where RecordId = @ServiceId;
		
		--Access @Attach
		IF @Attach <> ''
		Begin
			Declare @PathFile nvarchar(300);
			Declare @strTemp nvarchar(300);
			
			Select @strTemp = @Attach;
			Select @Attach = '';
			
			Declare	@Index int, @FileId int, @Pos int, @Title nvarchar(100);

			Select @Index = 1;
			While @strTemp <> ''
			Begin
				IF SUBSTRING(@strTemp, 1, 1) = '|'
					Select @strTemp = SUBSTRING(@strTemp, 2, LEN(@strTemp) - 1);
				
				Select @Pos = CHARINDEX('|', @strTemp, 1);
				IF @Pos > 0
				Begin
					Select @PathFile = SUBSTRING(@strTemp,1, @Pos - 1);
					Select @strTemp = SUBSTRING(@strTemp,@Pos + 1, LEN(@strTemp) - @Pos);
				End
				Else
				Begin
					Select @PathFile = @strTemp;
					Select @strTemp = '';
				End

				Select @Title = 'PhotoService_' + ltrim(str(@UserId)) + ltrim(str(@Index));
				Exec @FileId = sy_UpdateFile @AdminId, @UserId, @Title, 4, @AccessTime, @PathFile;
				
				Select @Attach = @Attach + ',' + ltrim(str(@FileId))
				Select @Index = @Index + 1;
			End
			IF @Attach <> ''
				Select @Attach = SUBSTRING(@Attach, 1, len(@Attach) - 1);
		End

		Select @ServiceContent = '<Service><ServiceNo/><PackageNo/><DeliveryNo/><Status/><TypeId/><TypeName/><Request/><Phone/><AdminId/><AccessResult/><Attach/><CreateTime/><AccessTime/></Service>';
		Set @ServiceContent.modify('insert text{sql:variable("@ServiceNo")} into (/Service/ServiceNo)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@PackageNo")} into (/Service/PackageNo)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@DeliveryNo")} into (/Service/DeliveryNo)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@Status")} into (/Service/Status)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@TypeId")} into (/Service/TypeId)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@TypeName")} into (/Service/TypeName)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@Request")} into (/Service/Request)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@Phone")} into (/Service/Phone)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@AdminId")} into (/Service/AdminId)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@AccessResult")} into (/Service/AccessResult)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@Attach")} into (/Service/Attach)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@CreateTime")} into (/Service/CreateTime)[1]');
		Set @ServiceContent.modify('insert text{sql:variable("@AccessTime")} into (/Service/AccessTime)[1]');

		Set @ServiceList.modify('insert sql:variable("@ServiceContent") as last into (/OrderService)[1]');

		Select @ServiceId = MIN(RecordId) From maj_fedroad.dbo.Maj_OrderService Where ShippingOrder = @ShippingNo and RecordId > @ServiceId;
	End

	Return 1;
END
