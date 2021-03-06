USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Common]    Script Date: 02/04/2016 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Common]
(
	@CommandType	int,
	@SelectType		int,
	@Result			nvarchar(50) Output,

	@SelectId1		int,
	@SelectId2		int,
	@SelectName1	nvarchar(50),
	@SelectName2	nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	Declare @strCmd nvarchar(2000);
	Select @strCmd = '';

	-- 查询YouEx_Currency
	IF (@SelectType = 1)
	Begin
		IF @SelectId1 > 0
			Select * From YouEx_Currency Where Id = @SelectId1;
		Else IF @SelectName1 <> ''
			Select * From YouEx_Currency Where Code = @SelectName1;
		Else IF @SelectName2 <> ''
			Select * From YouEx_Currency Where Name = @SelectName2;
		Else
			Select * From YouEx_Currency;
		Return 1;
	End

	-- 查询YouEx_Depot
	IF (@SelectType = 2)
	Begin
		IF @SelectId1 > 0
			Select * From YouEx_Depot Where DepotId = @SelectId1;
		Else IF @SelectName1 <> ''
			Select * From YouEx_Depot Where Name = @SelectName1;
		Else IF @SelectName2 <> ''
			Select * From YouEx_Depot Where Code = @SelectName2;
		Else
			Select * From YouEx_Depot;
		Return 2;
	End
	
	-- 查询YouEx_SystemEnum
	IF (@SelectType = 3)
	Begin
		IF @SelectName1 <> ''
		Begin
			IF @SelectName2 <> ''
				Select * From YouEx_SystemEnum Where [Type] = @SelectName1 and Name = @SelectName2;
			Else IF @SelectId1 > 0
				Select * From YouEx_SystemEnum Where [Type] = @SelectName1 and Value = @SelectId1;
			Else
				Select * From YouEx_SystemEnum Where [Type] = @SelectName1;
		End
		Else
		Begin
			IF @SelectName2 <> ''
				Select * From YouEx_SystemEnum Where Name = @SelectName2;
			Else IF @SelectId1 > 0
				Select * From YouEx_SystemEnum Where Value = @SelectId1;
			Else
				Select * From YouEx_SystemEnum;
		End
		
		Return 3;
	End

	-- 查询YouEx_Shipping
	IF (@SelectType = 4)
	Begin
		IF @SelectId1 > 0
			Select * From YouEx_Shipping Where ShippingId = @SelectId1;
		Else IF @SelectName1 <> ''
			Select * From YouEx_Shipping Where ShippingCode = @SelectName1;
		Else IF @SelectName2 <> ''
			Select * From YouEx_Shipping Where ShippingName = @SelectName2;
		Else
			Select * From YouEx_Shipping;

		return 4;
	End
	
	-- 查询Gate
	IF (@SelectType = 5)
	Begin
		IF @SelectId1 > 0
			Select Value as GateId, Name as GateCode, Content as GateName From YouEx_SystemEnum Where [Type] = 'Gate' and Id = @SelectId1;
		Else IF @SelectName1 <> ''
			Select Value as GateId, Name as GateCode, Content as GateName From YouEx_SystemEnum Where [Type] = 'Gate' and Name = @SelectName1;
		Else IF @SelectName2 <> ''
			Select Value as GateId, Name as GateCode, Content as GateName From YouEx_SystemEnum Where [Type] = 'Gate' and Content = @SelectName2;
		Else
			Select Value as GateId, Name as GateCode, Content as GateName From YouEx_SystemEnum Where [Type] = 'Gate';

		return 5;
	End
	
	-- 查询增值服务
	IF (@SelectType = 6)
	Begin
		IF @SelectId1 > 0
		Begin
			IF @SelectId2 > 0
				Select * From YouEx_ServiceEx Where ServiceId = @SelectId2 And  DepotId = @SelectId1;
			Else IF @SelectName1 <> ''
				Select * From YouEx_ServiceEx Where ServiceCode = @SelectName1 And DepotId = @SelectId1;
			Else IF @SelectName2 <> ''
				Select * From YouEx_ServiceEx Where ServiceName = @SelectName2 And DepotId = @SelectId1;
			Else
				Select * From YouEx_ServiceEx Where DepotId = @SelectId1;
		End
		Else
		Begin
			IF @SelectId2 > 0
				Select * From YouEx_ServiceEx Where ServiceId = @SelectId2;
			Else IF @SelectName1 <> ''
				Select * From YouEx_ServiceEx Where ServiceCode = @SelectName1;
			Else IF @SelectName2 <> ''
				Select * From YouEx_ServiceEx Where ServiceName = @SelectName2;
			Else
				Select * From YouEx_ServiceEx;
		End

		Return 6;
	End
	
	-- 查询短信、邮件模版
	IF (@SelectType = 7)
	Begin
		Select * From YouEx_MessageT Where Code = @SelectName1 and [Type] = @SelectId1;
		Return 7;
	End

	-- 查询优惠券模版
	IF (@SelectType = 8)
	Begin
		IF @SelectId1 > 0
			Select * From YouEx_CouponT Where CouponId = @SelectId1;
		Else IF @SelectName1 <> ''
			Select * From YouEx_CouponT Where CouponName = @SelectName1;
		Else
			Select * From YouEx_CouponT;
		
		Return 8;
	End
	
	-- 查询YouEx_AdminRole
	IF (@SelectType = 11)
	Begin
		Select * From YouEx_AdminRole;
		Return 11;
	End
		
	-- 查询YouEx_AdminDepart
	IF (@SelectType = 12)
	Begin
		Select * From YouEx_AdminDepart;
		Return 12;
	End
	
	-- 获取StorageNo
	IF (@SelectType = 21)
	Begin
		Declare @StorageId int;
		Declare @StorageNo nvarchar(50);
		Exec @StorageId = rm_GetIdentify 'Storage', @SelectId1, 0, @StorageNo Output;
		Select @Result = @StorageNo;
		Return @StorageId;
	End
	
	-- 获取NoMaster
	IF (@SelectType = 22)
	Begin
		Declare @NoMasterId int;
		Declare @NoMasterNo nvarchar(50);
		Exec @NoMasterId = rm_GetIdentify 'NoMaster', @SelectId1, 0, @NoMasterNo Output;
		Select @Result = @NoMasterNo;
		Return @NoMasterId;
	End


	-- 获取随机公司Id
	IF (@SelectType = 31)
	Begin
		Declare @CoId int;
		Select Top 1 @CoId = Id From YouEx_ShippingCompany Where DepotId = @SelectId1 Order by newid();
		Return @CoId;
	End
	
	-- 获取随机公司Info
	IF (@SelectType = 32)
	Begin
		Select * From YouEx_ShippingCompany Where Id = @SelectId1;
		Return 32;
	End
	
	
	return 0;

END

