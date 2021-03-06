USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Comment]    Script Date: 03/11/2016 16:15:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Comment]
(
	@CommandType	int,
	@SelectType		int,
	@PageSize		int,
	@PageIndex		int,
	
	@CommentId		int,
	@NewsId			int,
    @UserId			int,
    @UpCount		int,
    @DownCount		int,
    @CreateTime		DateTime,
    @Content		nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(@CommandType = 1)
	Begin
		INSERT INTO YouEx_Comment([NewsId], [UserId], [UpCount], [DownCount], [CreateTime], [Content])
			VALUES(@NewsId, @UserId, @UpCount, @DownCount, @CreateTime, @Content);

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_News WHERE NewsId = @NewsId)
			Return 0;

		Update YouEx_Comment Set 
				[NewsId] = @NewsId,
				[UserId] = @UserId,
				[UpCount] = @UpCount,
				[DownCount] = @DownCount,
				[CreateTime] = @CreateTime,
				[Content] = @Content
			Where CommentId = @CommentId;
		
		return 1;
	End
	
	IF(@CommandType = 4)
	Begin	
	-- 按CommentId查询
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Comment Where CommentId = @CommentId;			
			Return 1;
		End
		
	-- 按NewsId查询
		If (@SelectType = 2)
		Begin
			Select * From YouEx_Comment Where NewsId = @NewsId;			
			Return 1;
		End
	
	--按分页查询
		IF (@SelectType & 4) <> 0
		Begin
			SELECT  * FROM    ( SELECT TOP ( @pageSize * @pageIndex )ROW_NUMBER() OVER
			(ORDER BY YouEx_Comment.CommentId DESC ) AS rownum ,*FROM  [YouEx3.0].dbo.YouEx_Comment 
			where NewsId = @NewsId) AS temp 
			WHERE   temp.rownum > ( @pageSize * ( @pageIndex - 1 ))  ORDER BY temp.rownum
		End
		
	End
	
	Return 0;
END

