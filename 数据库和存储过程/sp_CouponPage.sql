USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_CouponPage]    Script Date: 02/04/2016 10:12:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_CouponPage]
(
	@CommandType		int,
	@SelectType			int,
	@PageSize			int,
	@PageIndex			int,

	@CouponNo			nvarchar(50),
	@CouponId			int,
	@Status				int,
	@OwnerId			int,
	@UserId				int,
	@CreateTime			datetime,
	@InvalidTime		datetime,
	@UsedTime			nvarchar(50),
	@Source				nvarchar(50),
	@Message			nvarchar(300)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 4)
	Begin
		
	--按分页查询
	IF (@SelectType & 1) <> 0
		SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER 
		(ORDER BY YouEx_Coupon.CouponNo DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_Coupon 
		where Status = @Status and UserId = @UserId) AS temp 
		WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		
	End
	
	Return 0;

END
