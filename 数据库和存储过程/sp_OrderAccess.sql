USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_OrderAccess]    Script Date: 03/11/2016 16:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		TorkyChan
-- Create date: 2016-2-29
-- Modify date: 2016-3-2
-- Description:	订单处理，包括订单、包裹、增值服务、物流跟踪等流程。
-- =============================================
ALTER PROCEDURE [dbo].[sp_OrderAccess]
(
	@OrderNo		nvarchar(50),
	@AdminId		int,
	@DepotId		int,
	@DeletePackage	nvarchar(300),
	@OrderInfo		Xml,
	@PackageList	Xml,

	@Result			nvarchar(300) Output
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @PackageNo		nvarchar(50),
			@PackageInfo	Xml,
			@ShippingNo		nvarchar(50),
			@Status			int,

			@ServiceCode	nvarchar(100),
			@ServiceList	Xml,
			@ServiceInfo	Xml,
			@ServiceNo		nvarchar(50),
			@AccessStatus	int,
			@PayStatus		int,
			@AccessResult	nvarchar(300),
			@AttachFile		nvarchar(300),
			@ServiceNoList	nvarchar(300),
			
			@TrackInfo		Xml,
			@ShippingName	nvarchar(50),
			@TrackStatus	int,

			@NewShipping	nvarchar(300),
			@ShippingList	nvarchar(300),
			@ReturnValue	int,
			@ErrorValue		int;

	Begin Transaction;

	Select @ErrorValue = -1;
	Select @ShippingList = '', @NewShipping = '';

	IF @OrderNo = ''
	Begin
		IF Convert(nvarchar(max), @OrderInfo) <> ''
		Begin
			Exec @ReturnValue = sp_XmlAccess 'Order', @OrderInfo, @OrderNo Out;
			IF @ReturnValue <> 1
				Goto FailedReturn;
			Select @ShippingList = 'OrderNo:' + @OrderNo;
			Update YouEx_Order Set AccessStatus = 2 Where OrderNo = @OrderNo;
		End
	End
	Else
	Begin
		-- 订单不存在，返回错误信息 -1
		IF Not Exists(Select * From YouEx_Order Where OrderNo = @OrderNo)
			Goto FailedReturn;

		-- 更新订单状态为已处理	
		Update YouEx_Order Set AccessStatus = 2 Where OrderNo = @OrderNo;
	End



	-- 删除指定的包裹
	IF @DeletePackage <> ''
	Begin
		Delete From YouEx_XmlTrack Where ShippingNo in (Select ShippingNo From YouEx_Package Where PackageNo in (Select Col From dbo.fc_Split(@DeletePackage, ',')));
		Delete From YouEx_Service Where PackageNo in (Select Col From dbo.fc_Split(@DeletePackage, ','));
		Delete From YouEx_Package Where PackageNo in (Select Col From dbo.fc_Split(@DeletePackage, ','));
	End



	-- 创建/更新包裹，有PackageNo的更新包裹，无PackageNo的创建包裹
	IF Convert(nvarchar(max), @PackageList) <> ''
	Begin
		-- 循环处理每个包裹
		Declare @PackageCount int, @PackageIndex int;
		Set @PackageIndex = 1;
		Set @PackageCount = @PackageList.value('count(/Root/Root)', 'INT')

		While @PackageIndex <= @PackageCount
		Begin
			Set @PackageInfo = @PackageList.query('/Root/Root[position()=sql:variable("@PackageIndex")]');

			Set @ServiceList = ISNULL(@PackageInfo.query('Root/ServiceList/Service'), '');
			Set @PackageInfo.modify('delete (/Root/ServiceList)');

			Set @TrackInfo = ISNULL(@PackageInfo.query('Root/TrackInfo'), '');
			Set @PackageInfo.modify('delete (/Root/TrackInfo)');


			-- 已经处理完，且没有运单号的包裹，生成一个新的运单号
			Set @PackageNo = @PackageInfo.value('(/Root/Package/PackageNo)[1]', 'nvarchar(50)');
			Set @Status = @PackageInfo.value('(/Root/Package/Status)[1]', 'int');
			Set @ShippingNo = ISNULL(@PackageInfo.value('(/Root/Package/ShippingNo)[1]', 'nvarchar(50)'), '');

			IF (@ShippingNo = '') And (Exists(Select * From YouEx_Package Where PackageNo = @PackageNo and @PackageNo <> ''))
				Select @ShippingNo = ShippingNo From YouEx_Package Where PackageNo = @PackageNo;

			-- 如果订单号为空，则补充上订单号
			IF (ISNULL(@PackageInfo.value('(/Root/Package/OrderNo)[1]', 'nvarchar(50)'), '') = '') and @OrderNo <> ''
				Set @PackageInfo.modify('insert text{sql:variable("@OrderNo")} into (/Root/Package/OrderNo)[1]');

			-- 获取ShippingNo
			IF (@Status = 12) And (@ShippingNo = '')
			Begin
				Declare @ResName nvarchar(50), @ShippingId int;
				
				Select @ErrorValue = -2;
				IF @PackageInfo.exist('/Root/Package/ShippingId') <> 1
					Goto FailedReturn;

				Select @ShippingId = @PackageInfo.value('(/Root/Package/ShippingId)[1]', 'int');
				Select @ResName = ResName From YouEx_Shipping Where ShippingId = @ShippingId;
				IF IsNull(@ResName, '') = ''
					Goto FailedReturn;

				Exec @ReturnValue = sp_GetResource @ResName, @DepotId, 0, @Result = @ShippingNo out;
				IF (@ReturnValue <> 1) Or (IsNull(@ShippingNo, '') = '')
					Goto FailedReturn;

				Set @PackageInfo.modify('insert <ShippingNo></ShippingNo> into (/Root/Package)[1]');
				Set @PackageInfo.modify('insert text{sql:variable("@ShippingNo")} into (/Root/Package/ShippingNo)[1]');
			End

			-- 处理包裹（新建/更新）
			Exec @ReturnValue = sp_XmlAccess 'Package', @PackageInfo, @PackageNo Out;
			Select @ErrorValue = -3;
			IF (@ReturnValue <> 1) or (@PackageNo = '')
				Goto FailedReturn;
				
			IF @ShippingList <> ''
				Set @ShippingList = @ShippingList + ',';
			Set @ShippingList = @ShippingList + @PackageNo + ':' + @ShippingNo;
			Select @ShippingList = @ShippingList + ':' + StorageNo From YouEx_Package Where PackageNo = @PackageNo;

			IF @Status = 12
			Begin
				IF @NewShipping <> ''
					Set @NewShipping = @NewShipping + ',';
				Set @NewShipping = @NewShipping + 'Fedroad:' + @ShippingNo;
			End


			-- 增值服务
			Declare @ServiceCount int, @ServiceIndex int;
			Set @ServiceIndex = 1;
			Set @ServiceCount = @ServiceList.value('count(/Service)', 'INT')
			Select @ServiceNoList = '';
			While @ServiceIndex <= @ServiceCount
			Begin
				Set @ServiceInfo = @ServiceList.query('/Service[position()=sql:variable("@ServiceIndex")]');
				
				Set @ServiceNo = @ServiceInfo.value('(/Service/ServiceNo)[1]', 'nvarchar(50)');
				Set @ServiceCode = @ServiceInfo.value('(/Service/ServiceCode)[1]', 'nvarchar(50)');
				Set @AccessStatus = @ServiceInfo.value('(/Service/AccessStatus)[1]', 'int');
				Set @PayStatus = @ServiceInfo.value('(/Service/PayStatus)[1]', 'int');
				Set @AccessResult = @ServiceInfo.value('(/Service/AccessResult)[1]', 'nvarchar(300)');
				Set @AttachFile = @ServiceInfo.value('(/Service/AttachFile)[1]', 'nvarchar(300)');

				Exec @ReturnValue = sp_ServiceAccess @AdminId, @PackageNo, @ServiceCode, @ServiceNo, @AccessStatus, @PayStatus, @AccessResult, @AttachFile, @ServiceNo Out;
				Select @ErrorValue = -4;
				IF (@ReturnValue <> 1) or (@ServiceNo = '')
					Goto FailedReturn;
					
				IF @ServiceNoList <> ''
					Set @ServiceNoList = @ServiceNoList + ',';
				Set @ServiceNoList = @ServiceNoList + @ServiceNo;

				Set @ServiceIndex = @ServiceIndex + 1;
			End
			Delete From YouEx_Service Where (PackageNo = @PackageNo) and (ServiceNo not in (Select Col From dbo.fc_Split(@ServiceNoList, ',')))


			-- 物流跟踪信息
			IF Convert(nvarchar(max), @TrackInfo) <> ''
			Begin
				IF Exists(Select * From YouEx_Package Where (PackageNo = @PackageNo) and ([Type] = 2))
					Select @ShippingName = 'Fedroad', @TrackStatus = 1;
				Else
					Select @ShippingName = '', @TrackStatus = 3;

				Exec @ReturnValue = sp_TrackAccess @DepotId, @ShippingNo, @ShippingName, @TrackStatus, @TrackInfo;
				Select @ErrorValue = -5;
				IF @ReturnValue <> 1
					Goto FailedReturn;
			End


			Set @PackageIndex = @PackageIndex + 1;
		End
	End
	
	-- 更新物流链信息
	Update YouEx_XmlTrack Set NewShipping = @NewShipping Where ShippingNo in (Select ShippingNo From YouEx_Package Where (OrderNo = @OrderNo) and ([Status] < 10));

	Commit Transaction;
	
	-- 账单生成
	IF @OrderNo <> ''
		Exec @ReturnValue = sp_OrderBill @OrderNo;

	Select @Result = @ShippingList;
	Return 1;


FailedReturn:
	Rollback Transaction;
	Return @ErrorValue;
	
END

