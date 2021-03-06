USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAvailableWines1]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec [RetrieveAvailableWines1] 0002
CREATE PROCEDURE [dbo].[RetrieveAvailableWines1]
         @PlantFinal int
as
begin
     Select a.zone as SKU, a.LabelName as Name, a.YearOfWine as Vintage,
	 det.Region,
	 det.Country,
	 det.SalePrice,
	 det.RegPrice,
	 det.AverageRating,
	 det.Liked,
	 det.URI as SmallImageURL
	 from [Enosoft].[dbo].[Wines] a 
		join SKUDetails det
		on a.zone = det.SKU
		where a.wineid in 
			(Select WineId from [Enosoft].[dbo].[DispenserTaps] where PlantFinal = @PlantFinal)
			and a.Enabled = 1

end





GO
