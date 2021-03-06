USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveFavouriteWinesByUserIdServerAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveFavouriteWinesByUserIdServerAlt]
@userId int
as
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
	--inner join [Enosoft].[dbo].[Wines] a with (nolock)  on a.WineId = l.WineId
	--inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock) on a.WineId = dt.WineId
	inner join WineDetails det with (nolock)  on l.BarCode = det.BarCode
	where l.Liked=1 and l.UserId=@userID;
end
GO
