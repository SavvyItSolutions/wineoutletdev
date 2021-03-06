USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveRatingsByUserId]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [RetrieveRatingsByUserId] 222
CREATE  PROCEDURE [dbo].[RetrieveRatingsByUserId]
         @UserID int
as
BEGIN
    
	SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID as UserName, 
			re.SKU,
			re.Name,
			det.Vintage,
			det.Region,
			det.Country
	FROM dbo.Reviews re
		join dbo.SKUDetails det
	ON re.SKU = det.SKU
		WHERE re.ReviewUserID = @UserID

END





GO
