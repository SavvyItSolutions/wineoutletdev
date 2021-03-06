USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAvailableWinesFromServerAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveAvailableWines] 1,1
CREATE PROCEDURE [dbo].[RetrieveAvailableWinesFromServerAlt]
         @PlantFinal int
		 ,@userid int
as
begin
begin try
		Select a.zone as SKU, a.LabelName as Name, a.YearOfWine as Vintage,
	 '' as Region,
	 '' as Country,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 isnull(det.AverageRating,0) as AverageRating,
	 isNull(lk.liked,0) as Liked,
	 '' as SmallImageURL,
	 a.WineId,
	 a.BarCode,
	 dt.DispenserCode,
	 dt.PositionTap,
	 dt.AvailableVolume as AvailableVolume,
	 bt.InsertionTime as InsertionTime
	 from [Enosoft].[dbo].[Wines] a with (nolock)  
	 inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on a.WineId  = dt.WineId
	 inner join [Enosoft].[dbo].[BottleTransactions] bt with (nolock) on dt.BottleTransactionID = bt.BottleTransactionID
	 left join WineDetails det  with (nolock)  on a.BarCode = det.BarCode
	 left join Likes lk  with (nolock) on (lk.BarCode = a.BarCode and lk.UserId=@userid)
	 where 
	 a.Enabled = 1
	 and dt.PlantFinal = @PlantFinal
	 and ((dt.DispenserCode not in (17, 19) and dt.PlantFinal = 2) 
	 or (dt.DispenserCode not in (15) and dt.PlantFinal = 1)) order by bt.InsertionTime;
	end try
	begin catch
		select ERROR_MESSAGE() as error
	end catch
end
GO
