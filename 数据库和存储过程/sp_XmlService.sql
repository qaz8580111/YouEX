USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlService]    Script Date: 02/04/2016 10:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlService]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		dateTime,
	@EndTime		dateTime,
	@ServiceName	nvarchar(50),
	
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
	
	IF (@CommandType <= 2)
	Begin
		Select @ServiceNo = @Content.value('(/Root/Service/ServiceNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Service/DepotId)[1]', 'int');
		Select @UserId = @Content.value('(/Root/Service/UserId)[1]', 'int');
		Select @AgentId = @Content.value('(/Root/Service/AgentId)[1]', 'int');
		Select @PackageNo = @Content.value('(/Root/Service/PackageNo)[1]', 'nvarchar(50)');
		Select @AccessStatus = @Content.value('(/Root/Service/AccessStatus)[1]', 'int');
		Select @ServiceCode = @Content.value('(/Root/Service/ServiceCode)[1]', 'nvarchar(50)');
		Select @PayStatus = @Content.value('(/Root/Service/PayStatus)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Service/CreateTime)[1]', 'DateTime');
		Select @AccessTime = @Content.value('(/Root/Service/AccessTime)[1]', 'DateTime');
	End
	
	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_XmlService WHERE ServiceNo = @ServiceNo)
			Return -1;

		INSERT INTO YouEx_XmlService(ServiceNo, DepotId, UserId, AgentId, PackageNo, AccessStatus, PayStatus, ServiceCode, CreateTime, AccessTime, Content)
			VALUES(@ServiceNo, @DepotId, @UserId, @AgentId, @PackageNo, @AccessStatus, @PayStatus, @ServiceCode, @CreateTime, @AccessTime, @Content);

		Return 1;
	End
	

	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlService WHERE ServiceNo = @ServiceNo)
			Return 0;

		Update YouEx_XmlService Set 
				DepotId = @DepotId,
				UserId = @UserId,
				AgentId = @AgentId,
				PackageNo = @PackageNo,
				AccessStatus = @AccessStatus,
				PayStatus = @PayStatus,
				ServiceCode = @ServiceCode,
				CreateTime = @CreateTime,
				AccessTime = @AccessTime,
				[Content] = @Content
			Where ServiceNo = @ServiceNo;

		return 1;
	End
	
	
	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlService WHERE ServiceNo = @ServiceNo)
			Return 0;

		Delete From YouEx_XmlService Where ServiceNo = @ServiceNo;
		Return 1;
	End
	

	IF(@CommandType = 4)
	Begin
		-- 按ServiceNo查询
		IF (@SelectType = 1)
		Begin
			Select * From YouEx_XmlService Where ServiceNo = @ServiceNo;
			Return 1;
		End

		-- 按UserId查询
		IF (@SelectType = 2)
		Begin
			Select * From YouEx_XmlService Where UserId = @UserId;
			Return 2;
		End
		
		-- 按AgentId查询
		IF (@SelectType = 3)
		Begin
			Select * From YouEx_XmlService Where AgentId = @AgentId;
			Return 3;
		End

		-- 按PackageNo查询
		IF (@SelectType = 4)
		Begin
			Select * From YouEx_XmlService Where PackageNo = @PackageNo;
			Return 4;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';
		
		-- 按DepotId值查询
		IF (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' DepotId = ' + ltrim(str(@DepotId)) + ' And';

		-- 按AccessStatus值查询
		IF (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' AccessStatus = ' + ltrim(str(@AccessStatus)) + ' And';
		
		-- 按PayStatus值查询
		IF (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' PayStatus = ' + ltrim(str(@PayStatus)) + ' And';

		-- 按ServiceName值查询
		IF (@SelectType & 64) <> 0
		Begin
			Select @ServiceCode = ServiceCode From YouEx_ServiceEx Where ServiceName = @ServiceName;
			Select @strCmd = @strCmd + ' ServiceCode = ' + ltrim(@ServiceCode) + ' And';
		End

		-- 按ServiceCode值查询
		IF (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' ServiceCode = ' + ltrim(@ServiceCode) + ' And';

		/*按创建时间查询*/
		IF (@SelectType & 256) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime) + ''' And';
		
		IF @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_XmlService Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End

END

