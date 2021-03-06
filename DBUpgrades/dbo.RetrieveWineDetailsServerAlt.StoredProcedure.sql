USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveWineDetailsServerAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RetrieveWineDetailsServerAlt]
         @BarCode int,
		 @StoreId int
		 as
		 begin
			Select 
			convert(int, wines.Zone) as SKU
			,wines.LabelName as Name
			,convert(int, wines.YearOfWine) as Vintage
			,''  as Country--,isnull(det.Country,'') as Country
			,'' as Region --,isnull(det.Region,'') as Region
			,'' as [Sub-Region] --,isnull(det.[Sub-Region],'') as [Sub-Region]
			,'' as [GrapeVerietal] --,isnull(det.GrapeVerietal,'') as [GrapeVerietal]
			,'' as Type --,isnull(det.Type,'') as Type
			,wines.BottleSalesPrice as SalePrice 
			,wines.PurchasePrice as RegPrice
			,isNull(det.AverageRating, 5) as AverageRating
			,isNull(det.TotalRating,5) as UsersRating
			,isNull(det.ProductDescription, '') as Description
			,0 as BottleSize --,isnull(convert(int, det.BottleSize),0) as BottleSize
			,'' as LargeImageUrl --,isNull(det.LargeImageUrl, '') as LargeImageUrl
			,1 as Liked--,isNull(det.Liked, 1) as Liked
			,wines.WineId as WineId
			,wines.BarCode as BarCode,
			 isnull(dt.AvailableVolume,'') as AvailableVolume,
			 isnull(bt.InsertionTime,'') as InsertionTime
	--Optional: Alcohol Levels, Food Pairings, ServingAt, Tasting Notes, WineMakerNotes, Technical Notes, OtherText, Producer, List<Rating>
 		from [Enosoft].dbo.Wines wines with (nolock) 
		left outer join [Enosoft].dbo.DispenserTaps dt with (nolock)

		on wines.WineId = dt.WineId
	 left outer join [Enosoft].[dbo].[BottleTransactions] bt with (nolock) on dt.BottleTransactionID = bt.BottleTransactionID
		left outer join dbo.WineDetails det with (nolock) 
		on wines.BarCode = det.BarCode
		where wines.BarCode = @BarCode and dt.PlantFinal = @StoreId;
		end
GO
