USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreatePackage]    Script Date: 02/04/2016 10:19:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreatePackage]
(
	@PackageNo		nvarchar(50),
	@OrderNo		nvarchar(50),
	@DepotId		int,
	@Type			int,
	@Status			int,
	@ShippingNo		nvarchar(50),
	@CreateTime		datetime,
	@UserId			int,
	@StorageNo		nvarchar(50),
	@StorageTime	datetime,
	@PackageContent	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO YouEx_Package (PackageNo, OrderNo, [Type], DepotId, UserId, StorageNo, CreateTime, StorageTime, [Status], ShippingNo, Content)
		VALUES(@PackageNo, @OrderNo, @Type, @DepotId, @UserId, @StorageNo, @CreateTime, @StorageTime, @Status, @ShippingNo, @PackageContent);
END
