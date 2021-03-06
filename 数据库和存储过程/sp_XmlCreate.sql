USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlCreate]    Script Date: 02/04/2016 10:16:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_XmlCreate]
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
			@Type			int,
			@DepotId		int,
			@UserId			int,
			@AgentId		int,
			@StorageNo		nvarchar(50),
			@ShippingNo		nvarchar(50),
			@Status			int,
			@CreateTime		datetime,
			@StorageTime	datetime,

	-- Order
			@AccessStatus	int,
			@PayStatus		int,

	-- Track
			@ShippingName	nvarchar(50),
			@NewShipping	nvarchar(300),
			@UpdateTime		DateTime,

	-- Bill
			@BillNo			nvarchar(50),
			@IndexNo		nvarchar(50),
			@AutoPay		int,
			@PayMode		int,
			@PayTime		DateTime,

	-- Log		
			@LogNo			nvarchar(50),
			@Action			nvarchar(50),

	-- Service
			@ServiceNo		nvarchar(50),
			@ServiceCode	nvarchar(50),
			@AccessTime		dateTime,

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
		Select @StorageTime = @Content.value('(/Root/Package/StorageTime)[1]', 'DateTime');

		IF EXISTS(SELECT * FROM YouEx_Package WHERE PackageNo = @PackageNo)
			Return -1

		IF @ShippingNo <> ''
		Begin
			IF EXISTS(SELECT * FROM YouEx_Package WHERE ShippingNo = @ShippingNo)
				Return -2;
		End

		/*无头件临时库位号生成*/
		Begin Transaction;
		IF @StorageNo = ''
		Begin
			Exec rm_GetIdentify 'NoMaster', @DepotId, 0, @StorageNo Output;
			Set @Content.modify('insert text{sql:variable("@StorageNo")} into (/Root/Package/StorageNo)[1]');
		End
		Commit Transaction;

		IF @PackageNo = ''
		Begin
			Exec sp_GetResource 'PackageNo', @DepotId, 0, @Result = @PackageNo out;
			Set @Content.modify('insert text{sql:variable("@PackageNo")} into (/Root/Package/PackageNo)[1]');
		End

		INSERT INTO YouEx_Package (PackageNo, OrderNo, [Type], DepotId, UserId, AgentId, StorageNo, CreateTime, StorageTime, [Status], ShippingNo, Content)
			VALUES(@PackageNo, @OrderNo, @Type, @DepotId, @UserId, @AgentId, @StorageNo, @CreateTime, @StorageTime, @Status, @ShippingNo, @Content);

		Select @Result = @PackageNo;
		Return 1;
	End




	IF @Module = 'Order'
	Begin
		Select @OrderNo = @Content.value('(/Root/Order/OrderNo)[1]', 'nvarchar(50)');
		Select @DepotId = @Content.value('(/Root/Order/DepotId)[1]', 'int');
		Select @UserId = @Content.value('(/Root/Order/UserId)[1]', 'int');
		Select @StorageNo = @Content.value('(/Root/Order/StorageNo)[1]', 'nvarchar(50)');
		Select @AgentId = @Content.value('(/Root/Order/AgentId)[1]', 'int');
		Select @Type = @Content.value('(/Root/Order/Type)[1]', 'int');
		Select @AccessStatus = @Content.value('(/Root/Order/AccessStatus)[1]', 'int');
		Select @PayStatus = @Content.value('(/Root/Order/PayStatus)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Order/CreateTime)[1]', 'DateTime');

		IF @OrderNo = ''
		Begin
			Exec sp_GetResource 'OrderNo', @DepotId, 0, @Result = @OrderNo out;
			Set @Content.modify('insert text{sql:variable("@OrderNo")} into (/Root/Order/OrderNo)[1]');
		End

		INSERT INTO YouEx_XmlOrder (OrderNo, DepotId, UserId, StorageNo, AgentId, [Type], AccessStatus, PayStatus, CreateTime, Content)
			VALUES(@OrderNo, @DepotId, @UserId, @StorageNo, @AgentId, @Type, @AccessStatus, @PayStatus, @CreateTime, @Content);

		Select @Result = @OrderNo;
		Return 1;
	End

	
	

	IF @Module = 'Track'
	Begin
		Select @ShippingNo = @Content.value('(/Root/Track/ShippingNo)[1]', 'nvarchar(50)');
		Select @ShippingName = @Content.value('(/Root/Track/ShippingName)[1]', 'nvarchar(50)');
		Select @NewShipping = @Content.value('(/Root/Track/NewShipping)[1]', 'nvarchar(50)');
		Select @Status = @Content.value('(/Root/Track/Status)[1]', 'int');
		Select @CreateTime = @Content.value('(/Root/Track/CreateTime)[1]', 'DateTime');
		Select @UpdateTime = @Content.value('(/Root/Track/UpdateTime)[1]', 'DateTime');
		Set @Content.modify('delete (/Root/Track)');

		IF Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
			Return -1;

		INSERT INTO YouEx_XmlTrack (ShippingNo, ShippingName, NewShipping, [Status], CreateTime, UpdateTime, Content)
			VALUES(@ShippingNo, @ShippingName, @NewShipping, @Status, @CreateTime, @UpdateTime, @Content);

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
	
	


	IF @Module = 'Service'
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

		IF @ServiceNo = ''
		Begin
			Exec sp_GetResource 'ServiceNo', @DepotId, 0, @Result = @ServiceNo out;
			Set @Content.modify('insert text{sql:variable("@ServiceNo")} into (/Root/Service/ServiceNo)[1]');
		End

		INSERT INTO YouEx_XmlService(ServiceNo, DepotId, UserId, AgentId, PackageNo, AccessStatus, PayStatus, ServiceCode, CreateTime, AccessTime, Content)
			VALUES(@ServiceNo, @DepotId, @UserId, @AgentId, @PackageNo, @AccessStatus, @PayStatus, @ServiceCode, @CreateTime, @AccessTime, @Content);

		Select @Result = @ServiceNo;
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
