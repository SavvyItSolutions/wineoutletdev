USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[checkAmountsmovement]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[checkAmountsmovement]
as
begin
--FOR ENOSOFT SERVER
	select w.BarCode as WineBarCode,am.PlantFinal,w.LabelName,isnull((select barcode from enosoft.dbo.customers with (nolock) where customerid =(select top 1 Customerid from enosoft.dbo.cards with (nolock) where cardid = c.cardid)),0) as Barcode into #store1 from enosoft.dbo.wines w with (nolock) inner join enosoft.dbo.amountsmovements am with (nolock) on w.WineId = am.WineId inner join enosoft.dbo.cards c with (nolock) on am.cardid = c.cardid   where am.wineid is not null and am.movementdate > (select LastModifiedTime from AmountMovementTracking with (nolock) where StoreID=1);

	select distinct s.WineBarCode,s.PlantFinal,s.LabelName,cust.CustomerId,d.DeviceToken,d.DeviceType from #store1 s inner join ICSCustomers cust with (nolock) on s.Barcode = cust.CardNumber inner join DeviceTokens d with (nolock)on cust.CustomerId = d.CustomerId;-- where s.Barcode <> 0;

	----FOR POINT PLEASENT
	select w.BarCode as WineBarCode,am.PlantFinal,w.LabelName,isnull((select barcode from POINTPLEASENT.enosoft.dbo.customers with (nolock) where customerid =(select top 1 Customerid from POINTPLEASENT.enosoft.dbo.cards  with (nolock) where cardid = c.cardid)),0) as Barcode into #store2 from POINTPLEASENT.enosoft.dbo.Wines w with (nolock) inner join POINTPLEASENT.enosoft.dbo.amountsmovements am with (nolock) on w.WineId = am.WineId inner join POINTPLEASENT.enosoft.dbo.cards c with (nolock) on am.cardid = c.cardid   where am.wineid is not null and am.movementdate > (select LastModifiedTime from AmountMovementTracking with (nolock) where StoreID=2);

	select distinct s.WineBarCode,s.PlantFinal,s.LabelName,cust.CustomerId,d.DeviceToken,d.DeviceType from #store2 s inner join ICSCustomers cust with (nolock) on s.Barcode = cust.CardNumber inner join DeviceTokens d with (nolock) on cust.CustomerId = d.CustomerId;-- where s.Barcode <> 0;

	----DROP TABLES
	drop Table #store1;
	drop Table #store2;
	--select distinct s.WineId,s.LabelName,cust.CustomerId,d.DeviceToken,d.DeviceType from amountsmovements s inner join ICSCustomers cust with (nolock) on s.Barcode = cust.CardNumber inner join DeviceTokens d with (nolock) on cust.CustomerId = d.CustomerId;

	----Update timestamp
	declare @CurrentDateTime datetime;
	set @CurrentDateTime = (select getdate()); 
	update AmountMovementTracking set LastModifiedTime=@CurrentDateTime;

end
GO
