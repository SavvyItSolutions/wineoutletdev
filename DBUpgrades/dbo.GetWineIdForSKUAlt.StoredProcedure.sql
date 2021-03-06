USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[GetWineIdForSKUAlt]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetWineIdForSKUAlt] 
(
	@sku int
)
as
begin
	declare @BarCode varchar(50);
	set @BarCode = (select BarCode from [Enosoft].[dbo].[wines] with (nolock) where zone = @sku);
	select isnull(@BarCode,0);
end
GO
