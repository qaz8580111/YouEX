USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateLogXml]    Script Date: 02/04/2016 10:19:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateLogXml]
(
	@OrderId	int,
	@LogList	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;

	Select @LogList = '<OrderLog/>';
	Declare @LogId			int,
			@PackageNo		nvarchar(50),
			@ServiceNo		nvarchar(50),
			@UserId			int,
			@AccessTime		datetime,
			@AccessCode		nvarchar(50),
			@Content		nvarchar(200),
			
			@LogContent		xml;

	Declare @id int;
	Select @LogId = 1;
	Select @id = MIN(LogId) From maj_fedroad.dbo.Maj_OrderLog Where ItemId = @OrderId and ItemType = 0;
	While @id is not null
	Begin
		Select @UserId = UserId,
			   @PackageNo = '',
			   @ServiceNo = '',
			   @AccessTime = ActionTime,
			   @AccessCode = ActionCode,
			   @Content = Remark
			From maj_fedroad.dbo.Maj_OrderLog Where LogId = @id;

		Select @LogContent = '<Log><LogId/><PackageNo/><ServiceNo/><UserId/><AccessTime/><AccessCode/><Content/></Log>';
		Set @LogContent.modify('insert text{sql:variable("@LogId")} into (/Log/LogId)[1]');
		Set @LogContent.modify('insert text{sql:variable("@PackageNo")} into (/Log/PackageNo)[1]');
		Set @LogContent.modify('insert text{sql:variable("@ServiceNo")} into (/Log/ServiceNo)[1]');
		Set @LogContent.modify('insert text{sql:variable("@UserId")} into (/Log/UserId)[1]');
		Set @LogContent.modify('insert text{sql:variable("@AccessTime")} into (/Log/AccessTime)[1]');
		Set @LogContent.modify('insert text{sql:variable("@AccessCode")} into (/Log/AccessCode)[1]');
		Set @LogContent.modify('insert text{sql:variable("@Content")} into (/Log/Content)[1]');

		Set @LogList.modify('insert sql:variable("@LogContent") as last into (/OrderLog)[1]');

		Select @LogId = @LogId + 1;
	Select @id = MIN(LogId) From maj_fedroad.dbo.Maj_OrderLog Where ItemId = @OrderId and ItemType = 0 and LogId > @id;
	End

	Return 1;
END
