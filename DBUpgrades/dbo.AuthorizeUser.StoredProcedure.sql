USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[AuthorizeUser]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AuthorizeUser]
(
	@CardNumber varchar(50),
	@DeviceId varchar(max)
)
as
begin
	if exists (select CustomerId from ICSCustomers with (nolock) where CardNumber = @CardNumber)
	begin
		select 1;
	end
	else
	begin
		select 0;
	end
end
GO
