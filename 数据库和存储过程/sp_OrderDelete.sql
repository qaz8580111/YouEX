USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_OrderDelete]    Script Date: 03/11/2016 16:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		TorkyChan
-- Create date: 2016-2-25
-- Modify date: 2016-3-2
-- Description:	删除订单及订单相关的所有数据
-- =============================================
ALTER PROCEDURE [dbo].[sp_OrderDelete]
(
	@OrderNo		nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	IF Exists(Select * From YouEx_Order Where OrderNo = @OrderNo)
	Begin
		Delete From YouEx_XmlTrack Where ShippingNo in (Select ShippingNo From YouEx_Package Where OrderNo = @OrderNo);
		Delete From YouEx_Service Where PackageNo in (Select PackageNo From YouEx_Package Where OrderNo = @OrderNo);
		Delete From YouEx_Package Where OrderNo = @OrderNo;
		Delete From YouEx_Order Where OrderNo = @OrderNo;
		Return 1;
	End
	Return 0;
END

