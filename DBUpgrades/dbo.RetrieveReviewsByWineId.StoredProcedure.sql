USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByWineId]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveReviewsByWineId] 16208
CREATE  PROCEDURE [dbo].[RetrieveReviewsByWineId]
         @WineID int
as
BEGIN
begin try
declare @checkServer int;
set @checkServer = 0;
    if exists (select 1 from [Wall].[enosoft].dbo.wines where WineId = @WineID)
	begin
		SELECT	re.RatingStars, 	 
				re.RatingText,
				isnull(re.PlantFinal,1) as PlantFinal, 
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
			join [Wall].[Enosoft].[dbo].[Wines] w with (nolock)  
			--join [Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.WineId = w.WineID inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.WineId = @WineID and re.IsActive=1 order by ReviewDate desc;
		set @checkServer = (select 1 from [Wall].[enosoft].dbo.wines where WineId = @WineID);
	end
	else
	begin
		SELECT	re.RatingStars, 	 
				re.RatingText, 
				isnull(re.PlantFinal,2) as PlantFinal,
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
			join [pointpleasent].[Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.WineId = w.WineID inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.WineId = @WineID and re.IsActive=1 order by ReviewDate desc;
		set @checkServer = isnull((select 1 from [PointPleasent].[enosoft].dbo.wines where WineId = @WineID),0)
	end
end try
begin catch
	exec RetrieveReviewsByWineIdServer @WineID
end catch		
END

GO
