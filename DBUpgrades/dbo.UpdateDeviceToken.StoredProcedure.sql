USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[UpdateDeviceToken]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateDeviceToken]
(
	@CustomerId int,
	@deviceToken varchar(max)
)
as
begin
	Update DeviceTokens set DeviceToken = @deviceToken where CustomerId = @CustomerId;
end
GO
