USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlDelete]    Script Date: 02/04/2016 10:16:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlDelete]
(
	@Module			nvarchar(50),
	@IndexNo		nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @IndexNo = ''
		Return -1;



	IF @Module = 'Package'
	Begin
		IF Not Exists(SELECT * FROM YouEx_Package WHERE PackageNo = @IndexNo)
			Return 0;
		Delete From YouEx_Package Where PackageNo = @IndexNo;
		Return 1;
	End




	IF @Module = 'Order'
	Begin
		IF Not Exists(SELECT * FROM YouEx_XmlOrder WHERE OrderNo = @IndexNo)
			Return 0;
		Delete From YouEx_XmlOrder Where OrderNo = @IndexNo;
		Return 1;
	End

	
	

	IF @Module = 'Track'
	Begin
		If Not Exists(Select * From YouEx_XmlTrack Where ShippingNo = @IndexNo)
			Return 0;
		Delete From YouEx_XmlTrack Where ShippingNo = @IndexNo;
		return 1;
	End




	IF @Module = 'Bill'
	Begin
		If Not Exists(Select * From YouEx_XmlBill Where BillNo = @IndexNo)
			Return 0;

		Delete From YouEx_XmlBill Where BillNo = @IndexNo;
		return 1;
	End




	IF @Module = 'Log'
	Begin
		If Not Exists(Select * From YouEx_XmlLog Where LogNo = @IndexNo)
			Return 0;
		Delete From YouEx_XmlLog Where LogNo = @IndexNo;
		return 1;
	End
	
	


	IF @Module = 'Service'
	Begin
		IF Not Exists(SELECT * FROM YouEx_XmlService WHERE ServiceNo = @IndexNo)
			Return 0;
		Delete From YouEx_XmlService Where ServiceNo = @IndexNo;
		Return 1;
	End
	
	
	
	
	IF @Module = 'User'
	Begin
		IF Not Exists(SELECT * FROM YouEx_XmlUser WHERE UserId = Convert(int, @IndexNo))
			Return -1;
		Delete From YouEx_XmlUser Where UserId = Convert(int, @IndexNo);
		Return 1;
	End
END

