USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 02/04/2016 10:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_User]
(
	@CommandType	int,
	@SelectType		int,
	@StatusList		nvarchar(200),
	@BeginTime		DateTime,
	@EndTime		DateTime,
	
	@Id				int,
	@Type			int,
	@Role			int,
	@UserName		nvarchar(50),
	@Password		nvarchar(50),
	@Status			int,
	@FirstName		nvarchar(50),
	@LastName		nvarchar(50),
	@RealName		nvarchar(50),
	@Gender			int,
	@Birthday		DateTime,
	@Email			nvarchar(50),
	@Mobile			nvarchar(50),
	@Phone			nvarchar(50),
	@WeiXin			nvarchar(50),
	@RegIP			nvarchar(50),
	@RegTime		DateTime,
	@LastIp			nvarchar(50),
	@LastLogin		DateTime,
	@LoginTimes		int,
	@StorageNo		nvarchar(50),
	@Source			int,
	@DefaultCurrency	int,
	@Remark			nvarchar(200)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		/*IF EXISTS(SELECT * FROM YouEx_User WHERE UserName = @UserName)
			Return -1;*/
		IF EXISTS(SELECT * FROM YouEx_User WHERE (Email = @Email) and (@Email <> ''))
			Return -2;
		IF EXISTS(SELECT * FROM YouEx_User WHERE (Mobile = @Mobile) and (@Mobile <> ''))
			Return -3;
		IF EXISTS(SELECT * FROM YouEx_User WHERE (WeiXin = @WeiXin) and (@WeiXin <> ''))
			Return -4;
			
		INSERT INTO YouEx_User ([Type] ,[Role] ,UserName ,[Password] ,[Status] ,FirstName ,LastName ,RealName ,Gender ,Birthday ,Email ,Mobile ,Phone ,WeiXin ,RegIP ,RegTime ,LastIp ,LastLogin ,LoginTimes ,StorageNo ,Source ,DefaultCurrency ,Remark)
				VALUES(@Type ,@Role ,@UserName ,@Password ,@Status ,@FirstName ,@LastName ,@RealName ,@Gender ,@Birthday ,@Email ,@Mobile ,@Phone ,@WeiXin ,@RegIP ,@RegTime ,@LastIp ,@LastLogin ,@LoginTimes ,@StorageNo ,@Source ,@DefaultCurrency ,@Remark);

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_User WHERE Id = @Id)
			Return 0;
		
		/*If Exists (Select * From YouEx_User Where (Id <> @Id) And ((Email = @Email) Or (@Email <> '')))
			Return -1;
		
		If Exists (Select * From YouEx_User Where (Id <> @Id) And ((Mobile = @Mobile) Or (@Mobile <> '')))
			Return -2;

		If Exists (Select * From YouEx_User Where (Id <> @Id) And ((WeiXin = @WeiXin) Or (@WeiXin <> '')))
			Return -3;*/
		

		Update YouEx_User Set 
				[Type] = @Type,
				[Role] = @Role,
				[Password] = @Password,
				[Status] = @Status,
				FirstName = @FirstName,
				LastName = @LastName,
				RealName = @RealName,
				Gender = @Gender,
				Birthday = @Birthday,
				Email = @Email,
				Mobile = @Mobile,
				Phone = @Phone,
				WeiXin = @WeiXin,
				LastIp = @LastIp,
				LastLogin = @LastLogin,
				LoginTimes = @LoginTimes,
				StorageNo = @StorageNo,
				DefaultCurrency = @DefaultCurrency,
				Remark = @Remark
			Where Id = @Id;
		
		return 1;
	End


	IF(@CommandType = 3)
	Begin
		Return 0;
	End


	IF(@CommandType = 4)
	Begin
		/*按Id查询*/
		If @SelectType = 1
		Begin
			Select * From YouEx_User Where Id = @Id;
			return 1;
		End

		/*按UserName查询*/
		If @SelectType = 2
		Begin
			Select * From YouEx_User Where (UserName = @UserName) And (@UserName <> '');
			return 2;
		End

		/*按UserNameEn查询*/
		If @SelectType = 3
		Begin
			Select * From YouEx_User Where (FirstName = @FirstName) And (LastName = @LastName) And (@FirstName <> '') And (@LastName <> '');
			return 3;
		End

		/*按RealName查询*/
		If @SelectType = 4
		Begin
			Select * From YouEx_User Where (RealName = @RealName) And (@RealName <> '');
			return 4;
		End

		/*按Email查询*/
		If @SelectType = 5
		Begin
			Select * From YouEx_User Where (Email = @Email) And (@Email <> '');
			return 5;
		End

		/*按Mobile查询*/
		If @SelectType = 6
		Begin
			Select * From YouEx_User Where (Mobile = @Mobile) And (@Mobile <> '');
			return 6;
		End

		/*按WeiXin查询*/
		If @SelectType = 7
		Begin
			Select * From YouEx_User Where (WeiXin = @WeiXin) And (@WeiXin <> '');
			return 7;
		End
		
		/*按StorageNo查询*/
		If @SelectType = 8
		Begin
			Select * From YouEx_User Where (StorageNo = @StorageNo) And (@StorageNo <> '');
			return 8;
		End

		/*按Login查询*/
		If @SelectType = 9
		Begin
			Select * From YouEx_User Where ([Status] = 1) And ([Password] = @Password) And (((Email = @Email) And (@Email <> '')) Or ((Mobile = @Mobile) And (@Mobile <> '')));
			return 9;
		End


		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		/*按Type查询*/
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' Type = ' + ltrim(str(@Type)) + ' And';

		/*按Role查询*/
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' Role = ' + ltrim(str(@Role)) + ' And';
		
		/*按Status值查询*/
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' Status = ' + ltrim(str(@Status)) + ' And';

		/*按创建时间查询*/
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' RegTime > ''' + Convert(nvarchar, @BeginTime, 21) + ''' And RegTime < ''' + Convert(nvarchar, @EndTime, 21) + ''' And';
		
		If @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_User Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 10;
	End
	
	Return 0;

END
