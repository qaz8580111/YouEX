USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Agent]    Script Date: 02/04/2016 10:10:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Agent]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,
	
	@AgentId		int,
	@AgentNo		nvarchar(50),
	@Type			int,
	@AgentName		nvarchar(50),
	@Password		nvarchar(50),
	@Status			int,
	@RealName		nvarchar(50),
	@Email			nvarchar(100),
	@Mobile			nvarchar(50),
	@Phone			nvarchar(50),
	@WeiXin			nvarchar(50),
	@Address		nvarchar(300),
	@ZipCode		nvarchar(50),
	@IdCard			nvarchar(50),
	@CreateTime		datetime,
	@LastIp			nvarchar(50),
	@LastLogin		datetime,
	@LoginTimes		int,
	@DepotId		int,
	@StorageNo		nvarchar(50),
	@CurrencyCode	nvarchar(50),
	@Money			decimal(18, 2),
	@Credit			decimal(18, 2),
	@Score			decimal(18, 2),
	@Remark			nvarchar(300)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		IF (@AgentName = '') or EXISTS(SELECT * FROM YouEx_Agent WHERE AgentName = @AgentName)
			Return -1;
		IF (@Email <> '') and EXISTS(SELECT * FROM YouEx_Agent WHERE Email = @Email)
			Return -2;
		IF (@Mobile <> '') and EXISTS(SELECT * FROM YouEx_Agent WHERE Mobile = @Mobile)
			Return -3;
		IF (@WeiXin <> '') and EXISTS(SELECT * FROM YouEx_Agent WHERE WeiXin = @WeiXin)
			Return -4;
			
		INSERT INTO YouEx_Agent (AgentId, AgentNo, [Type], AgentName, [Password], [Status], RealName, Email, Mobile, Phone, WeiXin, [Address], ZipCode, IdCard, CreateTime, LastIp, LastLogin, LoginTimes, DepotId, StorageNo, CurrencyCode, [Money], Credit, Score, Remark)
				VALUES(@AgentId, @AgentNo, @Type, @AgentName, @Password, @Status, @RealName, @Email, @Mobile, @Phone, @WeiXin, @Address, @ZipCode, @IdCard, @CreateTime, @LastIp, @LastLogin, @LoginTimes, @DepotId, @StorageNo, @CurrencyCode, @Money, @Credit, @Score, @Remark);
				
		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Agent WHERE AgentId = @AgentId)
			Return -1;

		-- 修改邮箱
		IF Exists (Select * From YouEx_Agent Where (AgentId = @AgentId) And (Email <> @Email))
		Begin
			-- 不允许与其它帐号的邮箱相同
			IF (@Email <> '') and Exists (Select * From YouEx_Agent Where (AgentId <> @AgentId) And (Email = @Email))
				Return -2;
			-- 不允许将已有的手机号码去掉
			IF (@Email = '')
				Return -3;
		End
				
		-- 修改手机号码
		IF Exists (Select * From YouEx_Agent Where (AgentId = @AgentId) And (Mobile <> @Mobile))
		Begin
			-- 不允许与其它帐号的手机号码相同
			IF (@Mobile <> '') and Exists (Select * From YouEx_Agent Where (AgentId <> @AgentId) And (Mobile = @Mobile))
				Return -4;
			-- 不允许将已有的手机号码去掉
			IF (@Mobile = '')
				Return -5;
		End

		-- 修改微信号
		IF Exists (Select * From YouEx_Agent Where (AgentId = @AgentId) And (WeiXin <> @WeiXin))
		Begin
			-- 不允许与其它帐号的微信号相同
			IF (@WeiXin <> '') and Exists (Select * From YouEx_Agent Where (AgentId <> @AgentId) And (WeiXin = @WeiXin))
				Return -6;
			-- 不允许将已有的微信号去掉
			IF (@WeiXin = '')
				Return -7;
		End
		

		Update YouEx_Agent Set 
				[Type] = @Type,
				AgentName = @AgentName,
				[Password] = @Password,
				[Status] = @Status,
				RealName = @RealName,
				Email = @Email,
				Mobile = @Mobile,
				Phone = @Phone,
				WeiXin = @WeiXin,
				[Address] = @Address,
				ZipCode = @ZipCode,
				IdCard = @IdCard,
				CreateTime = @CreateTime,
				LastIp = @LastIp,
				LastLogin = @LastLogin,
				LoginTimes = @LoginTimes,
				DepotId = @DepotId,
				StorageNo = @StorageNo,
				CurrencyCode = @CurrencyCode,
				[Money] = @Money,
				Credit = @Credit,
				Score = @Score,
				Remark = @Remark
			Where AgentId = @AgentId;
		
		return 1;
	End


	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Agent WHERE AgentId = @AgentId)
			Return -1;

		Delete From YouEx_Agent Where AgentId = @AgentId;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按AgentId查询
		If @SelectType = 1
		Begin
			Select * From YouEx_Agent Where AgentId = @AgentId;
			return 1;
		End
		
		-- 按AgentNo查询，目前保留
		If @SelectType = 2
		Begin
			Select * From YouEx_Agent Where (AgentNo = @AgentNo) And (@AgentNo <> '');
			return 2;
		End

		-- 按AgentName查询
		If @SelectType = 3
		Begin
			Select * From YouEx_Agent Where (AgentName = @AgentName) And (@AgentName <> '');
			return 3;
		End


		-- 按Email查询
		If @SelectType = 4
		Begin
			Select * From YouEx_Agent Where (Email = @Email) And (@Email <> '');
			return 4;
		End

		-- 按Mobile查询
		If @SelectType = 5
		Begin
			Select * From YouEx_Agent Where (Mobile = @Mobile) And (@Mobile <> '');
			return 5;
		End

		-- 按WeiXin查询
		If @SelectType = 6
		Begin
			Select * From YouEx_Agent Where (WeiXin = @WeiXin) And (@WeiXin <> '');
			return 6;
		End
		
		-- 按DepotId, StorageNo查询
		If @SelectType = 7
		Begin
			Select * From YouEx_Agent Where (StorageNo = @StorageNo) And ((DepotId = 0) or (DepotId = @DepotId));
			return 7;
		End
		
		-- Login登录查询
		If @SelectType = 8
		Begin
			Select * From YouEx_Agent Where ([Password] = @Password) And (AgentName = @AgentName);
			return 8;
		End


		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		/*按Type查询*/
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';

		/*按Status值查询*/
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' [Status] = ' + ltrim(str(@Status)) + ' And';

		/*按创建时间查询*/
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' RegTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And RegTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';
		
		If @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_Agent Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 10;
	End
	
	Return 0;

END
