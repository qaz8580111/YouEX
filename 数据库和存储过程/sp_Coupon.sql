USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Coupon]    Script Date: 02/04/2016 10:12:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Coupon]
(
	@CommandType		int,
	@SelectType			int,
	@BeginTime			datetime,
	@EndTime			datetime,
	@Result				nvarchar(50) Output,

	@CouponNo			nvarchar(50),
	@CouponId			int,
	@Status				int,
	@OwnerId			int,
	@UserId				int,
	@CreateTime			datetime,
	@InvalidTime		datetime,
	@UsedTime			nvarchar(50),
	@Source				nvarchar(50),
	@Message			nvarchar(300)
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 1)
	Begin
		While (1 = 1)
		Begin
			Select @CouponNo = Substring(Ltrim(str(Convert(numeric, RAND() * 10e15),18)), 1, 12);
			IF Not EXISTS(SELECT * FROM YouEx_Coupon WHERE CouponNo = @CouponNo)
				Break;
		End

		INSERT INTO YouEx_Coupon(CouponNo, CouponId, [Status], OwnerId, UserId, CreateTime, InvalidTime, UsedTime, [Source], [Message])
			VALUES(@CouponNo, @CouponId, @Status, @OwnerId, @UserId, @CreateTime, @InvalidTime, @UsedTime, @Source, @Message);
		
		Select @Result = @CouponNo;
		Return @@IDENTITY;
	End


	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Coupon WHERE CouponNo = @CouponNo)
			Return -1;

		Update YouEx_Coupon Set 
				CouponId = @CouponId,
				[Status] = @Status,
				OwnerId = @OwnerId,
				UserId = @UserId,
				CreateTime = @CreateTime,
				InvalidTime = @InvalidTime,
				UsedTime = @UsedTime,
				[Source] = @Source,
				[Message] = @Message
			Where CouponNo = @CouponNo;
		return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Coupon WHERE CouponNo = @CouponNo)
			Return -1;
		Delete From YouEx_Coupon Where CouponNo = @CouponNo;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		-- 更新优惠券的是否还在有效期内
		Update YouEx_Coupon Set [Status] = 2 Where ([Status] = 0) and (InvalidTime > GETUTCDATE());

		-- 按CouponNo查询
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Coupon Where CouponNo = @CouponNo;
			Return 1;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';

		-- 按UserId查询
		If (@SelectType & 2) <> 0
			Select @strCmd = @strCmd + ' UserId = ' + ltrim(str(@UserId)) + ' And';

		-- 按CouponId查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' CouponId = ' + ltrim(str(@CouponId)) + ' And';

		-- 按Status查询
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' Status = ' + ltrim(str(@Status)) + ' And';

		-- 按CreateTime查询
		If (@SelectType & 16) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		Select @strCmd = 'Select * From YouEx_Coupon Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 3;
	End
	
	Return 0;

END
