USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_File]    Script Date: 02/04/2016 10:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_File]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		datetime,
	@EndTime		datetime,
	@ModuleName		nvarchar(50),


	@Id				int,
	@AdminId		int,
	@UserId			int,
	@Title			nvarchar(50),
	@Module			int,
	@FileName		nvarchar(50),
	@FilePath		nvarchar(100),
	@CreateTime		datetime,
	@VisitTimes		int
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		IF(@ModuleName = '')
			Select @ModuleName = 'Temp';
		Select @Module = Value From YouEx_SystemEnum Where [Type] = 'File' and Name = @ModuleName;
		
		/*发现存在各项信息相同，且创建时间上不超过一天的，认为是重复项*/
		IF EXISTS(Select * From YouEx_File Where (AdminId = @AdminId) and (UserId = @UserId) and (Title = @Title) and (Module = @Module) and ([FileName] = @FileName) and (DATEDIFF(hour, CreateTime, GETDATE()) <= 24))
			Return 0;
	
		INSERT INTO YouEx_File (AdminId, UserId, Title, Module, [FileName], FilePath, CreateTime, VisitTimes)
			VALUES(@AdminId, @UserId, @Title, @Module, @FileName, @FilePath, GETDATE(), 0);

		Return @@IDENTITY;
	End
	
	
	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_File WHERE Id = @Id)
			Return 0;

		Update YouEx_File Set 
				AdminId = @AdminId,
				UserId = @UserId,
				Title = @Title,
				Module = @Module,
				[FileName] = @FileName,
				FilePath = @FilePath,
				CreateTime = @CreateTime,
				VisitTimes = @VisitTimes
			Where Id = @Id;
		
		Return 1;
	End


	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_File Where Id = @Id)
			Return 0;

		Delete From YouEx_File Where Id = @Id;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		/*按Id查询*/
		IF @SelectType = 1
		Begin
			Select A.*, B.Name as ModuleName, B.Content as ModulePath From YouEx_File A inner join YouEx_SystemEnum B on A.Module = B.Value And B.[Type] = 'File' Where A.Id = @Id;
			Update YouEx_File Set VisitTimes = VisitTimes + 1 Where Id = @Id;
			Return 1;
		End

		/*AdminId*/
		IF (@SelectType & 2) <> 0
			Select @strCmd = @strCmd + ' A.AdminId = ' + ltrim(str(@AdminId)) + ' And';

		/*UserId*/
		IF (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' A.UserId = ' + ltrim(str(@UserId)) + ' And';

		/*Title*/
		IF (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' A.Title = ''' + @Title + ''' And';

		/*ModuleName*/
		IF (@SelectType & 16) <> 0
		Begin
			Select @Module = 1;
			Select @Module = Value From YouEx_SystemEnum Where [Type] = 'File' and Name = @ModuleName;
			Select @strCmd = @strCmd + ' A.Module = ' + ltrim(str(@Module)) + ' And';
		End

		/*按创建时间查询*/
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' A.CreateTime > ''' + Convert(nvarchar, @BeginTime) + ''' And A.CreateTime < ''' + Convert(nvarchar, @EndTime) + ''' And';

		Select @strCmd = 'Select A.*, B.Name as ModuleName, B.Content as ModulePath From YouEx_File A inner join YouEx_SystemEnum B on A.Module = B.Value And B.[Type] = ''File'' Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End
	Return 0;
END
