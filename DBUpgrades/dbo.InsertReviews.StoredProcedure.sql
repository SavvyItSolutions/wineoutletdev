USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertReviews]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertReviews](
@PlantFinal varchar(4),
@ReviewDate datetime,
@CardID int,
@Cost decimal(18,4),
@RatingStars int,
@SKU int,
@CommentsTitle nvarchar(max),
@RatingText nvarchar(max),
@ReviewUserId int,
@Name varchar(50),
@WineId int
)
AS
BEGIN
INSERT INTO [dbo].[Reviews]
           ([PlantFinal]
           ,[ReviewDate]
           ,[CardID]
           ,[Cost]
           ,[RatingStars]
           ,[SKU]
           ,[CommentsTitle]
           ,[RatingText]
           ,[ReviewUserId]
           ,[Name]
		   ,[WineId])
     VALUES
           (@PlantFinal, 
           @ReviewDate,
           @CardID, 
           @Cost, 
           @RatingStars,
           @SKU,
           @CommentsTitle,
           @RatingText,
           @ReviewUserId,
           @Name,
		   @WineId)
 END
GO
