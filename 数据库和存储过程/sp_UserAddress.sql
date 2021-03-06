USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_UserAddress]    Script Date: 02/04/2016 10:15:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_UserAddress]
(
	@CommandType	int,
	@SelectType		int,

	@Id				int,
	@UserId			int,
	@DepotId		int,
	@Default		int,
	@Name			nvarchar(50),
	@Email			nvarchar(200),
	@Phone			nvarchar(50),
	@Mobile			nvarchar(50),
	@Recipients		nvarchar(50),
	@RecipientsEn	nvarchar(50),
	@Country		int,
	@Province		int,
	@City			int,
	@Address		nvarchar(200),
	@AddressEn		nvarchar(200),
	@ZipCode		nvarchar(50),
	@IdCard			nvarchar(50),
	@IdFront		nvarchar(200),
	@IdBack			nvarchar(200),
	@Remark			nvarchar(200)
)
AS
BEGIN
	SET NOCOUNT ON;
	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_UserAddress WHERE (UserId = @UserId) and (Name = @Name))
			Return 0;

		IF @Default = 1
		Begin
			IF EXISTS(SELECT * FROM YouEx_UserAddress WHERE (UserId = @UserId) and ([Default] = 1))
			Begin
				Update YouEx_UserAddress Set [Default] = 0 Where UserId = @UserId;
			End
		End
		Else
		Begin
			IF Not EXISTS(SELECT * FROM YouEx_UserAddress WHERE (UserId = @UserId) and ([Default] = 1))
			Begin
				Select @Default = 1;
			End
		End

		INSERT INTO YouEx_UserAddress ( UserId, DepotId, [Default], Name, Email, Phone, Mobile, Recipients, RecipientsEn, Country, Province, City, [Address], AddressEn, ZipCode, IdCard, IdFront, IdBack, Remark)
			VALUES( @UserId, @DepotId, @Default, @Name, @Email, @Phone, @Mobile, @Recipients, @RecipientsEn, @Country, @Province, @City, @Address, @AddressEn, @ZipCode, @IdCard, @IdFront, @IdBack, @Remark );

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		If NOT EXISTS(SELECT * FROM YouEx_UserAddress WHERE Id = @Id)
			Return 0;

		Select @UserId = UserId FROM YouEx_UserAddress WHERE Id = @Id

		If NOT EXISTS(SELECT * FROM YouEx_UserAddress WHERE (Id = @Id) And ([Default] = @Default))
		Begin
			If @Default = 1
			Begin
				Update YouEx_UserAddress Set [Default] = 0 Where UserId = @UserId;
			End
			Else
			Begin
				If Exists (Select * From YouEx_UserAddress Where (UserId = @UserId) And (Id <> @Id))
				Begin
					Update YouEx_UserAddress Set [Default] = 1 Where Id = (Select Top(1) Id From YouEx_UserAddress Where (UserId = @UserId) And (Id <> @Id));
				End
				Else
				Begin
					Select @Default = 1;
				End
			End
		End

		Update YouEx_UserAddress Set
			DepotId = @DepotId,
			[Default] = @Default,
			Name = @Name,
			Email = @Email,
			Phone = @Phone,
			Mobile = @Mobile,
			Recipients = @Recipients,
			RecipientsEn = @RecipientsEn,
			Country = @Country,
			Province = @Province,
			City = @City,
			[Address] = @Address,
			AddressEn = @AddressEn,
			ZipCode = @ZipCode,
			IdCard = @IdCard,
			IdFront = @IdFront,
			IdBack = @IdBack,
			Remark = @Remark
			Where Id = @Id;

		return 1;
	End

	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_UserAddress Where Id = @Id)
			Return 0;

		Delete From YouEx_UserAddress Where Id = @Id;

		return 1;
	End


	IF(@CommandType = 4)
	Begin
		/*按Id查询*/
		If (@SelectType & 1) <> 0
			Select A.*, B.Name as CountryName, B.NameEn as CountryNameEn, C.Name as ProvinceName, C.NameEn as ProvinceNameEn, D.Name as CityName, D.NameEn as CityNameEn
				From YouEx_UserAddress A left join YouEx_Area B On A.Country = B.Id left join YouEx_Area C On A.Province = C.Id left join YouEx_Area D On A.City = D.Id
				Where A.Id = @Id;

		/*按UserId查询*/
		If (@SelectType & 2) <> 0
			Select A.*, B.Name as CountryName, B.NameEn as CountryNameEn, C.Name as ProvinceName, C.NameEn as ProvinceNameEn, D.Name as CityName, D.NameEn as CityNameEn
				From YouEx_UserAddress A left join YouEx_Area B On A.Country = B.Id left join YouEx_Area C On A.Province = C.Id left join YouEx_Area D On A.City = D.Id
				Where A.UserId = @UserId;

		/*按UserId查询Default*/
		If (@SelectType & 4) <> 0
			Select A.*, B.Name as CountryName, B.NameEn as CountryNameEn, C.Name as ProvinceName, C.NameEn as ProvinceNameEn, D.Name as CityName, D.NameEn as CityNameEn
				From YouEx_UserAddress A left join YouEx_Area B On A.Country = B.Id left join YouEx_Area C On A.Province = C.Id left join YouEx_Area D On A.City = D.Id
				Where (A.UserId = @UserId) And (A.[Default] = 1);

		/*按IdCard查询*/
		If (@SelectType & 8) <> 0
			Select A.*, B.Name as CountryName, B.NameEn as CountryNameEn, C.Name as ProvinceName, C.NameEn as ProvinceNameEn, D.Name as CityName, D.NameEn as CityNameEn
				From YouEx_UserAddress A left join YouEx_Area B On A.Country = B.Id left join YouEx_Area C On A.Province = C.Id left join YouEx_Area D On A.City = D.Id
				Where A.IdCard = @IdCard;

		return 1;
	End

	Return 0;

END
