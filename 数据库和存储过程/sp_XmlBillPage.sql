USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlBillPage]    Script Date: 02/04/2016 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlBillPage]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,
	
	@BillNo			nvarchar(50),
	@Type			int,
	@IndexNo		nvarchar(50),
	@DepotId		int,
	@UserId			int,
	@AgentId		int,
	@AutoPay		int,
	@PayStatus		int,
	@PayMode		int,
	@CreateTime		DateTime,
	@PayTime		DateTime,
	@Content		Xml
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 4)
	Begin	
	
	--按账单分页查询
		IF (@SelectType & 1) <> 0
			SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER
			(ORDER BY YouEx_OrderBill.BillNo DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_OrderBill
			where UserId = @UserId and PayStatus = @PayStatus) AS temp 
			WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
	End
	
	Return 0;
END

