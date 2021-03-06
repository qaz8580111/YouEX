USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_PackageGet]    Script Date: 02/04/2016 10:14:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PackageGet]
(
	@DepotId		int,
	@ShippingNo		nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @OrderNo		nvarchar(50),
			@PackageNo		nvarchar(50);

	IF Exists(Select * From YouEx_Package Where (dbo.CheckShipping(ShippingNo, @ShippingNo) = 1) And ((@DepotId = 0) Or (DepotId = @DepotId)))
	Begin
		Select @PackageNo = PackageNo, @OrderNo = OrderNo From YouEx_Package Where (dbo.CheckShipping(ShippingNo, @ShippingNo) = 1) And ((@DepotId = 0) Or (DepotId = @DepotId));

		Select *, (Case UserId When 0 Then (Select Top 1 AgentName From YouEx_Agent B Where A.AgentId = B.AgentId) Else (Select Top 1 UserName From YouEx_XmlUser C Where A.UserId = C.UserId) End) as UserName
			From YouEx_Order A Where OrderNo = @OrderNo;
		Select * From YouEx_Package Where (OrderNo = @OrderNo) or ((@OrderNo = '') and (PackageNo = @PackageNo));
		Select * From YouEx_OrderService Where PackageNo = @PackageNo;
	End

	Return 1;
END

