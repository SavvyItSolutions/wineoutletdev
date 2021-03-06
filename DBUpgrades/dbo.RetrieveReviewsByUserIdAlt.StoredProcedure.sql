USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByUserIdAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 
CREATE  PROCEDURE [dbo].[RetrieveReviewsByUserIdAlt]
         @UserID int
as
BEGIN
begin try
declare @checkWall int;
declare @checkPP int;
set @checkWall = 0 ;
set @checkPP = 0 ;
set @checkWall = isnull((select top 1 wineid from [wall].[enosoft].dbo.wines with (nolock)),0);
--set @checkWall = 0;
set @checkPP = isnull((select top 1 wineid from [PointPleasent].[enosoft].dbo.wines with (nolock)),0);
 --   if @checkWall <> 0 
	--begin
	--if @checkPP <> 0
	--begin
	(SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID,
			isnull(re.Name,'') as UserName, 
			isnull(re.PlantFinal,1) as PlantFinal,
			re.SKU,
			w.LabelName as Name,
			w.YearOfWine as Vintage,
			'' as Region,
			''  as Country,
			re.BarCode as BarCode
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.BarCode = det.BarCode
	inner join [Wall].[Enosoft].[dbo].[wines] w
	--inner join [Enosoft].[dbo].[wines] w
	on w.BarCode = det.BarCode 
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1)
		union
		(SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID,
			isnull(re.Name,'') as UserName, 
			isnull(re.PlantFinal,2) as PlantFinal,
			re.SKU,
			w.LabelName as Name,
			w.YearOfWine as Vintage,
			'' as Region,
			''  as Country,
			re.BarCode as BarCode
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.BarCode = det.BarCode inner join [pointpleasent].[Enosoft].[dbo].[wines] w
	on w.BarCode = det.BarCode 
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1) order by ReviewDate desc
		--end
		--else
		--begin
	--		SELECT	re.RatingStars, 	 
	--		re.RatingText, 
	--		ReviewDate as Date, 
	--		re.ReviewUserID,
	--		isnull(re.Name,'') as UserName, 
	--		isnull(re.PlantFinal,0) as PlantFinal,
	--		re.SKU,
	--		w.LabelName as Name,
	--		w.YearOfWine as Vintage,
	--		'' as Region,
	--		''  as Country,
	--		re.WineId as WineID
	--FROM dbo.Reviews re with (nolock) 
	--	join dbo.WineDetails det with (nolock) 
	--ON re.WineId = det.WineId inner join [Enosoft].[dbo].[wines] w
	--on w.WineID = det.WineID 
	--	WHERE re.ReviewUserID = @UserID
	--	and re.IsActive=1
	--	end
	--end
	--else
	--begin
	--	SELECT	re.RatingStars, 	 
	--		re.RatingText, 
	--		ReviewDate as Date, 
	--		re.ReviewUserID,
	--		isnull(re.Name,'') as UserName, 
	--		isnull(re.PlantFinal,0) as PlantFinal,
	--		re.SKU,
	--		w.LabelName as Name,
	--		w.YearOfWine as Vintage,
	--		'' as Region,
	--		''  as Country,
	--		re.WineId as WineID
	--FROM dbo.Reviews re with (nolock) 
	--	join dbo.WineDetails det with (nolock) 
	--ON re.WineId = det.WineId inner join [Enosoft].[dbo].[wines] w
	--on w.WineID = det.WineID 
	--	WHERE re.ReviewUserID = @UserID
	--	and re.IsActive=1
	--end
	end try
	begin catch
		if @checkWall = 0
		begin
			exec RetrieveReviewsByUserIdServerPPAlt @UserID
			--do something
		end
		else
		begin
			exec RetrieveReviewsByUserIdServerAlt @UserID
			--do something else
		end
	end catch
END
GO
