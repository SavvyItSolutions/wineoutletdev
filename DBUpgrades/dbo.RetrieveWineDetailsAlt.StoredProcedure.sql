USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveWineDetailsAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveWineDetails] 5757
CREATE PROCEDURE [dbo].[RetrieveWineDetailsAlt]
         @BarCode varchar(50),
		 @StoreId int
as

begin
begin try
declare @avgRating float;
declare @totlRating int ; set @totlRating = isnull((select TotalRating from WineDetails with (nolock) where BarCode = @BarCode),0); 
declare @present int;
--set @present = 0;
if(@totlRating = 0)
	set @avgRating = 0;
else
begin
	declare @users int; set @users = (select TotalUsersRated from WineDetails with (nolock) where BarCode = @BarCode)
	--set @avgRating = @totlRating/@users;
end
	if(@StoreId  = 1)--exists(select 1 from [wall].[enosoft].dbo.wines with (nolock) where wineid = @WineID)
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
 		from [Wall].Enosoft.dbo.Wines wines with (nolock) 
		left outer join [Wall].[Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on wines.WineId  = dt.WineId
	 left outer join [Wall].[Enosoft].[dbo].[BottleTransactions] bt with (nolock) on dt.BottleTransactionID = bt.BottleTransactionID
		left outer join dbo.WineDetails det with (nolock) 
		on wines.BarCode = det.BarCode
		where  wines.BarCode = @BarCode;
		--set @present = isnull((select 1 from [wall].[enosoft].dbo.wines with (nolock) where wineid = @WineID),0);
	end
	else
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
 		from [Pointpleasent].[Enosoft].dbo.Wines wines with (nolock)
		left outer join [pointpleasent].[Enosoft].[dbo].[DispenserTaps] dt with (nolock)  on wines.WineId  = dt.WineId
	left outer join [pointpleasent].[Enosoft].[dbo].[BottleTransactions] bt with (nolock) on dt.BottleTransactionID = bt.BottleTransactionID 
		left outer join dbo.WineDetails det with (nolock) 
		on wines.BarCode = det.BarCode
		where wines.BarCode = @BarCode;
		--set @present = isnull((select 1 from [PointPleasent].[enosoft].dbo.wines with (nolock) where wineid = @WineID),0);
	end
	end try
	begin catch
		exec RetrieveWineDetailsServerAlt @BarCode,@StoreId
	end catch
end

GO
