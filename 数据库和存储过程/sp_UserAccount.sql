USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_UserAccount]    Script Date: 02/04/2016 10:15:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_UserAccount]
(
	@CommandType	int,
	@SelectType		int,

	@Id				int,
	@UserId			int,
	@CurrencyId		int,
	@Default		int,
	@Status			int,
	@Name			nvarchar(50),
	@Money			decimal(18, 2),
	@Frozen			decimal(18, 2),
	@Credit			decimal(18, 2),
	@FlyMoney		int,
	@Score			int
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_UserAccount WHERE (UserId = @UserId) and (Name = @Name))
			Return 0;

		IF @Default = 1
		Begin
			IF EXISTS(SELECT * FROM YouEx_UserAccount WHERE (UserId = @UserId) and ([Default] = 1))
			Begin
				Update YouEx_UserAccount Set [Default] = 0 Where UserId = @UserId;
			End
		End
		Else
		Begin
			IF Not EXISTS(SELECT * FROM YouEx_UserAccount WHERE (UserId = @UserId) and ([Default] = 1))
			Begin
				Select @Default = 1;
			End
		End

		INSERT INTO YouEx_UserAccount ( UserId, CurrencyId, [Default], [Status], Name, [Money], Frozen, Credit, FlyMoney, Score)
			VALUES( @UserId, @CurrencyId, @Default, @Status, @Name, @Money, @Frozen, @Credit, @FlyMoney, @Score );

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		If NOT EXISTS(SELECT * FROM YouEx_UserAccount WHERE Id = @Id)
			Return 0;

		Select @UserId = UserId FROM YouEx_UserAccount WHERE Id = @Id

		If NOT EXISTS(SELECT * FROM YouEx_UserAccount WHERE (Id = @Id) And ([Default] = @Default))
		Begin
			If @Default = 1
			Begin
				Update YouEx_UserAccount Set [Default] = 0 Where UserId = @UserId;
			End
			Else
			Begin
				If Exists (Select * From YouEx_UserAccount Where (UserId = @UserId) And (Id <> @Id))
				Begin
					Update YouEx_UserAccount Set [Default] = 1 Where Id = (Select Top(1) Id From YouEx_UserAccount Where (UserId = @UserId) And (Id <> @Id));
				End
				Else
				Begin
					Select @Default = 1;
				End
			End
		End

		Update YouEx_UserAccount Set
			[Default] = @Default,
			[Status] = @Status,
			Name = @Name,
			[Money] = @Money,
			Frozen = @Frozen,
			Credit = @Credit,
			FlyMoney = @FlyMoney,
			Score = @Score
			Where Id = @Id;

		return 1;
	End


	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_UserAccount Where Id = @Id)
			Return 0;

		Delete From YouEx_UserAccount Where Id = @Id;

		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		/*按Id查询*/
		If (@SelectType & 1) <> 0
			Select * From YouEx_UserAccount Where Id = @Id;

		/*按UserId查询*/
		If (@SelectType & 2) <> 0
			Select * From YouEx_UserAccount Where UserId = @UserId;

		/*按UserId查询Default*/
		If (@SelectType & 4) <> 0
			Select * From YouEx_UserAccount Where (UserId = @UserId) And ([Default] = 1);

		return 1;
	End
	
	Return 0;

END
