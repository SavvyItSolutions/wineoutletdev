USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[UpdateDeviceToken1]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateDeviceToken1]
(
	@CustomerId int,
	@deviceToken varchar(max),
	@deviceType int
)
as
begin
	Update DeviceTokens set DeviceToken = @deviceToken,DeviceType = @deviceType where CustomerId = @CustomerId;
end
GO
