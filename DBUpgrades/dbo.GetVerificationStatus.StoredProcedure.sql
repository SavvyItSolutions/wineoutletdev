USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[GetVerificationStatus]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetVerificationStatus]
(
	@CustId int--nvarchar(200)
)
as
begin
	select Verified from DeviceTokens where CustomerId = @CustId;
end
GO
