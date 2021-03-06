USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateTrackXml]    Script Date: 02/04/2016 10:20:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateTrackXml]
(
	@DeliveryId		int,
	@TrackList		Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;

	Select @TrackList = '<PackageTrack></PackageTrack>';
	Declare @TrackId		int,
			@AdminId		int,
			@TrackTime		datetime,
			@ActionCode		nvarchar(50),
			@Message		nvarchar(200),
			@Location		nvarchar(2000),
			
			@TrackContent	xml;

	Declare @id int;
	Select @TrackId = 1;
	Select @id = MIN(TackId) From maj_fedroad.dbo.Maj_Delivery_Track Where DeliverId = @DeliveryId;
	While @id is not null
	Begin
		Select @AdminId = OperatorId,
			   @TrackTime = ActionTime,
			   @ActionCode = ActionCode,
			   @Message = [Message],
			   @Location = ''
			From maj_fedroad.dbo.Maj_Delivery_Track Where TackId = @id;

		Select @TrackContent = '<Track><TrackId/><AdminId/><TrackTime/><ActionCode/><Message/><Location/></Track>';
		Set @TrackContent.modify('insert text{sql:variable("@TrackId")} into (/Track/TrackId)[1]');
		Set @TrackContent.modify('insert text{sql:variable("@AdminId")} into (/Track/AdminId)[1]');
		Set @TrackContent.modify('insert text{sql:variable("@TrackTime")} into (/Track/TrackTime)[1]');
		Set @TrackContent.modify('insert text{sql:variable("@ActionCode")} into (/Track/ActionCode)[1]');
		Set @TrackContent.modify('insert text{sql:variable("@Message")} into (/Track/Message)[1]');
		Set @TrackContent.modify('insert text{sql:variable("@Location")} into (/Track/Location)[1]');

		Set @TrackList.modify('insert sql:variable("@TrackContent") as last into (/PackageTrack)[1]');

		Select @TrackId = @TrackId + 1;
		Select @id = MIN(TackId) From maj_fedroad.dbo.Maj_Delivery_Track Where DeliverId = @DeliveryId and TackId > @id;
	End

	Return 1;
END
