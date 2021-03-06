USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveUnavailableWines]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveAvailableWines] 0002
Create PROCEDURE [dbo].[RetrieveUnavailableWines]
         @PlantFinal int
		 ,@userid int
as
begin

     Select a.zone as SKU, a.LabelName as Name, a.YearOfWine as Vintage,
	 '' as Region,
	 '' as Country,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 --det.SalePrice,
	 --det.RegPrice,
	 isNull((det.TotalRating/det.TotalUsersRated),5) as AverageRating,
	 isNull(lk.liked,0) as Liked,
	 '' as SmallImageURL,
	 a.WineId,
	 dt.DispenserCode,
	 dt.PositionTap
	 from [Enosoft].[dbo].[Wines] a 
	 inner join [Enosoft].[dbo].[DispenserTaps] dt on a.WineId  = dt.WineId
		left join WineDetails det on a.WineId = det.WineID
		left join Likes lk on (lk.WineId = a.WineId and lk.UserId=@userid)
		where a.wineid in 
			(Select WineId from [Enosoft].[dbo].[DispenserTaps] where PlantFinal = @PlantFinal)
			and a.Enabled = 0;
			--and a.zone is not null;

end

GO
