USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveCustomerDetails]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RetrieveCustomerDetails]
(
@CardNumber varchar(50)
)
as
begin
select CONCAT(FirstName,LastName),Email from ICSCustomers with (nolock) 
	where CardNumber=@CardNumber;
end
GO
