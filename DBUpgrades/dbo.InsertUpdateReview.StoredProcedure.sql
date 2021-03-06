USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateReview]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUpdateReview](
@ReviewID	int,
@PlantFinal	varchar(10),
@ReviewDate	datetime,
@CardID	int,
@Cost	decimal(18,4),
@RatingStars	int,
@SKU	int,
@CommentsTitle	nvarchar(500),
@RatingText	nvarchar(500),
@ReviewUserId	int,
@Name	varchar,
@IsActive	bit,
@BarCode varchar(50)
)
AS
BEGIN
declare @totlRating int;
IF exists(SELECT 1 FROM Reviews WHERE BarCode=@BarCode AND ReviewUserID=@ReviewUserId)
	begin
	
	declare @oldRating int;
	set @oldRating = isnull((select RatingStars from Reviews WHERE BarCode=@BarCode AND ReviewUserID=@ReviewUserId),0);

	UPDATE Reviews SET	
		PlantFinal	= @PlantFinal,
		ReviewDate	= @ReviewDate,
		CardID		= @CardID,
		Cost		= @Cost,
		RatingStars	= @RatingStars,
		SKU			= @SKU,
		CommentsTitle= @CommentsTitle,	
		RatingText	= @RatingText,
		ReviewUserId= @ReviewUserId	,
		Name		= @Name,
		IsActive	= @IsActive,
		BarCode     = @BarCode
		WHERE BarCode = @BarCode AND ReviewUserID=@ReviewUserId
		IF exists(SELECT 1 FROM WineDetails WHERE BarCode=@BarCode )
		begin
			set @totlRating = ISNULL((select TotalRating from WineDetails where BarCode=@BarCode),0); 
			set @totlRating = @totlRating - @oldRating;
			set @totlRating = @totlRating + @RatingStars;
			update WineDetails set TotalRating=@totlRating where BarCode=@BarCode;
			update WineDetails set AverageRating=(cast(TotalRating as float)/cast(TotalUsersRated as float)) where BarCode=@BarCode;
		end
		else
		begin
			set @totlRating = @RatingStars;
			insert into WineDetails select '',@totlRating,1,null,@totlRating,@BarCode;
		end
		
	end


ELSE
begin
	INSERT INTO Reviews(
		PlantFinal,
		ReviewDate,
		CardID,
		Cost,
		RatingStars,
		SKU,
		CommentsTitle ,	
		RatingText,
		ReviewUserId,
		Name,		
		IsActive,
		WineId,
		BarCode
	)
	VALUES (
	@PlantFinal,
	@ReviewDate,
	@CardID,
	@Cost,
	@RatingStars,
	@SKU,
	@CommentsTitle,
	@RatingText,
	@ReviewUserId,
	@Name,
	@IsActive,
	'',
	@BarCode
	)
	IF exists(SELECT 1 FROM WineDetails WHERE BarCode=@BarCode )
	begin
		set @totlRating = ISNULL((select TotalRating from WineDetails where BarCode=@BarCode),0);
		set @totlRating = @totlRating + @RatingStars;
		update WineDetails set TotalRating=@totlRating where BarCode=@BarCode;
		update WineDetails set TotalUsersRated= (TotalUsersRated+1) where BarCode=@BarCode;
		update WineDetails set AverageRating=(cast(TotalRating as float)/cast(TotalUsersRated as float)) where BarCode=@BarCode;
	end
	else
	begin
		set @totlRating = @RatingStars;
		insert into WineDetails select '',@totlRating,1,null,@totlRating,@BarCode;
	end
	end
END
GO
