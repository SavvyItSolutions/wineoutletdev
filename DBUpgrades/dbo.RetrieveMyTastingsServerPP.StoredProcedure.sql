USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveMyTastingsServerPP]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveMyTastingsServerPP]
	@custId int
as
begin
	declare @Barcode varchar(50);
	set @Barcode = (select CardNumber from ICSCustomers  with (nolock)  where CustomerID = @custId); 
	begin try	
		(Select w.LabelName as Name,
		convert(int,w.YearOfWine) as Vintage
		,isnull(w.Zone,0) as SKU
		,am.PlantFinal as PlantFinal
		,w.BottleSalesPrice as SalePrice 
		,w.PurchasePrice as RegPrice
		,isNull(w.TastingNotes, '') as Description
		,am.MovementDate as TastingDate,
		w.BarCode
		from [Enosoft].[dbo].[Wines] w with (nolock)  inner join [Enosoft].[dbo].[AmountsMovements] am with (nolock)  on w.WineID = am.WineID inner join [Enosoft].[dbo].[Cards] c with (nolock)
		on am.CardId = c.CardId inner join [Enosoft].[dbo].[Customers] cust with (nolock) on c.CustomerId = cust.CustomerId 
		where w.Enabled=1 and c.Enabled=1 and c.CustomerID is not null and cust.Enabled=1
		and cust.Barcode = @Barcode and w.Zone is not null and am.PlantFinal = 1)
		union all
		(Select w.LabelName as Name,
		convert(int,w.YearOfWine) as Vintage
		,isnull(w.Zone,0) as SKU
		,am.PlantFinal as PlantFinal
		,w.BottleSalesPrice as SalePrice 
		,w.PurchasePrice as RegPrice
		,isNull(w.TastingNotes, '') as Description
		,am.MovementDate as TastingDate,
		w.BarCode
		from [pointpleasent].[Enosoft].[dbo].[Wines] w with (nolock)  inner join [pointpleasent].[Enosoft].[dbo].[AmountsMovements] am with (nolock)  on w.WineID = am.WineID inner join [pointpleasent].[Enosoft].[dbo].[Cards] c with (nolock)  
		on am.CardId = c.CardId inner join [pointpleasent].[Enosoft].[dbo].[Customers] cust with (nolock) on c.CustomerId = cust.CustomerId 
		where w.Enabled=1 and c.Enabled=1 and c.CustomerID is not null and cust.Enabled=1
		and cust.Barcode = @Barcode and w.Zone is not null);
end try
begin catch
	exec RetrieveMyTastingsServer @custId,0
end catch
end
GO
