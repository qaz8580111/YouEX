USE [YouEx3.0]
GO
/****** Object:  StoredProcedure [dbo].[sy_CreateGoodsItemXml]    Script Date: 02/04/2016 10:18:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sy_CreateGoodsItemXml]
(
	@GoodsId		int,
	@Name			nvarchar(200),
	@Spec			nvarchar(50),
	@Count			int,
	@Brand			nvarchar(20),
	@Price			decimal,
	@GoodsContent	Xml Output
)
AS
BEGIN
	SET NOCOUNT ON;
	
	Select @GoodsContent = '<Goods><GoodsId/><Name/><Brand/><Spec/><Count/><Price/><CurrencyId/><BuyUrl/><BarCode/><RefId/><RefUrl/></Goods>';

	Set @GoodsContent.modify('insert text{sql:variable("@GoodsId")} into (/Goods/GoodsId)[1]');
	Set @GoodsContent.modify('insert text{sql:variable("@Name")} into (/Goods/Name)[1]');
	Set @GoodsContent.modify('insert text{sql:variable("@Spec")} into (/Goods/Spec)[1]');
	Set @GoodsContent.modify('insert text{sql:variable("@Brand")} into (/Goods/Brand)[1]');
	Set @GoodsContent.modify('insert text{sql:variable("@Count")} into (/Goods/Count)[1]');
	Set @GoodsContent.modify('insert text{sql:variable("@Price")} into (/Goods/Price)[1]');
	Set @GoodsContent.modify('insert text{2} into (/Goods/CurrencyId)[1]');

	Return 0;
END
