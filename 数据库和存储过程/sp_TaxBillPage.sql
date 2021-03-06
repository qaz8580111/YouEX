USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_TaxBillPage]    Script Date: 02/04/2016 10:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_TaxBillPage]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,

	@TaxId				int,
	@TaxNo				nvarchar(50),
	@UserId				int,
	@ShippingNo			nvarchar(50),
	@PayStatus			int,
	@Image				nvarchar(50),
	@Money				decimal(18, 2),
	@PayId				nvarchar(50),
	@Phone				nvarchar(50),
	@NoticeTime			int,
	@CreateTime			datetime,
	@PayTime			datetime
)
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CommandType = 4)
	Begin
		
	--按分页查询
	IF (@SelectType & 1) <> 0
		SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER 
		(ORDER BY [YouEx_TaxBill].TaxId DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.[YouEx_TaxBill]
		where UserId = @UserId and PayStatus = @PayStatus) AS temp 
		WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		
	End
	
	Return 0;
END

