USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveMyTastingsServer]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[RetrieveMyTastingsServer]
	@custId int
	,@Store int
as
begin
	declare @Barcode varchar(50);
	set @Barcode = (select CardNumber from ICSCustomers  with (nolock)  where CustomerID = @custId); 
	if @Store = 0
	begin
		Select w.LabelName as Name,
		convert(int,w.YearOfWine) as Vintage
		,isnull(w.Zone,0) as SKU
		,am.PlantFinal as PlantFinal
		,w.BottleSalesPrice as SalePrice 
		,w.PurchasePrice as RegPrice
		,isNull(w.TastingNotes, '') as Description
		,convert(date,am.MovementDate) as TastingDate,
		w.BarCode
		from [Enosoft].[dbo].[Wines] w with (nolock)  inner join [Enosoft].[dbo].[AmountsMovements] am with (nolock)  on w.WineID = am.WineID inner join [Enosoft].[dbo].[Cards] c with (nolock) 
		on am.CardId = c.CardId inner join [Enosoft].[dbo].[Customers] cust with (nolock) on c.CustomerId = cust.CustomerId 
		where w.Enabled=1 and c.Enabled=1 and c.CustomerID is not null and cust.Enabled=1
		and cust.Barcode = @Barcode and w.Zone is not null
		group by w.barcode,w.LabelName,w.YearOfWine,w.Zone,am.PlantFinal,w.BottleSalesPrice,w.PurchasePrice,w.TastingNotes,convert(date,am.MovementDate)
	end
	else
	begin
		Select w.LabelName as Name,
		convert(int,w.YearOfWine) as Vintage
		,isnull(w.Zone,0) as SKU
		,am.PlantFinal as PlantFinal
		,w.BottleSalesPrice as SalePrice 
		,w.PurchasePrice as RegPrice
		,isNull(w.TastingNotes, '') as Description
		,convert(date,am.MovementDate) as TastingDate,
		w.BarCode
		from [Wall].[Enosoft].[dbo].[Wines] w with (nolock)  inner join [Wall].[Enosoft].[dbo].[AmountsMovements] am with (nolock)  on w.WineID = am.WineID inner join [Wall].[Enosoft].[dbo].[Cards] c with (nolock) on am.CardId = c.CardId inner join [Wall].[Enosoft].[dbo].[Customers] cust with (nolock) on c.CustomerId = cust.CustomerId 
		where w.Enabled=1 and c.Enabled=1 and c.CustomerID is not null and cust.Enabled=1
		and cust.Barcode = @Barcode and w.Zone is not null
		group by w.BarCode,w.LabelName,w.YearOfWine,w.Zone,am.PlantFinal,w.BottleSalesPrice,w.PurchasePrice,w.TastingNotes,convert(date,am.MovementDate)
		union all
		Select w.LabelName as Name,
		convert(int,w.YearOfWine) as Vintage
		,isnull(w.Zone,0) as SKU
		,am.PlantFinal as PlantFinal
		,w.BottleSalesPrice as SalePrice 
		,w.PurchasePrice as RegPrice
		,isNull(w.TastingNotes, '') as Description
		,convert(date,am.MovementDate) as TastingDate,
		w.BarCode
		from [Enosoft].[dbo].[Wines] w with (nolock)  inner join [Enosoft].[dbo].[AmountsMovements] am with (nolock)  on w.WineID = am.WineID inner join [Enosoft].[dbo].[Cards] c with (nolock) 
		on am.CardId = c.CardId inner join [Enosoft].[dbo].[Customers] cust with (nolock) on c.CustomerId = cust.CustomerId 
		where w.Enabled=1 and c.Enabled=1 and c.CustomerID is not null and cust.Enabled=1
		and cust.Barcode = @Barcode and w.Zone is not null and am.Plantfinal = 2
		group by w.barcode,w.LabelName,w.YearOfWine,w.Zone,am.PlantFinal,w.BottleSalesPrice,w.PurchasePrice,w.TastingNotes,convert(date,am.MovementDate)
	end	
end
GO
