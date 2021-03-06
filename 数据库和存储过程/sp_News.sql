USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_News]    Script Date: 02/04/2016 10:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_News]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,
	
	@NewsId			int,
    @Type			int,
    @Title			nvarchar(50),
    @TitleImage		nvarchar(max),
    @Description	nvarchar(max),
    @AuthorName		nvarchar(50),
    @CreateTime		DateTime,
    @UpdateTime		DateTime,
    @MetaKey		nvarchar(50),
    @ContentImage	nvarchar(max),
    @Content		nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(@CommandType = 1)
	Begin
		INSERT INTO YouEx_News([Type], [Title], [Description], [AuthorName], [CreateTime], [MetaKey], [Content])
			VALUES(@Type, @Title, @Description, @AuthorName, @CreateTime, @MetaKey, @Content);

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_News WHERE NewsId = @NewsId)
			Return 0;

		Update YouEx_News Set 
				[Type] = @Type,
				[Title] = @Title,
				[Description] = @Description,
				[AuthorName] = @AuthorName,
				[UpdateTime] = @UpdateTime,
				[MetaKey] = @MetaKey,
				[Content] = @Content
			Where NewsId = @NewsId;
		
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_News WHERE NewsId = @NewsId)
			Return 0;
		Delete From YouEx_News Where NewsId = @NewsId;
		Return 1;
	End
	
	IF(@CommandType = 4)
	Begin	
	-- 按NewsId查询
		If (@SelectType = 1)
		Begin
			Select * From YouEx_News Where NewsId = @NewsId;			
			Return 1;
		End
	
	--按分页查询
		IF (@SelectType & 2) <> 0
		Begin
			SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER
			(ORDER BY YouEx_News.NewsId DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_News
			where Type = @Type) AS temp 
			WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		End
	--按分页查询
		IF (@SelectType & 4) <> 0
		Begin
			SELECT  *FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER
			(ORDER BY YouEx_News.NewsId DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_News) AS temp 
			WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		End
	End
	
	Return 0;
END

