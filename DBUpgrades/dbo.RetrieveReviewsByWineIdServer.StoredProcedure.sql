USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByWineIdServer]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveReviewsByWineIdServer]
	 @WineID int
as
begin 
SELECT	re.RatingStars, 	 
				re.RatingText, 
				re.PlantFinal as PlantFinal,
				ReviewDate as Date, 
				u.FirstName as UserName,
				re.ReviewUserId as ReviewUserId,
				re.SKU,
				re.Name,
				w.YearOfWine as Vintage,
				'' as Region,
				'' as Country,
				re.ReviewID as ReviewId,
				re.WineId as WineId
		FROM dbo.Reviews re with (nolock) 
			join [Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.WineId = w.WineID inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.WineId = @WineID and re.IsActive=1 order by ReviewDate desc;
end
GO
