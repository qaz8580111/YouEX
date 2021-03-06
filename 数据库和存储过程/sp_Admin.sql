USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Admin]    Script Date: 02/04/2016 10:10:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Admin]
(
	@CommandType	int,
	@SelectType		int,

	@Id				int,
	@AdminNo		nvarchar(50),
	@AdminName		nvarchar(50),
	@RealName		nvarchar(50),
	@Password		nvarchar(50),
	@DepotId		int,
	@DepartId		int,
	@Roles			nvarchar(50),
	@CreateTime		dateTime,
	@LastTime		dateTime,
	@LastIp			nvarchar(50),
	@LoginTimes		int
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		IF EXISTS(SELECT * FROM YouEx_Admin WHERE (AdminNo = @AdminNo) or (AdminName = @AdminName))
			Return 0;

		INSERT INTO YouEx_Admin(AdminNo, AdminName, RealName, [Password], DepotId, DepartId, Roles, CreateTime, LastTime, LastIp, LoginTimes)
			VALUES(@AdminNo, @AdminName, @RealName, @Password, @DepotId, @DepartId, @Roles, @CreateTime, @LastTime, @LastIp, @LoginTimes);

		Return @@IDENTITY;
	End
	

	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Admin WHERE Id = @Id)
			Return 0;

		Update YouEx_Admin Set 
			AdminNo = @AdminNo,
			AdminName = @AdminName,
			RealName = @RealName,
			[Password] = @Password,
			DepotId = @DepotId,
			DepartId = @DepartId,
			Roles = @Roles,
			CreateTime = @CreateTime,
			LastTime = @LastTime,
			LastIp = @LastIp,
			LoginTimes = @LoginTimes
			Where Id = @Id;
		
		return 1;
	End
	
	
	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Admin WHERE Id = @Id)
			Return 0;

		Delete From YouEx_Admin Where Id = @Id;
		Return 1;
	End
	

	IF(@CommandType = 4)
	Begin
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		/*按AdminId查询*/
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Admin Where Id = @Id;
			Return 1;
		End

		/*按AdminNo查询*/
		If (@SelectType = 2)
		Begin
			Select * From YouEx_Admin Where AdminNo = @AdminNo;
			Return 2;
		End
		
		/*按AdminName查询*/
		If (@SelectType = 3)
		Begin
			Select * From YouEx_Admin Where AdminName = @AdminName;
			Return 3;
		End

		/*按Login查询*/
		If (@SelectType = 4)
		Begin
			If Not Exists(Select * From YouEx_Admin Where ([Password] = @Password) And ((AdminNo = @AdminNo) or (AdminName = @AdminName)) And (DepotId = @DepotId))
				Return 0;
			
			Update YouEx_Admin Set
				LastTime = GETDATE(),
				LastIp = @LastIp,
				LoginTimes = LoginTimes + 1
				Where ([Password] = @Password) And ((AdminNo = @AdminNo) or (AdminName = @AdminName));
		
			Select * From YouEx_Admin Where ([Password] = @Password) And ((AdminNo = @AdminNo) or (AdminName = @AdminName)) And (DepotId = @DepotId);
			
			Return 4;
		End
		return 0;
	End

END

