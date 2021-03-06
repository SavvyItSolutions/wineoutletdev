USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[CheckMaxWineId]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CheckMaxWineId]
as
begin
	declare @ICSMaxId int;
	declare @EnoMaxWineId int;
	declare @PPMaxId int;
	declare @PointPMaxWineId int;

	create table #EnoUpdatedWines(WineId int,WineName nvarchar(35),Vintage smallint,store tinyint)
	create table #PPUpdatedWines(WineId int,WineName nvarchar(35),Vintage smallint,store tinyint)

	set @ICSMaxId = (select MaxWineId from UpdateWine with (nolock) where storeid = 1)
	set @EnoMaxWineId = (select Max(WineId) from [Wall].[Enosoft].[dbo].[Wines] with (nolock))
	set @PPMaxId = (select MaxWineId from UpdateWine with (nolock) where storeid =2)
	set @PointPMaxWineId = (select Max(WineId) from [pointpleasent].[enosoft].[dbo].[wines] with (nolock))

	if @EnoMaxWineId > @ICSMaxId
	begin
		select WineId into #temp from [Wall].[Enosoft].[dbo].[Wines] with (nolock) where WineId > @ICSMaxId;-- and WineId < 500;
		insert into #EnoUpdatedWines select w.WineID as WineId, w.LabelName as WineName,w.YearOfWine as Vintage,1 as store from [Wall].[Enosoft].[dbo].[Wines] w with (nolock) inner join #temp t on w.WineId = t.WineId order by WineId;
	end
	if @PointPMaxWineId > @PPMaxId
	begin
		select WineId into #temp1 from [pointpleasent].[Enosoft].[dbo].[Wines] with (nolock) where WineId > @PPMaxId;
		insert into #PPUpdatedWines  select w.WineID as WineId, w.LabelName as WineName,w.YearOfWine as Vintage,2 as store from [pointpleasent].[Enosoft].[dbo].[Wines] w with (nolock) inner join #temp1 t on w.WineId = t.WineId order by WineId;
	end

	select * from #EnoUpdatedWines; 
	--if @EnoMaxWineId > @ICSMaxId
	--begin
	--	select WineId,WineName,Vintage from #PPUpdatedWines where concat(WineName,' ',Vintage) not in (select concat(WineName,' ',Vintage) from #EnoUpdatedWines) 
	--end
	--else
	--begin
	--	select * from #PPUpdatedWines;
	--end
	select * from #PPUpdatedWines;
	select @EnoMaxWineId as MaxId;
	select @PointPMaxWineId as MaxId;
	drop table #EnoUpdatedWines;
	drop table #PPUpdatedWines;
end

GO
