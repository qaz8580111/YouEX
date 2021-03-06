USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlAccess]    Script Date: 02/04/2016 10:15:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_XmlAccess]
(
	@Module			nvarchar(50),
	@Content		xml,
	@Result			nvarchar(50) out
)
AS
BEGIN
	SET NOCOUNT ON;

	-- Package
	Declare @PackageNo		nvarchar(50),
			@OrderNo		nvarchar(50),
			@Type			nvarchar(50),
			@DepotId		nvarchar(50),
			@UserId			nvarchar(50),
			@AgentId		nvarchar(50),
			@StorageNo		nvarchar(50),
			@ShippingNo		nvarchar(50),
			@Status			nvarchar(50),
			@ShippingId		nvarchar(50),
			@GateId			nvarchar(50),
			@CreateTime		nvarchar(50),
			@StorageTime	nvarchar(50),
			@Recipients		nvarchar(50),
			@Phone			nvarchar(50),
			@NotifyType		nvarchar(50),
			@NotifyInfo		nvarchar(100),
			@IsPak			nvarchar(50),
			@Weight			nvarchar(50),
			@Length			nvarchar(50),
			@Width			nvarchar(50),
			@Height			nvarchar(50),
			@Remark			nvarchar(300),

	-- Order
			@AccessStatus	nvarchar(50),
			@PayStatus		nvarchar(50),
			@Insurance		nvarchar(50),
			@AutoPay		nvarchar(50),
			@Invoice		nvarchar(50),
			@HoldPacking	nvarchar(50),
			@WarningInfo	nvarchar(300),

	-- Service
			@ServiceNo		nvarchar(50),
			@ServiceCode	nvarchar(50),
			@AccessTime		dateTime,
			@ServiceName	nvarchar(50),
			@Price			nvarchar(50),
			@Request		nvarchar(300),
			@AdminId		nvarchar(50),
			@AccessResult	nvarchar(300),
			@AttachFile		nvarchar(100),

	-- Track
			@ShippingName	nvarchar(50),
			@NewShipping	nvarchar(300),
			@UpdateTime		DateTime,

	-- Bill
			@BillNo			nvarchar(50),
			@IndexNo		nvarchar(50),
			@PayMode		int,
			@PayTime		DateTime,

	-- Log		
			@LogNo			nvarchar(50),
			@Action			nvarchar(50),

	-- User
			@UserNo			nvarchar(50),
			@Role			int,
			@UserName		nvarchar(50),
			@Password		nvarchar(50),

			@Email			nvarchar(50),
			@Mobile			nvarchar(50),
			@WeiXin			nvarchar(50),
			@RegTime		datetime;

	IF @Module = 'Package'
	Begin
		Set @PackageNo = @Content.value('(/Root/Package/PackageNo)[1]', 'nvarchar(50)');
		Set @OrderNo = @Content.value('(/Root/Package/OrderNo)[1]', 'nvarchar(50)');
		Set @DepotId = @Content.value('(/Root/Package/DepotId)[1]', 'nvarchar(50)');
		Set @Type = @Content.value('(/Root/Package/Type)[1]', 'nvarchar(50)');
		Set @Status = @Content.value('(/Root/Package/Status)[1]', 'nvarchar(50)');
		
		Set @ShippingNo = @Content.value('(/Root/Package/ShippingNo)[1]', 'nvarchar(50)');
		Set @ShippingName = @Content.value('(/Root/Package/ShippingName)[1]', 'nvarchar(50)');
		Set @ShippingId = @Content.value('(/Root/Package/ShippingId)[1]', 'nvarchar(50)');
		Set @GateId = @Content.value('(/Root/Package/ShippingId)[1]', 'nvarchar(50)');
		Set @CreateTime = @Content.value('(/Root/Package/CreateTime)[1]', 'nvarchar(50)');
		
		Set @UserId = @Content.value('(/Root/Package/UserId)[1]', 'nvarchar(50)');
		Set @AgentId = @Content.value('(/Root/Package/AgentId)[1]', 'nvarchar(50)');
		Set @StorageNo = @Content.value('(/Root/Package/StorageNo)[1]', 'nvarchar(50)');
		Set @StorageTime = @Content.value('(/Root/Package/StorageTime)[1]', 'nvarchar(50)');
		Set @Recipients = @Content.value('(/Root/Package/Recipients)[1]', 'nvarchar(50)');
		
		Set @Phone = @Content.value('(/Root/Package/Phone)[1]', 'nvarchar(50)');
		Set @NotifyType = @Content.value('(/Root/Package/NotifyType)[1]', 'nvarchar(50)');
		Set @NotifyInfo = @Content.value('(/Root/Package/NotifyInfo)[1]', 'nvarchar(100)');
		Set @IsPak = @Content.value('(/Root/Package/IsPak)[1]', 'nvarchar(50)');
		Set @Weight = @Content.value('(/Root/Package/Weight)[1]', 'nvarchar(50)');
		
		Set @Length = @Content.value('(/Root/Package/Length)[1]', 'nvarchar(50)');
		Set @Width = @Content.value('(/Root/Package/Width)[1]', 'nvarchar(50)');
		Set @Height = @Content.value('(/Root/Package/Height)[1]', 'nvarchar(50)');
		Set @Remark = @Content.value('(/Root/Package/Remark)[1]', 'nvarchar(50)');
		Set @Content.modify('delete (/Root/Package)');

		IF @PackageNo IS NULL
			Return -1;
		
		IF @PackageNo = ''
		Begin
			-- PackageNo不存在，创建新包裹
			-- 创建新包裹，不允许ShippingNo相同
			IF @ShippingNo <> ''
			Begin
				IF EXISTS(SELECT * FROM YouEx_Package WHERE ShippingNo = @ShippingNo)
					Return -3;
			End

			-- 获取新PackageNo
			Exec sp_GetResource 'PackageNo', @DepotId, 0, @Result = @PackageNo out;

			-- 无库位号，则获取一个临时库位号（无头件）
			IF @StorageNo = ''
			Begin
				Exec rm_GetIdentify 'NoMaster', @DepotId, 0, @StorageNo Output;
				Set @Content.modify('insert text{sql:variable("@StorageNo")} into (/Root/Package/StorageNo)[1]');
			End
		
			INSERT INTO YouEx_Package(PackageNo, OrderNo, DepotId, [Type], [Status], ShippingNo, ShippingName, ShippingId, GateId, CreateTime, UserId, AgentId, StorageNo, StorageTime, Recipients, Phone, NotifyType, NotifyInfo, IsPak, [Weight], [Length], Width, Height, Remark, Content)
				VALUES(@PackageNo, 
					ISNULL(@OrderNo, ''),
					ISNULL(@DepotId, 0),
					ISNULL(@Type, 0),
					ISNULL(@Status, 0),
					ISNULL(@ShippingNo, ''),
					ISNULL(@ShippingName, ''),
					ISNULL(@ShippingId, 0),
					ISNULL(@GateId, 0),
					ISNULL(@CreateTime, GETUTCDATE()),
					ISNULL(@UserId, 0),
					ISNULL(@AgentId, 0),
					ISNULL(@StorageNo, ''),
					ISNULL(@StorageTime, '1900-01-01'),
					ISNULL(@Recipients, ''),
					ISNULL(@Phone, ''),
					ISNULL(@NotifyType, ''),
					ISNULL(@NotifyInfo, ''),
					ISNULL(@IsPak, 0),
					ISNULL(@Weight, 0),
					ISNULL(@Length, 0),
					ISNULL(@Width, 0),
					ISNULL(@Height, 0),
					ISNULL(@Remark, ''),
					@Content);
		End
		Else
		Begin
			-- PackageNo已经存在，更新包裹信息
			IF NOT EXISTS(SELECT * FROM YouEx_Package WHERE PackageNo = @PackageNo)
				Return -2;
			
			IF @Content.exist('/Root/Packages') = 0
				Set @Content = NULL;

			Update YouEx_Package Set
					OrderNo = ISNULL(@OrderNo, OrderNo),
					DepotId = ISNULL(@DepotId, DepotId),
					[Type] = ISNULL(@Type, [Type]),
					[Status] = ISNULL(@Status, [Status]),
					ShippingNo = ISNULL(@ShippingNo, ShippingNo),
					ShippingName = ISNULL(@ShippingName, ShippingName),
					ShippingId = ISNULL(@ShippingId, ShippingId),
					GateId = ISNULL(@GateId, GateId),
					CreateTime = ISNULL(@CreateTime, CreateTime),
					UserId = ISNULL(@UserId, UserId),
					AgentId = ISNULL(@AgentId, AgentId),
					StorageNo = ISNULL(@StorageNo, StorageNo),
					StorageTime = ISNULL(@StorageTime, StorageTime),
					Recipients = ISNULL(@Recipients, Recipients),
					Phone = ISNULL(@Phone, Phone),
					NotifyType = ISNULL(@NotifyType, NotifyType),
					NotifyInfo = ISNULL(@NotifyInfo, NotifyInfo),
					IsPak = ISNULL(@IsPak, IsPak),
					[Weight] = ISNULL(@Weight, [Weight]),
					[Length] = ISNULL(@Length, [Length]),
					Width = ISNULL(@Width, Width),
					Height = ISNULL(@Height, Height),
					Remark = ISNULL(@Remark, Remark),
					Content = ISNULL(@Content, Content)
				Where PackageNo = @PackageNo;
		End

		Select @Result = @PackageNo;
		Return 1;
	End




	IF @Module = 'Order'
	Begin
		Select @OrderNo = @Content.value('(/Root/Order/OrderNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Order/DepotId)[1]', 'nvarchar(50)');
		Select @UserId = @Content.value('(/Root/Order/UserId)[1]', 'nvarchar(50)');
		Select @AgentId = @Content.value('(/Root/Order/AgentId)[1]', 'nvarchar(50)');
		Select @StorageNo = @Content.value('(/Root/Order/StorageNo)[1]', 'nvarchar(50)');

		Select @Type = @Content.value('(/Root/Order/Type)[1]', 'nvarchar(50)');
		Select @AccessStatus = @Content.value('(/Root/Order/AccessStatus)[1]', 'nvarchar(50)');
		Select @PayStatus = @Content.value('(/Root/Order/PayStatus)[1]', 'nvarchar(50)');
		Select @CreateTime = @Content.value('(/Root/Order/CreateTime)[1]', 'nvarchar(50)');
		Select @Insurance = @Content.value('(/Root/Order/Insurance)[1]', 'nvarchar(50)');

		Select @Invoice = @Content.value('(/Root/Order/Invoice)[1]', 'nvarchar(50)');
		Select @AutoPay = @Content.value('(/Root/Order/AutoPay)[1]', 'nvarchar(50)');
		Select @HoldPacking = @Content.value('(/Root/Order/HoldPacking)[1]', 'nvarchar(50)');
		Select @WarningInfo = @Content.value('(/Root/Order/WarningInfo)[1]', 'nvarchar(300)');

		IF @OrderNo = ''
		Begin
			Exec sp_GetResource 'OrderNo', @DepotId, 0, @Result = @OrderNo out;
			Set @Content.modify('insert text{sql:variable("@OrderNo")} into (/Root/Order/OrderNo)[1]');
			INSERT INTO YouEx_Order(OrderNo, DepotId, UserId, AgentId, StorageNo, [Type], AccessStatus, PayStatus, CreateTime, Insurance, Invoice, AutoPay, HoldPacking, WarningInfo)
				VALUES(@OrderNo,
					ISNULL(@DepotId, 0),
					ISNULL(@UserId, 0),
					ISNULL(@AgentId, 0),
					ISNULL(@StorageNo, ''),
					ISNULL(@Type, 0),
					ISNULL(@AccessStatus, 0),
					ISNULL(@PayStatus, 0),
					ISNULL(@CreateTime, GETUTCDATE()),
					ISNULL(@Insurance, 0),
					ISNULL(@Invoice, 0),
					ISNULL(@AutoPay, 0),
					ISNULL(@HoldPacking, 0),
					ISNULL(@WarningInfo, ''));
		End
		Else
		Begin
			Update YouEx_Order Set
					DepotId = ISNULL(@DepotId, DepotId),
					UserId = ISNULL(@UserId, UserId),
					AgentId = ISNULL(@AgentId, AgentId),
					StorageNo = ISNULL(@StorageNo, StorageNo),
					[Type] = ISNULL(@Type, [Type]),
					AccessStatus = ISNULL(@AccessStatus, AccessStatus),
					PayStatus = ISNULL(@PayStatus, PayStatus),
					CreateTime = ISNULL(@CreateTime, CreateTime),
					Insurance = ISNULL(@Insurance, Insurance),
					Invoice = ISNULL(@Invoice, Invoice),
					AutoPay = ISNULL(@AutoPay, AutoPay),
					HoldPacking = ISNULL(@HoldPacking, HoldPacking),
					WarningInfo = ISNULL(@WarningInfo, WarningInfo)
				Where OrderNo = @OrderNo;
		End

		Select @Result = @OrderNo;
		Return 1;
	End



	
	IF @Module = 'Service'
	Begin
		Select @ServiceNo = @Content.value('(/Root/Service/ServiceNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Service/DepotId)[1]', 'nvarchar(50)');
		Select @UserId = @Content.value('(/Root/Service/UserId)[1]', 'nvarchar(50)');
		Select @AgentId = @Content.value('(/Root/Service/AgentId)[1]', 'nvarchar(50)');
		Select @PackageNo = @Content.value('(/Root/Service/PackageNo)[1]', 'nvarchar(50)');
		
		Select @AccessStatus = @Content.value('(/Root/Service/AccessStatus)[1]', 'nvarchar(50)');
		Select @PayStatus = @Content.value('(/Root/Service/PayStatus)[1]', 'nvarchar(50)');
		Select @ServiceCode = @Content.value('(/Root/Service/ServiceCode)[1]', 'nvarchar(50)');
		Select @ServiceName = @Content.value('(/Root/Service/ServiceName)[1]', 'nvarchar(50)');
		Select @Price = @Content.value('(/Root/Service/Price)[1]', 'nvarchar(50)');
		
		Select @AutoPay = @Content.value('(/Root/Service/AutoPay)[1]', 'nvarchar(50)');
		Select @Request = @Content.value('(/Root/Service/Request)[1]', 'nvarchar(300)');
		Select @Phone = @Content.value('(/Root/Service/Phone)[1]', 'nvarchar(50)');
		Select @AdminId = @Content.value('(/Root/Service/AdminId)[1]', 'nvarchar(50)');
		Select @AccessResult = @Content.value('(/Root/Service/AccessResult)[1]', 'nvarchar(300)');

		Select @AttachFile = @Content.value('(/Root/Service/AttachFile)[1]', 'nvarchar(100)');
		Select @CreateTime = @Content.value('(/Root/Service/CreateTime)[1]', 'nvarchar(50)');
		Select @AccessTime = @Content.value('(/Root/Service/AccessTime)[1]', 'nvarchar(50)');
		Set @Content.modify('delete (/Root/Service)');
		
		-- 服务编号为空，则创建新服务，否则更新服务
		IF @ServiceNo = ''
		Begin
			Exec sp_GetResource 'ServiceNo', @DepotId, 0, @Result = @ServiceNo out;
			Set @Content.modify('insert text{sql:variable("@ServiceNo")} into (/Root/Service/ServiceNo)[1]');
			
			INSERT INTO YouEx_OrderService(ServiceNo, DepotId, UserId, AgentId, PackageNo, AccessStatus, PayStatus, ServiceCode, ServiceName, Price, AutoPay, Request, Phone, AdminId, AccessResult, AttachFile, CreateTime, AccessTime, Content)
				VALUES(@ServiceNo,
				ISNULL(@DepotId, 0),
				ISNULL(@UserId, 0),
				ISNULL(@AgentId, 0),
				ISNULL(@PackageNo, ''),
				ISNULL(@AccessStatus, 0),
				ISNULL(@PayStatus, 0),
				ISNULL(@ServiceCode, ''),
				ISNULL(@ServiceName, ''),
				ISNULL(@Price, 0),
				ISNULL(@AutoPay, 0),
				ISNULL(@Request, ''),
				ISNULL(@Phone, ''),
				ISNULL(@AdminId, 0),
				ISNULL(@AccessResult, ''),
				ISNULL(@AttachFile, ''),
				ISNULL(@CreateTime, GETUTCDATE()),
				ISNULL(@AccessTime, '1900-01-01'),
				@Content);
		End
		Else
		Begin
			IF @Content.exist('/Root/Return') = 0
				Set @Content = NULL;

			Update YouEx_OrderService Set
					DepotId = ISNULL(@DepotId, DepotId),
					UserId = ISNULL(@UserId, UserId),
					AgentId = ISNULL(@AgentId, AgentId),
					PackageNo = ISNULL(@PackageNo, PackageNo),
					AccessStatus = ISNULL(@AccessStatus, AccessStatus),
					PayStatus = ISNULL(@PayStatus, PayStatus),
					ServiceCode = ISNULL(@ServiceCode, ServiceCode),
					ServiceName = ISNULL(@ServiceName, ServiceName),
					Price = ISNULL(@Price, Price),
					AutoPay = ISNULL(@AutoPay, AutoPay),
					Request = ISNULL(@Request, Request),
					Phone = ISNULL(@Phone, Phone),
					AdminId = ISNULL(@AdminId, AdminId),
					AccessResult = ISNULL(@AccessResult, AccessResult),
					AttachFile = ISNULL(@AttachFile, AttachFile),
					CreateTime = ISNULL(@CreateTime, CreateTime),
					AccessTime = ISNULL(@AccessTime, AccessTime),
					Content = ISNULL(@Content, Content)
				Where ServiceNo = @ServiceNo;
		End


		Select @Result = @ServiceNo;
		Return 1;
	End




	IF @Module = 'Track'
	Begin
		Select @ShippingNo = @Content.value('(/Root/Track/ShippingNo)[1]', 'nvarchar(50)');
		Select @ShippingName = @Content.value('(/Root/Track/ShippingName)[1]', 'nvarchar(50)');
		Select @NewShipping = @Content.value('(/Root/Track/NewShipping)[1]', 'nvarchar(50)');
		Select @Status = @Content.value('(/Root/Track/Status)[1]', 'nvarchar(50)');
		Select @CreateTime = @Content.value('(/Root/Track/CreateTime)[1]', 'nvarchar(50)');
		Select @UpdateTime = @Content.value('(/Root/Track/UpdateTime)[1]', 'nvarchar(50)');
		Set @Content.modify('delete (/Root/Track)');

		IF Not Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
		Begin
			INSERT INTO YouEx_XmlTrack (ShippingNo, ShippingName, NewShipping, [Status], CreateTime, UpdateTime, Content)
				VALUES(@ShippingNo, @ShippingName, @NewShipping, 
					ISNULL(@Status, 0),
					ISNULL(@CreateTime, GETUTCDATE()),
					ISNULL(@UpdateTime, '1900-01-01'),
					@Content);
		End
		ELse
		Begin
			IF @Content.exist('/Root/TrackList') = 0
				Set @Content = NULL;
			Update YouEx_XmlTrack Set
					ShippingName = ISNULL(@ShippingName, ShippingName),
					NewShipping = ISNULL(@NewShipping, NewShipping),
					[Status] = ISNULL(@Status, [Status]),
					CreateTime = ISNULL(@CreateTime, CreateTime),
					UpdateTime = ISNULL(@UpdateTime, UpdateTime),
					Content = ISNULL(@Content, Content)
				Where ShippingNo = @ShippingNo;
		End
		Select @Result = @ShippingNo;
		Return 1;
	End




	IF @Module = 'Bill'
	Begin
		Select @BillNo = @Content.value('(/Root/Bill/BillNo)[1]', 'nvarchar(50)');
		Select @Type = @Content.value('(/Root/Bill/Type)[1]', 'int');
		Select @IndexNo = @Content.value('(/Root/Bill/IndexNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Bill/DepotId)[1]', 'int');
		Select @UserId = @Content.value('(/Root/Bill/UserId)[1]', 'int');
		Select @AgentId = @Content.value('(/Root/Bill/AgentId)[1]', 'int');
		Select @AutoPay = @Content.value('(/Root/Bill/AutoPay)[1]', 'int');
		Select @PayStatus = @Content.value('(/Root/Bill/PayStatus)[1]', 'int');
		Select @PayMode = @Content.value('(/Root/Bill/PayMode)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Bill/CreateTime)[1]', 'DateTime');
		Select @PayTime = @Content.value('(/Root/Bill/PayTime)[1]', 'DateTime');

		IF @BillNo = ''
		Begin
			Exec sp_GetResource 'BillNo', @DepotId, 0, @Result = @BillNo out;
			Set @Content.modify('insert text{sql:variable("@BillNo")} into (/Root/Bill/BillNo)[1]');
		End

		INSERT INTO YouEx_XmlBill (BillNo, [Type], IndexNo, DepotId, UserId, AgentId, AutoPay, PayStatus, PayMode, CreateTime, PayTime, Content)
			VALUES(@BillNo, @Type, @IndexNo, @DepotId, @UserId, @AgentId, @AutoPay, @PayStatus, @PayMode, @CreateTime, @PayTime, @Content);

		Select @Result = @BillNo;
		Return 1;
	End




	IF @Module = 'Log'
	Begin
		Select @LogNo = @Content.value('(/Root/Log/LogNo)[1]', 'nvarchar(50)');
		Select @Type = @Content.value('(/Root/Log/Type)[1]', 'int');
		Select @IndexNo = @Content.value('(/Root/Log/IndexNo)[1]', 'nvarchar(50)');
		Select @Action = @Content.value('(/Root/Log/Action)[1]', 'nvarchar(50)');
		Select @CreateTime = @Content.value('(/Root/Log/CreateTime)[1]', 'DateTime');
		Set @Content.modify('delete (/Root/Log)');
		
		IF @LogNo = ''
		Begin
			Exec sp_GetResource 'LogNo', @DepotId, 0, @Result = @LogNo out;
--			Set @Content.modify('insert text{sql:variable("@LogNo")} into (/Root/Log/LogNo)[1]');
		End

		INSERT INTO YouEx_XmlLog (LogNo, [Type], IndexNo, [Action], CreateTime, Content)
			VALUES(@LogNo, @Type, @IndexNo, @Action, @CreateTime, @Content);

		Select @Result = @LogNo;
		Return 1;
	End
	
	


	
	IF @Module = 'User'
	Begin
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

		Select @Result = @StorageNo;
		Return @UserId;
	End
END
