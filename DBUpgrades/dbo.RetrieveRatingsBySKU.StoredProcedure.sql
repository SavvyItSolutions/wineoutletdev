USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveRatingsBySKU]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveRatingsBySKU] 16208
CREATE  PROCEDURE [dbo].[RetrieveRatingsBySKU]
         @SKU int
as
BEGIN
    
	SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			u.Name as UserName, 
			re.SKU,
			re.Name,
			det.Vintage,
			det.Region,
			det.Country
	FROM dbo.Reviews re
		join dbo.SKUDetails det 
	ON re.SKU = det.SKU inner join users u on re.ReviewUserId = u.UserId
	WHERE re.SKU = @SKU

END





GO
