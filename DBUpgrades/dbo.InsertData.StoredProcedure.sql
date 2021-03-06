USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertData]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertData]
	(
		@SKU int,
		@nameURL varchar(150),
		@Vintage int,
		@saleURL decimal(5,2),
		@priceURL decimal(5,2),
		@Information varchar(max)
	)
	AS
	BEGIN
    IF EXISTS (select SKU from skudetails where sku=@SKU)
        BEGIN
            UPDATE skudetails SET Description = @Information ,saleprice=@saleURL , RegPrice=@priceURL WHERE sku = @sku
        END
    ELSE
        BEGIN
            INSERT INTO skudetails (SKU,NAME,Vintage,SalePrice,RegPrice,Description,Country,Region,[Sub-Region],GrapeVerietal,Type,BottleSize,Liked) VALUES (@SKU,@nameURL,@Vintage,@saleURL,@priceURL,@Information,'','','','','','','')
        END
	END	
GO
