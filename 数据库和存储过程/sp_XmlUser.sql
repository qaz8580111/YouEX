USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlUser]    Script Date: 02/04/2016 10:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_XmlUser]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,
	
	@UserId			int,
	@UserNo			nvarchar(50),
	@Type			int,
	@Role			int,
	@UserName		nvarchar(50),
	@Password		nvarchar(50),
	@Status			int,

	@Email			nvarchar(50),
	@Mobile			nvarchar(50),
	@WeiXin			nvarchar(50),
	@StorageNo		nvarchar(50),
	@RegTime		datetime,
	@Content		xml
)
AS
BEGIN
	SET NOCOUNT ON;
	IF (@CommandType <= 2)
	Begin
		--Select @UserId = @Content.value('(/Root/User/UserId)[1]', 'int');
		Select @UserNo = @Content.value('(/Root/User/UserNo)[1]', 'nvarchar(50)');
		Select @Type = @Content.value('(/Root/User/Type)[1]', 'int');
		Select @Role = @Content.value('(/Root/User/Role)[1]', 'int');
		Select @UserName = @Content.value('(/Root/User/UserName)[1]', 'nvarchar(50)');
		Select @Password = @Content.value('(/Root/User/Password)[1]', 'nvarchar(50)');
		Select @Status = @Content.value('(/Root/User/Status)[1]', 'int');
		Select @Email = @Content.value('(/Root/User/Email)[1]', 'nvarchar(50)');
		Select @Mobile = @Content.value('(/Root/User/Mobile)[1]', 'nvarchar(50)');
		Select @WeiXin = @Content.value('(/Root/User/WeiXin)[1]', 'nvarchar(50)');
		Select @StorageNo = @Content.value('(/Root/User/StorageNo)[1]', 'nvarchar(50)');
		Select @RegTime = @Content.value('(/Root/User/RegTime)[1]', 'DateTime');
	End

	IF(@CommandType = 1)
	Begin
		IF (@Email <> '') and EXISTS(SELECT * FROM YouEx_XmlUser WHERE Email = @Email)
			Return -1;
		IF (@UserName <> '') and EXISTS(SELECT * FROM YouEx_XmlUser WHERE UserName = @UserName)
			Return -2;
		IF (@Mobile <> '') and EXISTS(SELECT * FROM YouEx_XmlUser WHERE Mobile = @Mobile)
			Return -3;
		IF (@WeiXin <> '') and EXISTS(SELECT * FROM YouEx_XmlUser WHERE WeiXin = @WeiXin)
			Return -4;

		INSERT INTO YouEx_XmlUser (UserNo, [Type], [Role], UserName, [Password], [Status], Email, Mobile, WeiXin, StorageNo, RegTime, Content)
				VALUES(@UserNo, @Type, @Role, @UserName, @Password, @Status, @Email, @Mobile, @WeiXin, @StorageNo, @RegTime, @Content);
				
		Select @UserId = @@IDENTITY;
		Update YouEx_XmlUser Set Content.modify('insert text{sql:variable("@UserId")} into (//User/UserId)[1]') Where UserId = @UserId;
		Return @UserId;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlUser WHERE UserId = @UserId)
			Return -1;
		
		-- 修改手机号码
		IF Exists (Select * From YouEx_XmlUser Where (UserId = @UserId) And (Mobile <> @Mobile))
		Begin
			-- 不允许与其它帐号的手机号码相同
			IF (@Mobile <> '') and Exists (Select * From YouEx_XmlUser Where (UserId <> @UserId) And (Mobile = @Mobile))
				Return -2;
			-- 不允许将已有的手机号码去掉
			IF (@Mobile = '')
				Return -3;
		End

		-- 修改微信号
		IF Exists (Select * From YouEx_XmlUser Where (UserId = @UserId) And (WeiXin <> @WeiXin))
		Begin
			-- 不允许与其它帐号的微信号相同
			IF (@WeiXin <> '') and Exists (Select * From YouEx_XmlUser Where (UserId <> @UserId) And (WeiXin = @WeiXin))
				Return -4;
			-- 不允许将已有的微信号去掉
			IF (@WeiXin = '')
				Return -5;
		End
		

		Update YouEx_XmlUser Set 
--				UserNo = @UserNo,
				[Type] = @Type,
				[Role] = @Role,
				[Password] = @Password,
				[Status] = @Status,
--				Email = @Email,
				Mobile = @Mobile,
				WeiXin = @WeiXin,
				StorageNo = @StorageNo,
				Content = @Content
			Where UserId = @UserId;
		
		return 1;
	End


	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlUser WHERE UserId = @UserId)
			Return -1;

		Delete From YouEx_XmlUser Where UserId = @UserId;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按UserId查询
		If @SelectType = 1
		Begin
			Select * From YouEx_XmlUser Where UserId = @UserId;
			return 1;
		End
		
		-- 按UserNo查询，目前保留
		If @SelectType = 2
		Begin
			Select * From YouEx_XmlUser Where (UserNo = @UserNo) And (@UserNo <> '');
			return 2;
		End

		-- 按UserName查询
		If @SelectType = 3
		Begin
			Select * From YouEx_XmlUser Where (UserName = @UserName) And (@UserName <> '');
			return 3;
		End


		-- 按Email查询
		If @SelectType = 4
		Begin
			Select * From YouEx_XmlUser Where (Email = @Email) And (@Email <> '');
			return 4;
		End

		-- 按Mobile查询
		If @SelectType = 5
		Begin
			Select * From YouEx_XmlUser Where (Mobile = @Mobile) And (@Mobile <> '');
			return 5;
		End

		-- 按WeiXin查询
		If @SelectType = 6
		Begin
			Select * From YouEx_XmlUser Where (WeiXin = @WeiXin) And (@WeiXin <> '');
			return 6;
		End
		
		-- 按StorageNo查询
		If @SelectType = 7
		Begin
			Select * From YouEx_XmlUser Where (StorageNo = @StorageNo) And (@StorageNo <> '');
			return 7;
		End
		
		-- Login登录查询
		If @SelectType = 8
		Begin
			Select * From YouEx_XmlUser Where /*([Status] = 1) And*/ ([Password] = @Password) And (((Email = @Email) And (@Email <> '')) Or ((Mobile = @Mobile) And (@Mobile <> '')));
			return 8;
		End


		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		/*按Type查询*/
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';

		/*按Role查询*/
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' [Role] = ' + ltrim(str(@Role)) + ' And';
		
		/*按Status值查询*/
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' [Status] = ' + ltrim(str(@Status)) + ' And';

		/*按创建时间查询*/
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' RegTime >= ''' + Convert(nvarchar, @BeginTime) + ''' And RegTime <= ''' + Convert(nvarchar, @EndTime) + ''' And';
		
		If @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_XmlUser Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 10;
	End
	
	Return 0;

END
