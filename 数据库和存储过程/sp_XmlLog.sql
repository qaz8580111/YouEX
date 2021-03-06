USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlLog]    Script Date: 02/04/2016 10:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlLog]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,
	@WhereStr		nvarchar(1000),

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

	IF(@CommandType = 1)
	Begin
		IF Exists(Select * From YouEx_XmlLog Where LogNo = @LogNo)
			Return -1;

		INSERT INTO YouEx_XmlLog (LogNo, [Type], IndexNo, [Action], CreateTime,Content)
			VALUES(@LogNo, @Type, @IndexNo, @Action, @CreateTime, @Content);

		Return 1;
	End
	

	IF(@CommandType = 2)
	Begin
		Return 0;
	End
	

	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_XmlLog Where LogNo = @LogNo)
			Return 0;

		Delete From YouEx_XmlLog Where LogNo = @LogNo;
		return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按LogNo查询
		If @SelectType = 1
		Begin
			Select * From YouEx_XmlLog Where LogNo = @LogNo;
			Return 1;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';		
		
		-- 按WhereStr查询
		If @SelectType = 2
		Begin
			IF @WhereStr = ''
				Return -1;
			
			Select @strCmd = 'Select * From YouEx_XmlLog Where ' + @WhereStr;
			Print(@strCmd);
			Exec(@strCmd);
			Return 2;
		End
		
		
		-- 按Type查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';

		-- 按IndexNo查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' IndexNo = ''' + ltrim(@IndexNo) + ''' And';

		-- 按Action查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' [Action] = ''' + ltrim(@Action) + ''' And';

		-- 按创建时间查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';
		
		If @strCmd = ''
			return -1;

		Select @strCmd = 'Select * From YouEx_XmlLog Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End
	
	Return 0;
END

