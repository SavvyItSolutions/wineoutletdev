USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByUserIdServer]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RetrieveReviewsByUserIdServer]
	@UserID int
as
begin
	SELECT	re.RatingStars, 	 
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
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1
end
GO
