USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser1]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AuthenticateUser1]
(
	@Email nvarchar(max)
)
AS
BEGIN
--if @Name like '% %'
--	select 'There is space'
--else
--	select 'No space'

SELECT top 1 c.*,t.PrefferredStore FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where LOWER(c.Email) = LOWER(@Email);
END

GO
