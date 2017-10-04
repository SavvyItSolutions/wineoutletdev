USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveProfileDetails]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RetrieveProfileDetails]
(
	@CustomerID int
)
as
begin
	select * from ICSCustomers with (nolock) 
	where CustomerId=@CustomerID;
end
GO
