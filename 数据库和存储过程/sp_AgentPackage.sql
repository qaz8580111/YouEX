USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgentPackage]    Script Date: 02/04/2016 10:11:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_AgentPackage]
(
	@AdminId		int,
	@AgentId		int,
	@DepotId		int,
	@ShippingNo		nvarchar(50),
	@ScanShippingNo	nvarchar(50),
	@ShippingId		int,
	@Service		nvarchar(50),
	@PackageInfo	Xml,
	@Result			nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @OrderNo		nvarchar(50),
			@PackageNo		nvarchar(50),
			
			@StorageTime	datetime,
			@Content		Xml,
			@Status			int,
			@NewShippingNo	nvarchar(50),
			@ResName		nvarchar(50),
			@NewPackageNo	nvarchar(50),
			@ServiceNo		nvarchar(50),
			@UpdateTime		datetime,
			@NewShipping	nvarchar(50),
			@CreateTime		datetime,
			@Message		nvarchar(300),
			@TrackList		Xml,
			@TrackItem		Xml,
			@Return			int;

	Select @Result = '';
	IF Not Exists(Select * From YouEx_Package Where ShippingNo = @ShippingNo)
		Return -1;
	Select @PackageNo = PackageNo, @OrderNo = OrderNo From YouEx_Package Where ShippingNo = @ShippingNo;


	Begin Transaction;

	-- 修改原订单状态：订单状态为结束
	IF Not Exists(Select * From YouEx_XmlOrder Where OrderNo = @OrderNo)
		Return -2;

	Select @Status = 2;				-- ACCESS_STATUS.Over
	Select @Content = Content From YouEx_XmlOrder Where OrderNo = @OrderNo;
	Set @Content.modify('delete (/Root/Order/AccessStatus/text())');
	Set @Content.modify('insert text{sql:variable("@Status")} into (/Root/Order/AccessStatus)[1]');
	Update YouEx_XmlOrder Set
			AccessStatus = @Status,
			Content = @Content
		Where OrderNo = @OrderNo;
	
	
	-- 修改原包裹状态值：原包裹结束
	IF Not Exists(Select * From YouEx_Package Where PackageNo = @PackageNo)
	Begin
		Rollback Transaction;
		Return -3;
	End

	Select @Status = 5;				-- PACKAGE_STATUS.OverAccess
	Select @StorageTime = GETUTCDATE();
	Select @Content = Content From YouEx_Package Where PackageNo = @PackageNo;
	Set @Content.modify('delete (/Root/Package/Status/text())');
	Set @Content.modify('delete (/Root/Package/StorageTime/text())');
	Set @Content.modify('insert text{sql:variable("@Status")} into (/Root/Package/Status)[1]');
	Set @Content.modify('insert text{sql:variable("@StorageTime")} into (/Root/Package/StorageTime)[1]');

	Update YouEx_Package Set
			[Status] = @Status,
			StorageTime = @StorageTime,
			Content = @Content
		Where PackageNo = @PackageNo;


	-- 获取新运单号
	Select @ResName = ResName From YouEx_Shipping Where ShippingId = @ShippingId;
	Exec sp_GetResource @ResName, @DepotId, 0, @Result = @NewShippingNo out;
	Set @PackageInfo.modify('delete (/Root/Package/ShippingNo/text())');
	Set @PackageInfo.modify('insert text{sql:variable("@NewShippingNo")} into (/Root/Package/ShippingNo)[1]');
	
	-- 创建新包裹
	Exec @Return = sp_XmlCreate 'Package', @PackageInfo, @Result = @NewPackageNo out;
	IF @Return < 0
	Begin
		Rollback Transaction;
		Return -4;
	End

	
	-- 创建/更新增值服务
	Select @CreateTime = GETUTCDATE();
	IF  PatIndex('%Remove%', @Service) > 0
	Begin
		IF Exists(Select * From YouEx_XmlService Where (PackageNo = @PackageNo) and (ServiceCode = 'Remove'))
		Begin
			Select @Content = Content From YouEx_XmlService Where (PackageNo = @PackageNo) and (ServiceCode = 'Remove');
			Set @Content.modify('delete (/Root/Service/AccessStatus/text())');
			Set @Content.modify('delete (/Root/Service/AccessTime/text())');
			Set @Content.modify('insert text{"2"} into (/Root/Service/AccessStatus)[1]');
			Set @Content.modify('insert text{sql:variable("@CreateTime")} into (/Root/Service/AccessTime)[1]');
			Update YouEx_XmlService Set
					AccessStatus = 2,
					AccessTime = @CreateTime,
					Content = @Content
				Where (PackageNo = @PackageNo) and (ServiceCode = 'Remove');
		End
		Else
		Begin
			Set @Content = dbo.CreateService('', @DepotId, 0, @AgentId, @PackageNo, 2, 0, 'Remove', '去泡服务', 0, 1, '', '', @AdminId, '', '', @CreateTime, @CreateTime);
			Exec @Return = sp_XmlCreate 'Service', @Content, @Result = @ServiceNo out;
		End
	End
	
	IF  PatIndex('%Fasten%', @Service) > 0
	Begin
		IF Exists(Select * From YouEx_XmlService Where (PackageNo = @PackageNo) and (ServiceCode = 'Fasten'))
		Begin
			Select @Content = Content From YouEx_XmlService Where (PackageNo = @PackageNo) and (ServiceCode = 'Fasten');
			Set @Content.modify('delete (/Root/Service/AccessStatus/text())');
			Set @Content.modify('delete (/Root/Service/AccessTime/text())');
			Set @Content.modify('insert text{"2"} into (/Root/Service/AccessStatus)[1]');
			Set @Content.modify('insert text{sql:variable("@CreateTime")} into (/Root/Service/AccessTime)[1]');
			Update YouEx_XmlService Set
					AccessStatus = 2,
					AccessTime = @CreateTime,
					Content = @Content
				Where (PackageNo = @PackageNo) and (ServiceCode = 'Remove');
		End
		Else
		Begin
			Set @Content = dbo.CreateService('', @DepotId, 0, @AgentId, @PackageNo, 2, 0, 'Fasten', '加固服务', 0, 1, '', '', @AdminId, '', '', @CreateTime, @CreateTime);
			Exec @Return = sp_XmlCreate 'Service', @Content, @Result = @ServiceNo out;
		End
	End
	


	-- 老包裹跟踪信息更新
	IF Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
	Begin
		Select @Message = '预报包裹已入库，扫描单号为:' + @ScanShippingNo;
		Set @TrackItem = dbo.CreateTrackItem(GETUTCDATE(), 1, 'Storage', @Message, '');
		
		Select @Content = Content From YouEx_XmlTrack Where ShippingNo = @ShippingNo;
		Set @Content.modify('insert sql:variable("@TrackItem") as last into (/Root/TrackList)[1]');
		Update YouEx_XmlTrack Set
				[Status] = 3,
				NewShipping = 'Fedroad:' + @NewShippingNo,
				UpdateTime = GETUTCDATE(),
				Content = @Content
			Where ShippingNo = @ShippingNo;
	End


	
	-- 创建新包裹跟踪信息
	Select @CreateTime = GETUTCDATE();
	Select @Message = '运单号为:' + @ShippingNo + '的包裹已入库，并生成新运单号:' + @NewShippingNo;
	Select @TrackList = '<TrackList/>';

	Set @TrackList = dbo.CreateTrackList(@CreateTime, 1, 'Storage', @Message, '', @TrackList);
	Set @Content = dbo.CreateTrack(@NewShippingNo, 'Fedroad', '', 1, @CreateTime, @CreateTime, @TrackList);

	Exec @Return = sp_XmlCreate 'Track', @Content, @Result out;

	Commit Transaction;
	
	Select @Result = @NewShippingNo;
	Return 1;
END

