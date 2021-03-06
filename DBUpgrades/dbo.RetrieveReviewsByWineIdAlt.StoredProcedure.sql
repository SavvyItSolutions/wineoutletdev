USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByWineIdAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveReviewsByWineId] 16208
CREATE  PROCEDURE [dbo].[RetrieveReviewsByWineIdAlt]
         @BarCode varchar(50)
as
BEGIN
begin try
declare @checkServer int;
set @checkServer = 0;
    if exists (select 1 from [Wall].[enosoft].dbo.wines where BarCode = @BarCode)
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
				re.BarCode as BarCode
		FROM dbo.Reviews re with (nolock) 
			join [Wall].[Enosoft].[dbo].[Wines] w with (nolock)  
			--join [Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.BarCode = w.BarCode inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.BarCode = @BarCode and re.IsActive=1;
		set @checkServer = (select 1 from [Wall].[enosoft].dbo.wines where BarCode = @BarCode);
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
				re.BarCode as BarCode
		FROM dbo.Reviews re with (nolock) 
			join [pointpleasent].[Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.BarCode = w.BarCode inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.BarCode = @BarCode and re.IsActive=1;
		set @checkServer = isnull((select 1 from [PointPleasent].[enosoft].dbo.wines where BarCode = @BarCode),0)
	end
end try
begin catch
	exec RetrieveReviewsByWineIdServerAlt @BarCode
end catch		
END

GO
