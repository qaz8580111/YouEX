USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_UpdateOrder]    Script Date: 02/04/2016 10:20:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_UpdateOrder]
(
	@Id  int
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare	@OrderId int;
	Declare @PackageNo nvarchar(50);

	Select @OrderId = MIN(OrderId) From maj_fedroad.dbo.Maj_Order;
	while @OrderId is not null
	Begin

		Exec Sy_CreateOrderXml @OrderId;

		--Add Delivery
		Declare @DeliveryId int;
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
