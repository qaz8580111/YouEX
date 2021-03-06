USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Message]    Script Date: 02/04/2016 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Message]
(
	@CommandType		int,
	@SelectType			int,
	@BeginTime			datetime,
	@EndTime			datetime,

	@MsgId				int,
	@Type				int,
	@Status				int,
	@UserId				int,
	@Mobile				nvarchar(50),
	@Email				nvarchar(200),
	@TempletCode		nvarchar(50),
	@Subject			nvarchar(100),
	@Message			nvarchar(2000),
	@KeyString			nvarchar(200),
	@ValidateTime		int,
	@CreateTime			datetime,
	@SendTime			dateTime
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		INSERT INTO YouEx_Message([Type], [Status], UserId, Mobile, Email, TempletCode, [Subject], [Message], KeyString, ValidateTime, CreateTime, SendTime)
			VALUES(@Type, @Status, @UserId, @Mobile, @Email, @TempletCode, @Subject, @Message, @KeyString, @ValidateTime, @CreateTime, @SendTime);

		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Message WHERE MsgId = @MsgId)
			Return 0;

		Update YouEx_Message Set 
				[Type] = @Type,
				[Status] = @Status,
				UserId = @UserId,
				Mobile = @Mobile,
				Email = @Email,
				TempletCode = @TempletCode,
				[Subject] = @Subject,
				[Message] = @Message,
				KeyString = @KeyString,
				ValidateTime = @ValidateTime,
				CreateTime = @CreateTime,
				SendTime = @SendTime
			Where MsgId = @MsgId;
		
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Message WHERE MsgId = @MsgId)
			Return 0;
		Delete From YouEx_Message Where MsgId = @MsgId;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 按MsgId查询订单
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Message Where MsgId = @MsgId;
			Return 1;
		End
		
		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';
		
		-- 按Type查询
		If (@SelectType & 2) <> 0
			Select @strCmd = @strCmd + ' [Type] = ' + ltrim(str(@Type)) + ' And';
			
		-- 按Status查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' [Status] = ' + ltrim(str(@Status)) + ' And';
			
		-- 按UserId查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';
			
		-- 按Mobile查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' Mobile = ''' + ltrim(@Mobile) + ''' And';

		-- 按Email查询
		If (@SelectType & 32) <> 0
			Select @strCmd = @strCmd + ' Email = ''' + ltrim(@Email) + ''' And';
			
		-- 按TempletCode查询
		If (@SelectType & 64) <> 0
			Select @strCmd = @strCmd + ' TempletCode = ''' + ltrim(@TempletCode) + ''' And';
			
		-- 按KeyString查询
		If (@SelectType & 128) <> 0
			Select @strCmd = @strCmd + ' KeyString = ''' + ltrim(@KeyString) + ''' And';

		-- 按CreateTime查询
		If (@SelectType & 256) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		-- 检查有效期限
		If (@SelectType & 512) <> 0
			Select @strCmd = @strCmd + ' DATEDIFF(minute, SendTime, GetUtcDate()) <= ValidateTime And';

		Select @strCmd = 'Select * From YouEx_Message Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 2;
	End
	
	Return 0;

END
