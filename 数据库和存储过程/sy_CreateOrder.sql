USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateOrder]    Script Date: 02/04/2016 10:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateOrder]
(
	@OrderId			int,
	@OrderNo			nvarchar(50),
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
	@OrderContent		Xml
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO YouEx_Order (OrderId, OrderNo, DepotId, UserId, StorageNo, AgentId, [Type], [Status], CreateTime, PackageCount, ArrivedPackage, DeliveryCount, RealDeliveryCount, Content)
		VALUES(@OrderId, @OrderNo, @DepotId, @UserId, @StorageNo, @AgentId, @Type, @Status, @CreateTime, @PackageCount, @ArrivedPackage, @DeliveryCount, @RealDeliveryCount, @OrderContent);
END
