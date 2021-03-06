USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_UpdateFile]    Script Date: 02/04/2016 10:20:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_UpdateFile]
(
	@AdminId	int,
	@UserId		int,
	@Title		nvarchar(50),
	@Module		int,
	@CreateTime	datetime,
	@PathFile	nvarchar(500)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @Path	nvarchar(200),
			@File	nvarchar(100);

	IF @PathFile = ''
		Return 0;

	Declare @Length int;
	Declare @Index int;
	Declare @Pos int;

	Select @Index = 1;

	Select @Length = LEN(@PathFile);
	Select @Pos = CHARINDEX('/', @PathFile, @Index);
	
	IF @Pos > 0
	Begin
		while (@Pos > 0) And (@Pos < @Length)
		Begin
			Select @Index = @Pos;
			Select @Pos = CHARINDEX('/', @PathFile, @Index + 1);
		End
		Select @Path = SUBSTRING(@PathFile, 1, @Index - 1);
		Select @File = SUBSTRING(@PathFile, @Index + 1, @Length - @Index);
		Select @Path = REPLACE(@Path, '~/upfiles/images', '2012-2015');
		Select @Path = REPLACE(@Path, '/upfiles/images', '2012-2015');
		Select @Path = REPLACE(@Path, '../../uploadCard/cardimage', '2012-2015');
		Select @Path = REPLACE(@Path, '/upfiles', '2012-2015');
	End
	Else
	Begin
		Select @Path = '';
		Select @File = @PathFile;
	End
	
	IF Exists(Select * From YouEx_File Where [FileName] = @File and FilePath = @Path)
	Begin
		Select @AdminId = Id From YouEx_File Where [FileName] = @File and FilePath = @Path;
		Return @AdminId;
	End
	
	INSERT INTO YouEx_File (AdminId, UserId, Title, Module, [FileName], FilePath, CreateTime, VisitTimes)
		VALUES(@AdminId, @UserId, @Title, @Module, @File, @Path, @CreateTime, 0);

	Return @@IDENTITY;
END
