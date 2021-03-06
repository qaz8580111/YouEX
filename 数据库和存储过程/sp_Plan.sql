USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sp_Plan]    Script Date: 02/04/2016 10:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Plan]
(
	@CommandType		int,
	@SelectType			int,
	@WhereStr			nvarchar(1000),
	@Result				nvarchar(50) Output,

	@PlanId				int,
	@PlanNo				nvarchar(50),
	@Content			Xml
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF(@CommandType = 1)
	Begin
	
		IF @PlanId <> 0
		Begin
			IF Exists(Select * From YouEx_Plan Where PlanId = @PlanId)
				return 0;
		End

		IF @PlanNo <> ''
		Begin
			IF Exists(Select * From YouEx_Plan Where PlanNo = @PlanNo)
				return 0;
		End
		
		Declare @DepotId int;
		Select @DepotId = @Content.value('(/Root/Plan/DepotId)[1]', 'int');
		Exec @PlanId = rm_GetIdentify 'Plan', @DepotId, 0, @PlanNo Output;

		Declare @CreateTime datetime;
		Select @CreateTime = GETDATE();

		Set @Content.modify('insert text{sql:variable("@PlanNo")} into (/Root/Plan/PlanNo)[1]');
		Set @Content.modify('insert text{sql:variable("@PlanId")} into (/Root/Plan/PlanId)[1]');
		Set @Content.modify('insert if(/Root/Plan[CreateTime = ""]) then text{sql:variable("@CreateTime")} else() into (/Root/Plan/CreateTime)[1]');

		Insert Into YouEx_Plan (PlanId, PlanNo, Content)
			Values(@PlanId, @PlanNo, @Content);

		Select @Result = @PlanNo;
		Return @PlanId;
	End
	
	
	IF(@CommandType = 2)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Plan WHERE PlanNo = @PlanNo)
			Return 0;
		Update YouEx_Plan Set Content = @Content Where PlanNo = @PlanNo;
		return 1;
	End
	
	
	IF(@CommandType = 3)
	Begin
		IF NOT EXISTS(SELECT * FROM YouEx_Plan WHERE PlanNo = @PlanNo)
			Return 0;
		Delete From YouEx_Plan Where PlanNo = @PlanNo;
		Return 1;
	End


	IF(@CommandType = 4)
	Begin
		Declare @strCmd nvarchar(2000);
		
		--按PlanId查询订单
		If (@SelectType = 1)
		Begin
			Select * From YouEx_Plan Where PlanId = @PlanId;
			Return 1;
		End

		--按PlanNo查询订单
		If (@SelectType = 2)
		Begin
			Select * From YouEx_Plan Where PlanNo = @PlanNo;
			Return 2;
		End
		
		--按WhereStr自定义查询订单
		If (@SelectType = 3)
		Begin
			Select @strCmd = 'Select * From YouEx_Plan Where ' + Rtrim(@WhereStr);
			Print(@strCmd);
			Exec(@strCmd);
			return 3;
		End


		Select @strCmd = 'Select * From YouEx_Plan Where ' + Rtrim(@WhereStr);
		Print(@strCmd);
		Exec(@strCmd);
		return 4;
	End
	
	Return 0;

END
