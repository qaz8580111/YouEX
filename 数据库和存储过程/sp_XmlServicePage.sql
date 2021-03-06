USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlServicePage]    Script Date: 02/04/2016 10:17:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlServicePage]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,

	@ServiceNo		nvarchar(50),
	@DepotId		int,
	@UserId			int,
	@AgentId		int,
	@PackageNo		nvarchar(50),
	@AccessStatus	int,
	@PayStatus		int,
	@ServiceCode	nvarchar(50),
	@CreateTime		dateTime,
	@AccessTime		dateTime,
	@Content		Xml
)
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CommandType = 4)
	Begin
		
	--按分页查询
	IF (@SelectType & 1) <> 0
		SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER 
		(ORDER BY YouEx_XmlService.ServiceNo DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_XmlService
		where UserId = @UserId) AS temp 
		WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		
	End
	
	Return 0;
END

