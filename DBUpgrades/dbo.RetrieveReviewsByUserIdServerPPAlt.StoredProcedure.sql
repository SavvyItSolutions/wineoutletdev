USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveReviewsByUserIdServerPPAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveReviewsByUserIdServerPPAlt]
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
			re.BarCode as BarCode
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.BarCode = det.BarCode 
	inner join [Enosoft].[dbo].[wines] w
	--inner join [Enosoft].[dbo].[wines] w
	on w.Barcode = det.BarCode 
	inner join [Enosoft].[dbo].[wines] wines on wines.BarCode = re.BarCode
	inner join [Enosoft].[dbo].[DispenserTaps] dis
	on wines.WineId = dis.WineId
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1 and dis.PlantFinal = 1)
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
		end try
		begin catch
			exec RetrieveReviewsByUserIdServerAlt @UserID
		end catch
end
GO
