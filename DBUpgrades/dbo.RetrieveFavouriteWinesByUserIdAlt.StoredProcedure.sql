USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveFavouriteWinesByUserIdAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec RetrieveFavouriteWinesByUserIdAlt 3
CREATE procedure [dbo].[RetrieveFavouriteWinesByUserIdAlt] 
@userId int
as
begin
begin try
declare @checkWall int;
declare @checkPP int;
set @checkWall = isnull((select top 1 wineid from [wall].[enosoft].dbo.wines with (nolock)),0);
--set @checkWall = 0;
set @checkPP = isnull((select top 1 wineid from [PointPleasent].[enosoft].dbo.wines with (nolock)),0);
if @checkWall <> 0 
	begin
	if @checkPP <> 0
	begin
	(select  l.SKU as SKU,a.LabelName as Name,
	a.YearOfWine as Vintage,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 1 as Liked,
	 dt.PlantFinal as PlantFinal,
	 l.WineId,
	 a.BarCode,
	 isnull(det.AverageRating,0) as AverageRating
	from Likes l with (nolock)   
	inner join [Wall].[Enosoft].[dbo].[Wines] a with (nolock)  on a.BarCode = l.BarCode
	inner join [Wall].[Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	--inner join [Enosoft].[dbo].[Wines] a with (nolock)  on a.WineId = l.WineId
	--inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	inner join WineDetails det with (nolock)  on l.BarCode = det.BarCode
	where l.Liked=1 and l.UserId=@userID)
	union all
	(select  l.SKU as SKU,a.LabelName as Name,
	a.YearOfWine as Vintage,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 1 as Liked,
	 dt.PlantFinal as PlantFinal,
	 l.WineId,
	 a.BarCode,
	 isnull(det.AverageRating,0) as AverageRating
	from Likes l with (nolock)   
	inner join [pointpleasent].[Enosoft].[dbo].[Wines] a with (nolock)  on a.BarCode = l.BarCode
	inner join [pointpleasent].[Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	inner join WineDetails det with (nolock)  on l.BarCode = det.BarCode
	where l.Liked=1 and l.UserId=@userID)
	end
	else
	begin
		select  l.SKU as SKU,a.LabelName as Name,
	a.YearOfWine as Vintage,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 1 as Liked,
	 dt.PlantFinal as PlantFinal,
	 l.WineId,
	 a.BarCode,
	 isnull(det.AverageRating,0) as AverageRating
	from Likes l with (nolock)   
	inner join [Enosoft].[dbo].[Wines] a with (nolock)  on a.BarCode = l.BarCode
	inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	inner join WineDetails det with (nolock)  on l.BarCode = det.BarCode
	where l.Liked=1 and l.UserId=@userID
	end
	end
	else
	begin
		select  l.SKU as SKU,a.LabelName as Name,
	a.YearOfWine as Vintage,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 1 as Liked,
	 dt.PlantFinal as Plantfinal,
	 l.WineId,
	 a.BarCode,
	 isnull(det.AverageRating,0) as AverageRating
	from Likes l with (nolock)   
	inner join [Enosoft].[dbo].[Wines] a with (nolock)  on a.BarCode = l.BarCode
	inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	inner join WineDetails det with (nolock)  on l.BarCode = det.BarCode
	where l.Liked=1 and l.UserId=@userID
	end
end try
begin catch
	if @checkWall = 0
	begin
		exec RetrieveFavouriteWinesByUserIdServerPPAlt @userId
	end
	else
	begin
		exec RetrieveFavouriteWinesByUserIdServerAlt @userId
	end
end catch
end


GO
