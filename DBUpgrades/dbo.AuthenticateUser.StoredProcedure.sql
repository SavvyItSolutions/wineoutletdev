USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AuthenticateUser]
(
	@Name nvarchar(max)
)
AS
BEGIN
--if @Name like '% %'
--	select 'There is space'
--else
--	select 'No space'

SELECT top 1 c.*,t.PrefferredStore FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerId = t.CustomerId WHERE LOWER(FirstName) = LOWER(@Name)
END


GO
