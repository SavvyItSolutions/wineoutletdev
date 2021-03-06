USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAvailableWinesFromServer]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveAvailableWines] 1,1
CREATE PROCEDURE [dbo].[RetrieveAvailableWinesFromServer]
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
	 dt.DispenserCode,
	 dt.PositionTap
	 from [Enosoft].[dbo].[Wines] a with (nolock)  
	 inner join [Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on a.WineId  = dt.WineId
		left join WineDetails det  with (nolock)  on a.WineId = det.WineID
		left join Likes lk  with (nolock) on (lk.WineId = a.WineId and lk.UserId=@userid)
		where 
			 a.Enabled = 1
			 and PlantFinal = @PlantFinal
			and ((DispenserCode not in (17, 19) and PlantFinal = 2) 
			 or (DispenserCode not in (15) and PlantFinal = 1));
	end try
	begin catch
		select ERROR_MESSAGE() as error
	end catch
end
GO
