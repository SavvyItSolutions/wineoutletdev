USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[DeleteReview]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteReview](
@BarCode varchar(50),
@ReviewUserId int
)
AS
BEGIN
		declare @stars int;
		declare @TotalRating int
		declare @users int;		
		set @stars = (select RatingStars from reviews where BarCode = @BarCode and ReviewUserID=@ReviewUserId);
		set @TotalRating = (select TotalRating- @stars from WineDetails where BarCode = @BarCode) ;
		set @users = (select TotalUsersRated - 1 from WineDetails where BarCode = @BarCode);
		
		update WineDetails set 
		TotalRating =@TotalRating
		,TotalUsersRated = @users
		,AverageRating=(cast(@TotalRating as float)/cast(@users as float)) 
		where BarCode=@BarCode;
		
		UPDATE Reviews SET		
		IsActive	= 0
		WHERE BarCode=@BarCode AND ReviewUserID=@ReviewUserId
END

GO
