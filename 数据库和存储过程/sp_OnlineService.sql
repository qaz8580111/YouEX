USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_OnlineService]    Script Date: 02/04/2016 10:13:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_OnlineService]
(
	@CommandType	int,
	@SelectType		int,

	@Id				int,
	@UserName		nvarchar(100),
	@UserId			int,
	@AdminId		int,
	@Status			int,
	@Mobile			nvarchar(50),
	@Email			nvarchar(50),
	@WeiXin			nvarchar(50),
	@CreateTime		datetime,
	@Question		nvarchar(50),
	@Answer			nvarchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		INSERT INTO YouEx_OnlineService (UserName, UserId, AdminId, [Status], Mobile, Email, WeiXin, CreateTime, Question, Answer)
			VALUES(@UserName, @UserId, @AdminId, @Status, @Mobile, @Email, @WeiXin, @CreateTime, @Question, @Answer);

		Return @@IDENTITY;
	End
	
	
	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_OnlineService WHERE Id = @Id)
			Return 0;

		Update YouEx_OnlineService Set 
			UserName = @UserName,
			UserId = @UserId,
			AdminId = @AdminId,
			[Status] = @Status,
			Mobile = @Mobile,
			Email = @Email,
			WeiXin = @WeiXin,
			CreateTime = @CreateTime,
			Question = @Question,
			Answer = @Answer
			Where Id = @Id;
		
		Return 1;
	End


	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_OnlineService Where Id = @Id)
			Return 0;

		Delete From YouEx_OnlineService Where Id = @Id;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		IF @SelectType = 1
		Begin
			Select * From YouEx_OnlineService Where Id = @Id;
			Return 1;
		End
		
		IF @SelectType = 2
		Begin
			Select * From YouEx_OnlineService Where UserId = @UserId;
			Return 2;
		End

		IF @SelectType = 3
		Begin
			Select * From YouEx_OnlineService Where AdminId = @AdminId;
			Return 3;
		End
		
		IF @SelectType = 4
		Begin
			Select * From YouEx_OnlineService Where [Status] = @Status;
			Return 4;
		End
		
		Return 0;
	End
	Return 0;
END
