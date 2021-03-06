USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_XmlTrack]    Script Date: 02/04/2016 10:17:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_XmlTrack]
(
	@CommandType	int,
	@SelectType		int,
	@BeginTime		DateTime,
	@EndTime		DateTime,

	@TrackId		int,
	@ShippingNo		nvarchar(50),
	@ShippingName	nvarchar(50),
	@NewShipping	nvarchar(300),
	@Status			int,
	@CreateTime		DateTime,
	@UpdateTime		DateTime,
	@Content		Xml
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(@CommandType = 1)
	Begin
		IF Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
			Return -1;

		INSERT INTO YouEx_XmlTrack (ShippingNo, ShippingName, NewShipping, [Status], CreateTime, UpdateTime, Content)
			VALUES(@ShippingNo, @ShippingName, @NewShipping, @Status, @CreateTime, @UpdateTime, @Content);

		Return 1;
	End
	

	IF(@CommandType = 2)
	Begin
		If Not Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
			Return 0;
		
		Update YouEx_XmlTrack Set
				ShippingName = @ShippingName,
				NewShipping = @NewShipping,
				[Status] = @Status,
				UpdateTime = @UpdateTime,
				Content = @Content
			Where ShippingNo = @ShippingNo;
		Return 1;
	End
	

	IF(@CommandType = 3)
	Begin
		If Not Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
			Return 0;

		Delete From YouEx_XmlTrack Where ShippingNo = @ShippingNo;
		return 1;
	End


	IF(@CommandType = 4)
	Begin
		Declare @TrackFinish int;
		Declare @TrackDelete int;
		
		Select @TrackFinish = Value From YouEx_SystemEnum Where [Type] = 'Config' And Name = 'TrackFinish';
		Select @TrackDelete = Value From YouEx_SystemEnum Where [Type] = 'Config' And Name = 'TrackDelete';
		
		-- 超时未更新的包裹信息，停止更新。
		Update YouEx_XmlTrack Set [Status] = 4 Where [Status] = 2 and DATEDIFF(day, UpdateTime, GETUTCDATE()) > @TrackFinish;

		-- 删除不在本系统中的超时的包裹物流信息。
/*		Delete From YouEx_XmlTrack 
			Where (ShippingNo not in (Select ShippingNo From YouEx_Package))
				And (DATEDIFF(day, CreateTime, GETUTCDATE()) > @TrackDelete);
*/	
		-- 按TrackId查询
		If @SelectType = 1
		Begin
			Select * From YouEx_XmlTrack Where TrackId = @TrackId;
			Return 1;
		End
		
		-- 按ShippingNo查询
		If @SelectType = 2
		Begin
			IF Exists(Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo)
				Select * From YouEx_XmlTrack Where ShippingNo = @ShippingNo;
			Else
				Select * From YouEx_XmlTrack Where (@ShippingNo like '%' + ShippingNo) and (ShippingNo <> '');
			Return 2;
		End

		Declare @strCmd nvarchar(2000);
		Select @strCmd = '';
		
		-- 按Status查询
		If (@SelectType & 4) <> 0
			Select @strCmd = @strCmd + ' [Status] = ' + ltrim(str(@Status)) + ' And';

		/*按创建时间查询*/
		If (@SelectType & 8) <> 0
			Select @strCmd = @strCmd + ' CreateTime >= ''' + Convert(nvarchar, @BeginTime, 21) + ''' And CreateTime <= ''' + Convert(nvarchar, @EndTime, 21) + ''' And';

		If @strCmd = ''
			return -1;

		Select @strCmd = 'Select * From YouEx_XmlTrack Where' + Rtrim(@strCmd) + ' 1 = 1';
		Print(@strCmd);
		Exec(@strCmd);
		return 1;
	End
	
	Return 0;
END

