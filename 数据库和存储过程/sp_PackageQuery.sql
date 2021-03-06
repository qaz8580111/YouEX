USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_PackageQuery]    Script Date: 02/04/2016 10:14:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PackageQuery]
(
	@DepotId		int,
	@GateId			int,
	@ShippingId		int,
	@ShippingNo		nvarchar(50),
	@UserName		nvarchar(50),
	@AgentName		nvarchar(50),
	@StorageNo		nvarchar(50),
	@AccessStatus	int,
	@BeginTime		datetime,
	@EndTime		datetime
)
AS
BEGIN
	SET NOCOUNT ON;
	
	

	-- 美国仓库
	IF @DepotId = 2
	Begin
		Select * From YouEx_Package Where (CreateTime >= @BeginTime) and (CreateTime <= @EndTime);
	End


	Return 1;
END

