USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[GetWineIdForSKU]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetWineIdForSKU] 
(
	@sku int
)
as
begin
	declare @wineId int;
	set @wineId = (select wineId from [Enosoft].[dbo].[wines] with (nolock) where zone = @sku);
	select isnull(@wineId,0);
end
GO
