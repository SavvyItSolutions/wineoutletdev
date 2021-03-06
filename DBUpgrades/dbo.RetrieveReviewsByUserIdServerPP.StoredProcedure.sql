USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByUserIdServerPP]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RetrieveReviewsByUserIdServerPP]
	@UserID int
as
begin
begin try
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
			re.WineId as WineID
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.WineId = det.WineId 
	inner join [Enosoft].[dbo].[wines] w
	--inner join [Enosoft].[dbo].[wines] w
	on w.WineID = det.WineID 
	inner join [Enosoft].[dbo].[DispenserTaps] dis
	on w.WineId = dis.WineId
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1 and dis.PlantFinal = 1)
		union all
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
			re.WineId as WineID
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.WineId = det.WineId inner join [pointpleasent].[Enosoft].[dbo].[wines] w
	on w.WineID = det.WineID 
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1)
		end try
		begin catch
			exec RetrieveReviewsByUserIdServer @UserID
		end catch
end
GO
