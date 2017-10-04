USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertPrefferredStore]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertPrefferredStore]
(
	@Store int,
	@CustId int
)
as
begin
	update DeviceTokens set PrefferredStore = @Store where CustomerId=@CustId ;
end

GO
