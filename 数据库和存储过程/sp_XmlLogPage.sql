USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlLogPage]    Script Date: 02/04/2016 10:16:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlLogPage]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,
	
	@LogNo			nvarchar(50),
	@Type			int,
	@IndexNo		nvarchar(50),
	@Action			nvarchar(50),
	@CreateTime		DateTime,
	@Content		Xml
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 4)
	Begin	
	
	--按账户分页查询
		IF (@SelectType & 1) <> 0
			SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER 
			(ORDER BY YouEx_XmlLog.LogNo DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_XmlLog 
			where Type = @Type and IndexNo = @IndexNo) AS temp 
			WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
	End
	
	Return 0;
END

