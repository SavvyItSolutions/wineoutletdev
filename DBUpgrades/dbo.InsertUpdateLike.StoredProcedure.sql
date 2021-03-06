USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateLike]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUpdateLike](
	@UserID	int,
	@SKU	int,
	@Liked	bit,
	@BarCode varchar(50)
)
AS
BEGIN
IF exists(SELECT 1 FROM Likes WHERE UserID=@UserID AND BarCode=@BarCode)
	UPDATE Likes SET	
	UserID =@UserID,
	SKU = @SKU,
	Liked =@Liked
	WHERE
	UserID=@UserID AND BarCode=@BarCode
ELSE
	INSERT INTO Likes(UserID,SKU,Liked,WineId,BarCode)
	VALUES (@UserID,@SKU,@Liked,'',@BarCode)

	IF not exists(SELECT 1 FROM WineDetails WHERE BarCode=@BarCode)
	Insert into WineDetails select '',0,0,'',0,@BarCode;
END


GO
