USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlPackage]    Script Date: 02/04/2016 10:16:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_XmlPackage]
(
	@CommandType	int,
	@SelectType		int,
	@StatusList		nvarchar(200),
	@BeginTime		DateTime,
	@EndTime		DateTime,
	@WhereStr		nvarchar(1000),
	@Result			nvarchar(50) out,
	
	@PackageNo		nvarchar(50),
	@OrderNo		nvarchar(50),
	@Type			int,
	@DepotId		int,
	@UserId			int,
	@AgentId		int,
	@StorageNo		nvarchar(50),
	@ShippingNo		nvarchar(50),
	@Status			int,
	@Content		xml
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Declare @CreateTime datetime;
	Declare @StorageTime datetime;
	IF (@CommandType <= 2)
	Begin
		Select @PackageNo = @Content.value('(/Root/Package/PackageNo)[1]', 'nvarchar(50)');
		Select @OrderNo = @Content.value('(/Root/Package/OrderNo)[1]', 'nvarchar(50)');
		Select @Type = @Content.value('(/Root/Package/Type)[1]', 'int');
		Select @DepotId = @Content.value('(/Root/Package/DepotId)[1]', 'int');
		Select @UserId = @Content.value('(/Root/Package/UserId)[1]', 'int');
		Select @AgentId = @Content.value('(/Root/Package/AgentId)[1]', 'int');
		Select @StorageNo = @Content.value('(/Root/Package/StorageNo)[1]', 'nvarchar(50)');
		Select @ShippingNo = @Content.value('(/Root/Package/ShippingNo)[1]', 'nvarchar(50)');
		Select @Status = @Content.value('(/Root/Package/Status)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Package/CreateTime)[1]', 'DateTime');

		Declare @strStorageTime nvarchar(50);
		Select @strStorageTime = @Content.value('(/Root/Package/StorageTime)[1]', 'nvarchar(50)');
		IF @strStorageTime = ''
			Select @StorageTime = null;
		else
			Select @StorageTime = @Content.value('(/Root/Package/StorageTime)[1]', 'DateTime');
	End
	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_Package WHERE PackageNo = @PackageNo)
			Return -1

		IF @ShippingNo <> ''
		Begin
			IF EXISTS(SELECT * FROM YouEx_Package WHERE ShippingNo = @ShippingNo)
				Return -2;
		End
		
		Begin Transaction;
		/*无头件临时库位号生成*/
		IF @StorageNo = ''
		Begin
			Declare @Index int;
			Exec @Index = rm_GetIdentify 'NoMaster', @DepotId, 0, @StorageNo Output;
		End
		
		INSERT INTO YouEx_Package (PackageNo, OrderNo, [Type], DepotId, UserId, AgentId, StorageNo, CreateTime, StorageTime, [Status], ShippingNo, Content)
			VALUES(@PackageNo, @OrderNo, @Type, @DepotId, @UserId, @AgentId, @StorageNo, @CreateTime, @StorageTime, @Status, @ShippingNo, @Content);

		COMMIT TRANSACTION;

		Select @Result = @PackageNo;
		Return 1;
	End
	
	
	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Package WHERE PackageNo = @PackageNo)
			Return 0;

		Update YouEx_Package Set
			OrderNo = @OrderNo,
			[Type] = @Type,
			UserId = @UserId,
			AgentId = @AgentId,
			StorageNo = @StorageNo,
			ShippingNo = @ShippingNo,
			[Status] = @Status,
			StorageTime = @StorageTime,
			Content = @Content
			Where PackageNo = @PackageNo;
		
		return 1;
	End
	
	
	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Package WHERE PackageNo = @PackageNo)
			Return 0;
		Delete From YouEx_Package Where PackageNo = @PackageNo;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		--按PackageNo查询
		If @SelectType = 1
		Begin
			Select * From YouEx_Package Where PackageNo = @PackageNo;
			Return 2;
		End
		
		--按ShippingNo查询
		If @SelectType = 2
		Begin
			Declare @AccessReady int;
			Select @AccessReady = 0;
			IF Exists(Select * From YouEx_Package Where (ShippingNo = @ShippingNo) And (OrderNo <> ''))
			Begin
				Select @OrderNo = OrderNo From YouEx_Package Where (ShippingNo = @ShippingNo) And (OrderNo <> '')
				Declare @PackageNumber int;
				Select @PackageNumber = COUNT(*) From YouEx_Package Where OrderNo = @OrderNo;
				IF @PackageNumber = 1
					Select @AccessReady = 1;
			End
			
			IF Exists(Select * From YouEx_Package Where ShippingNo = @ShippingNo)
				Select *, @AccessReady as 'AccessReady' From YouEx_Package Where ShippingNo = @ShippingNo;
			Else
				Select *, @AccessReady as 'AccessReady' From YouEx_Package Where (@ShippingNo like '%' + ShippingNo) and (ShippingNo <> '');
			
			return 2;
		End

		--按WhereStr查询
		If @SelectType = 3
		Begin
			Select @strCmd = 'Select * From YouEx_Package Where ' + Rtrim(@WhereStr);
			Exec(@strCmd);
			Return 3;
		End

		--按OrderNo值查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' OrderNo = ''' + @OrderNo + ''' And';

		--按UserId查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';
			
		--按AgentId查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' AgentId = ' + ltrim(str(@AgentId)) + ' And';

		--按StorageNo值查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' StorageNo = ''' + @StorageNo + ''' And';
			
		--按Status值查询
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' Status = ' + ltrim(str(@Status)) + ' And';
		
		--按StatusList值查询
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' Status in (' + @StatusList + ') And';

		--按Type值查询
		If (@SelectType & 256) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';

		--按DepotId值查询
		If (@SelectType & 512) <> 0
			Select @strCmd = @strCmd + ' DepotId = ' + ltrim(str(@DepotId)) + ' And';

		--按创建时间查询
		If (@SelectType & 1024) <> 0
			Select @strCmd = @strCmd + ' CreateTime > ''' + Convert(nvarchar, @BeginTime) + ''' And CreateTime < ''' + Convert(nvarchar, @EndTime) + ''' And';

		--按入库时间查询
		If (@SelectType & 2048) <> 0
			Select @strCmd = @strCmd + ' StorageTime > ''' + Convert(nvarchar, @BeginTime) + ''' And StorageTime < ''' + Convert(nvarchar, @EndTime) + ''' And';
		
		If @strCmd = ''
			return 0;

		Select @strCmd = 'Select * From YouEx_Package Where' + Rtrim(@strCmd) + ' 1 = 1' ;
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End

END
