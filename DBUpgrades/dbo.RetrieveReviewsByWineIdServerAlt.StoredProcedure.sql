USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByWineIdServerAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveReviewsByWineIdServerAlt]
	 @BarCode varchar(50)
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
				re.BarCode as BarCode
		FROM dbo.Reviews re with (nolock) 
			join [Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.BarCode = w.BarCode inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.BarCode = @BarCode and re.IsActive=1;
end
GO
