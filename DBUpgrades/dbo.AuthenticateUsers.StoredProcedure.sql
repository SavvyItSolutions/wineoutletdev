USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUsers]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AuthenticateUsers]
(
	@CardNumber varchar(50),
	@EmailId nvarchar(100),
	@DeviceId varchar(max)
	
)
AS
BEGIN
declare @CustId int;
declare @verified nvarchar(100);
	if exists (select CustomerId from ICSCustomers with (nolock) where CardNumber = @CardNumber)
	Begin	
		set @CustId = (Select top 1 CustomerId from ICSCustomers with (nolock) where CardNumber = @CardNumber)
		if exists(select CustomerId from DeviceTokens with (nolock) where DeviceId = @DeviceId and CustomerId = @CustId)
		Begin	
			set @verified = (select email from ICSCustomers with (nolock) where CustomerId = @CustId);			
			if(@verified = @EmailId)
			begin
				--update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
				--update DeviceTokens set email = @EmailId where CustomerId = @CustId;
				SELECT top 1 c.*,t.PrefferredStore,0 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
			end
			else
			begin
				--if @verified = ''
				--begin
					--update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
					--update DeviceTokens set email = @EmailId where CustomerId = @CustId;
					SELECT top 1 c.*,t.PrefferredStore,1 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
				--end
				--else
				--begin
				--	SELECT top 1 c.*,t.PrefferredStore,0 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CardNumber = CardNumber							and c.email = @EmailId;
				--end				
			end
		End
		else
		Begin
			--update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
			--update DeviceTokens set DeviceId = @DeviceId,Verified = 0,email = @EmailId where CustomerId = @CustId;
			SELECT top 1 c.*,t.PrefferredStore,1 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
		End
	End
	else
	Begin
		--Select 0 as CustomerId,'' as FirstName,'' as LastName,'' as  PhoneNumber,'' as Phone2,'' as Email,'' as Address1,'' as Address2,'' as City,'' as State,'' as CustomerType,'' as CustomerAdded,'' as CardNumber, '' as Notes1,'' as IsUpdated,'' as LastUpdated,'' as PrefferredStore,0 as IsMailSent;
		if exists(select CustomerId from ICSCustomers with (nolock) where Lower(email) = Lower(@EmailId))
		begin
			SELECT top 1 c.*,t.PrefferredStore,-1 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CardNumber = CardNumber;
		end
		else
		begin
			SELECT top 1 c.*,t.PrefferredStore,0 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CardNumber = CardNumber;
		end
	End
END
GO
