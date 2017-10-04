USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[UpdateVerificationEmail]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateVerificationEmail]
(
	@ActivationCode nvarchar(max)
)
as
begin
	update DeviceTokens set Verified = 1 where ActivationCode=@ActivationCode;
end
GO
