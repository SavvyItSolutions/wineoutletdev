USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertActivationCode]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertActivationCode]
(
	@ActivationCode nvarchar(max),
	@Email nvarchar(200)
)
as
begin
	declare @CustomerId int;
	declare @ACode nvarchar(max);
	set @CustomerId = (select top 1 customerid from DeviceTokens where email = @Email);
	if @CustomerId is null
	begin
		set @CustomerId = (select top 1 customerid from ICSCustomers where email = @Email);
		if @CustomerId is not null
		begin
			update DeviceTokens set email = @Email where CustomerId = @CustomerId;
		end
	end
	set @ACode=(select ActivationCode from DeviceTokens where CustomerId = @CustomerId);
	--select @ACode ;
	if(@ACode is null or @ACode = '')
	begin
		update DeviceTokens set ActivationCode = @ActivationCode where CustomerId=@CustomerId and verified = 0;
		select @ActivationCode as ActivationCode;
	end
	else
	begin
		select ActivationCode from DeviceTokens where CustomerId = @CustomerId and Verified = 0;
	end
end
GO
