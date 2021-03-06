USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Area]    Script Date: 02/04/2016 10:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Area]
(
	@CommandType	int,
	@SelectType		int,

	@Id				int,
	@Name			nvarchar(50),
	@NameEn			nvarchar(50),
	@ParentId		int,
	@ParentPath		nvarchar(50),
	@Depth			int
)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CommandType = 4)
	Begin
		/*按AreaId查询*/
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Area Where Id = @Id;
			Return 1;
		End

		/*按ParentId查询*/
		If (@SelectType = 2)
		Begin
			IF @ParentId = -1
				Select * From YouEx_Area;
			Else
				Select * From YouEx_Area Where ParentId = @ParentId;
			Return 2;
		End
		
		/*查询国家列表*/
		If (@SelectType = 3)
		Begin
			Select * From YouEx_Area Where Depth = 1;
			Return 3;
		End
		
		-- 根据名称查询Id
		If (@SelectType = 4)
		Begin
			Select * From YouEx_Area Where Name = @Name;
			Return 4;
		End
		
		return 0;
	End

END

