USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveAvailableWines]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveAvailableWines] 1,1
CREATE PROCEDURE [dbo].[RetrieveAvailableWines]
         @PlantFinal int
		 ,@userid int
as
begin
begin try
declare @CheckServer int;
set @CheckServer = 0;
	if @PlantFinal =1
	begin
	set @CheckServer  = (select top 1 PlantFinal from [Wall].[Enosoft].[dbo].[dispensertaps] with (nolock) where PlantFinal = @plantfinal);
     Select a.zone as SKU, a.LabelName as Name, a.YearOfWine as Vintage,
	 '' as Region,
	 '' as Country,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 --det.SalePrice,
	 --det.RegPrice,
	 --isNull(det.AverageRating,5) as AverageRating,
	 isnull(det.AverageRating,0) as AverageRating,
	 --5 as AverageRating,
	 isNull(lk.liked,0) as Liked,
	 '' as SmallImageURL,
	 a.WineId,
	 dt.DispenserCode,
	 dt.PositionTap
	 from [Wall].[Enosoft].[dbo].[Wines] a with (nolock)  
	 inner join [Wall].[Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on a.WineId  = dt.WineId
		left join WineDetails det  with (nolock)  on a.WineId = det.WineID
		left join Likes lk  with (nolock) on (lk.WineId = a.WineId and lk.UserId=@userid)
		where 
		--a.wineid in 
			--(Select WineId from [Enosoft].[dbo].[DispenserTaps]  with (nolock)  where PlantFinal = @PlantFinal)
			 a.Enabled = 1
			 and PlantFinal = @PlantFinal
			and ((DispenserCode not in (17, 19) and PlantFinal = 2) 
			 or (DispenserCode not in (15) and PlantFinal = 1));
			--and a.zone is not null;
	--set @CheckServer =0;
	end
	else
	begin
	set @CheckServer = (select top 1 PlantFinal from [pointpleasent].[Enosoft].[dbo].[dispensertaps] with (nolock) where PlantFinal = @plantfinal);
	--select @CheckServer;
		Select a.zone as SKU, a.LabelName as Name, a.YearOfWine as Vintage,
	 '' as Region,
	 '' as Country,
	 a.BottleSalesPrice as SalePrice, 
	 a.PurchasePrice as RegPrice,
	 --det.SalePrice,
	 --det.RegPrice,
	 --isNull(det.AverageRating,5) as AverageRating,
	 isnull(det.AverageRating,0) as AverageRating,
	 --5 as AverageRating,
	 isNull(lk.liked,0) as Liked,
	 '' as SmallImageURL,
	 a.WineId,
	 dt.DispenserCode,
	 dt.PositionTap
	 from [pointpleasent].[Enosoft].[dbo].[Wines] a with (nolock)  
	 inner join [pointpleasent].[Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on a.WineId  = dt.WineId
		left join WineDetails det  with (nolock)  on a.WineId = det.WineID
		left join Likes lk  with (nolock) on (lk.WineId = a.WineId and lk.UserId=@userid)
		where 
		--a.wineid in 
			--(Select WineId from [Enosoft].[dbo].[DispenserTaps]  with (nolock)  where PlantFinal = @PlantFinal)
			 a.Enabled = 1
			 and PlantFinal = @PlantFinal
			and ((DispenserCode not in (17, 19) and PlantFinal = 2) 
			 or (DispenserCode not in (15) and PlantFinal = 1));
	end
	--select @CheckServer;
	end try
	begin catch
		exec RetrieveAvailableWinesFromServer @PlantFinal,@userid
	end catch
end


--exec RetrieveAvailableWines 1,2
GO
