USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_AgentAdd]    Script Date: 02/04/2016 10:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_AgentAdd]
(
	@AdminId		int,
	@DepotId		int,
	@StorageNo		nvarchar(50),
	@ShippingNo		nvarchar(50),
	@Service		nvarchar(50),
	@OrderInfo		Xml,
	@PackageInfo	Xml,
	@Result			nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @OrderNo		nvarchar(50),
			@PackageNo		nvarchar(50),
			@ServiceNo		nvarchar(50),
			@AgentId		int,
			
			@Content		Xml,
			@CreateTime		datetime,
			@Message		nvarchar(300),
			@TrackList		Xml,
			@Return			int;

	Select @Result = '';
	
	IF Exists(Select * From YouEx_Package Where ShippingNo = @ShippingNo)
		Return -1;

	IF Not Exists(Select * From YouEx_Agent Where StorageNo = @StorageNo)
		Return -2;
	Select @AgentId = AgentId From YouEx_Agent Where StorageNo = @StorageNo;

	Begin Transaction;

	-- 创建新订单
	Exec @Return = sp_XmlCreate 'Order', @OrderInfo, @Result = @OrderNo out;


	-- 创建新包裹
	Set @PackageInfo.modify('delete (/Root/Package/OrderNo/text())');
	Set @PackageInfo.modify('insert text{sql:variable("@OrderNo")} into (/Root/Package/OrderNo)[1]');

	Exec @Return = sp_XmlCreate 'Package', @PackageInfo, @Result = @PackageNo out;
	IF @Return < 0
	Begin
		RollBack Transaction;
		Return -2;
	End
	

	-- 创建增值服务
	Select @CreateTime = GETUTCDATE();
	IF  PatIndex('%Remove%', @Service) > 0
	Begin
		Set @Content = dbo.CreateService('', @DepotId, 0, @AgentId, @PackageNo, 0, 0, 'Remove', '去泡服务', 0, 1, '', '', 0, '', '', @CreateTime, @CreateTime);
		Exec @Return = sp_XmlCreate 'Service', @Content, @Result = @ServiceNo out;
	End
	
	IF  PatIndex('%Fasten%', @Service) > 0
	Begin
		Set @Content = dbo.CreateService('', @DepotId, 0, @AgentId, @PackageNo, 0, 0, 'Fasten', '加固服务', 0, 1, '', '', 0, '', '', @CreateTime, @CreateTime);
		Exec @Return = sp_XmlCreate 'Service', @Content, @Result = @ServiceNo out;
	End
	
	-- 创建新包裹跟踪信息
	Select @CreateTime = GETUTCDATE();
	Select @Message = '运单号为:' + @ShippingNo + '的包裹已入库（未预报）。';
	Select @TrackList = '<TrackList/>';

	Set @TrackList = dbo.CreateTrackList(@CreateTime, 1, 'Storage', @Message, '', @TrackList);
	Set @Content = dbo.CreateTrack(@ShippingNo, '', '', 3, @CreateTime, @CreateTime, @TrackList);

	Exec @Return = sp_XmlCreate 'Track', @Content, @Result out;

	Commit Transaction;
	
	Select @Result = @OrderNo + ',' + @PackageNo;
	Return 1;
END

