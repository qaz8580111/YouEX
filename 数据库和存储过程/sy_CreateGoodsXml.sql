USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateGoodsXml]    Script Date: 02/04/2016 10:18:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateGoodsXml]
(
	@OrderId		int,
	@PackageId		int,
	@DeliveryId		int,
	@GoodsContent	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Select @GoodsContent = '<PackageGoods></PackageGoods>';
	Declare @GoodsId	int,
			@Name		nvarchar(200),
			@Spec		nvarchar(50),
			@Count		int,
			@Brand		nvarchar(20),
			@Price		decimal,
			@ItemContent	Xml;

	IF @OrderId <> 0
	Begin
		Declare @id int;
		Select @GoodsId = 1;
		Select @id = MIN(id) From maj_fedroad.dbo.Maj_Goods_Forecast Where order_id = @OrderId;
		While @id is not null
		Begin
			Select @Name = name,
				   @Spec = '',
				   @Count = [count],
				   @Brand = brand,
				   @Price = price
				From maj_fedroad.dbo.Maj_Goods_Forecast Where id = @id;

			Exec sy_CreateGoodsItemXml @GoodsId, @Name, @Spec, @Count, @Brand, @Price, @ItemContent Output;
			Set @GoodsContent.modify('insert sql:variable("@ItemContent") as last into (/PackageGoods)[1]');

			Select @GoodsId = @GoodsId + 1;
			Select @id = MIN(id) From maj_fedroad.dbo.Maj_Goods_Forecast Where order_id = @OrderId and id > @id;
		End
		Return 1;
	End



	IF @PackageId <> 0
	Begin
		Select @Name = GoodsName,
			   @Spec = Attribute,
			   @Price = AdjustedPrice,
			   @GoodsId = 1,
			   @Count = 1,
			   @Brand = ''
		   From maj_fedroad.dbo.Maj_OrderGoods Where OrderGoodsId = @PackageId and IsCenceled = 0;
		Exec sy_CreateGoodsItemXml @GoodsId, @Name, @Spec, @Count, @Brand, @Price, @ItemContent Output;
		Set @GoodsContent.modify('insert sql:variable("@ItemContent") as last into (/PackageGoods)[1]');
		Return 2;
	End

	IF @DeliveryId <> 0
	Begin
		Declare @pid int;
		Select @GoodsId = 1;
		Select @pid = MIN(Id) From maj_fedroad.dbo.Maj_Delivery_Shops Where DeliverId = @DeliveryId;
		While @pid is not null
		Begin
			Select @Name = Name,
				  @Spec = Specifi,
				  @Count = Number,
				  @Brand = Brand,
				  @Price = Price
				From maj_fedroad.dbo.Maj_Delivery_Shops Where Id = @pid;

			Exec sy_CreateGoodsItemXml @GoodsId, @Name, @Spec, @Count, @Brand, @Price, @ItemContent Output;
			Set @GoodsContent.modify('insert sql:variable("@ItemContent") as last into (/PackageGoods)[1]');

			Select @GoodsId = @GoodsId + 1;
			Select @pid = MIN(Id) From maj_fedroad.dbo.Maj_Delivery_Shops Where DeliverId = @DeliveryId and Id > @pid;
		End
		Return 3;
	End
	
	Return 0;
END
