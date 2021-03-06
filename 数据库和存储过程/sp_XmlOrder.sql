USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlOrder]    Script Date: 02/04/2016 10:16:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_XmlOrder]
(
	@CommandType		int,
	@SelectType			int,
	@BeginTime			datetime,
	@EndTime			datetime,

	@OrderNo			nvarchar(50),
	@DepotId			int,
	@Type				int,
	@UserId				int,
	@StorageNo			nvarchar(50),
	@AccessStatus		int,
	@PayStatus			int,
	@Content			Xml
)
AS
BEGIN
	SET NOCOUNT ON;

	Declare @AgentId			int,
			@CreateTime			DateTime;

	
	IF (@CommandType <= 2)
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
	End
	
	IF(@CommandType = 1)
	Begin
		IF Exists(Select * From YouEx_XmlOrder Where OrderNo = @OrderNo)
			return -1;

		--Set @Content.modify('insert if(/Root/Order[CreateTime = ""]) then text{sql:variable("@CreateTime")} else() into (/Root/Order/CreateTime)[1]');
		--Set @Content.modify('replace value of (/Root/OrderNo/text())[1] with sql:variable("@OrderNo")');
		--Set @Content.modify('replace value of (/Root/OrderId/text())[1] with sql:variable("@OrderId")');

		INSERT INTO YouEx_XmlOrder (OrderNo, DepotId, UserId, StorageNo, AgentId, [Type], AccessStatus, PayStatus, CreateTime, Content)
			VALUES(@OrderNo, @DepotId, @UserId, @StorageNo, @AgentId, @Type, @AccessStatus, @PayStatus, @CreateTime, @Content);

		Return 1;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlOrder WHERE OrderNo = @OrderNo)
			Return 0;

		Update YouEx_XmlOrder Set 
				DepotId = @DepotId,
				UserId = @UserId,
				StorageNo = @StorageNo,
				AgentId = @AgentId,
				[Type] = @Type,
				AccessStatus = @AccessStatus,
				PayStatus = @PayStatus,
				CreateTime = @CreateTime,
				Content = @Content
			Where OrderNo = @OrderNo;
		
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_XmlOrder WHERE OrderNo = @OrderNo)
			Return 0;
		Delete From YouEx_XmlOrder Where OrderNo = @OrderNo;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按OrderNo查询订单
		If (@SelectType = 1)
		Begin
			Select *,
				   (Select COUNT(*) From YouEx_Package B Where A.OrderNo = B.OrderNo and B.[Type] = 1) as PackageCount, 
				   (Select COUNT(*) From YouEx_Package C Where A.OrderNo = C.OrderNo and C.[Type] = 2) as DeliveryCount
				From YouEx_XmlOrder A Where OrderNo = @OrderNo;
			Return 1;
		End
		
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		-- 按DepotId查询
		If (@SelectType & 2) <> 0
			Select @strCmd = @strCmd + ' DepotId = ' + ltrim(str(@DepotId)) + ' And';
			
		-- 按Type查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';
			
		-- 按UserId查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';

		-- 按StorageNo查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' StorageNo = ''' + ltrim(@StorageNo) + ''' And';

		-- 按AccessStatus查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' AccessStatus = ' + ltrim(str(@AccessStatus)) + ' And';

		-- 按PayStatus查询
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' PayStatus = ' + ltrim(str(@PayStatus)) + ' And';

		-- 按CreateTime查询
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime) + ''' And';


		Select @strCmd = 'Select *,
								(Select COUNT(*) From YouEx_Package B Where A.OrderNo = B.OrderNo and B.[Type] = 1) as PackageCount, 
								(Select COUNT(*) From YouEx_Package C Where A.OrderNo = C.OrderNo and C.[Type] = 2) as DeliveryCount
							From YouEx_XmlOrder A Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 4;
	End
	
	Return 0;

END
