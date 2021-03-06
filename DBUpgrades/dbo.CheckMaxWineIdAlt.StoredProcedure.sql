USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[CheckMaxWineIdAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CheckMaxWineIdAlt]
as
begin
	declare @ICSMaxId int;
	declare @EnoMaxWineId int;
	declare @PPMaxId int;
	declare @PointPMaxWineId int;
	create table #EnoUpdatedWines(Barcode varchar(50),WineName nvarchar(35),Vintage smallint,store tinyint)
	create table #PPUpdatedWines(Barcode varchar(50),WineName nvarchar(35),Vintage smallint,store tinyint)
	set @ICSMaxId = (select MaxWineId from UpdateWine with (nolock) where storeid = 1)
	--set @ICSMaxId = 0
	set @EnoMaxWineId = (select Max(WineId) from [Wall].[Enosoft].[dbo].[Wines] with (nolock))
	set @PPMaxId = (select MaxWineId from UpdateWine with (nolock) where storeid =2)
	--set @PPMaxId =0
	set @PointPMaxWineId = (select Max(WineId) from [pointpleasent].[enosoft].[dbo].[wines] with (nolock))

	if @EnoMaxWineId > @ICSMaxId
	begin
		select Barcode into #temp from [Wall].[Enosoft].[dbo].[Wines] with (nolock) where WineId > @ICSMaxId and Barcode not in (select Barcode from pointpleasent.enosoft.dbo.wines);-- and WineId < 500;
		insert into #EnoUpdatedWines select w.BarCode as Barcode, w.LabelName as WineName,w.YearOfWine as Vintage,1 as store from [Wall].[Enosoft].[dbo].[Wines] w with (nolock) inner join #temp t on w.Barcode = t.Barcode --order by WineId;
	end
	
	if @PointPMaxWineId > @PPMaxId
	begin
		select Barcode into #temp1 from [pointpleasent].[Enosoft].[dbo].[Wines] with (nolock) where WineId > @PPMaxId;
		insert into #PPUpdatedWines  select w.BarCode as Barcode, w.LabelName as WineName,w.YearOfWine as Vintage,2 as store from [pointpleasent].[Enosoft].[dbo].[Wines] w with (nolock) inner join #temp1 t on w.Barcode = t.Barcode --order by t.WineID;
	end
	--select 1;
	select * from #EnoUpdatedWines; 
	select * from #PPUpdatedWines;
	select @EnoMaxWineId as MaxId;
	select @PointPMaxWineId as MaxId;
	drop table #EnoUpdatedWines;
	drop table #PPUpdatedWines;
end

GO
