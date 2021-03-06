USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateCustomers]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertUpdateCustomers]
(
	@CustId int,
	@firstName varchar(max),
	@lastName varchar(max),
	@Phone1 nvarchar(max),
	@Phone2 nvarchar(max),
	@email nvarchar(100),
	@address1 nvarchar(100),
	@address2 nvarchar(100),
	@city nvarchar(50),
	@state nvarchar(50),
	@CustomerType nvarchar(100),
	@CustomerAdded datetime,
	@CardNumber varchar(50)
)
as
begin
	if exists(select CustomerId from IcsCustomers where CustomerID = @CustId)
	begin
		update ICSCustomers set FirstName=@firstName, LastName=@lastName, PhoneNumber=@Phone1, Phone2=@Phone2, Email=@email, Address1=@address1, Address2=@address2, City=@city, State=@state, CustomerType=@CustomerType, CustomerAdded=@CustomerAdded, CardNumber=@CardNumber, Notes1='',IsUpdated=0,LastUpdatedOn=getdate() where CustomerId = @CustId;
		if exists(select CustomerId from DeviceTokens where customerid =@CustId)
		begin
			update DeviceTokens set DeviceToken='',DeviceType=null, email=@email,ActivationCode=null,Verified=0,PrefferredStore=null,DeviceId=null where CustomerId = @CustId;
		end
		else
		begin
			insert into Devicetokens select @CustId,'',null,@email,null,0,null,null;
		end
		select 2;
	end
	else
	begin
		insert into ICSCustomers select @CustId,@firstName,@lastName,@Phone1,@Phone2,@email,@address1,@address2,@city,@state,@CustomerType,@CustomerAdded,@CardNumber,'',0,getdate();
		if exists(select CustomerId from DeviceTokens where customerid =@CustId)
		begin
			update DeviceTokens set DeviceToken='',DeviceType=null, email=@email,ActivationCode=null,Verified=0,PrefferredStore=null,DeviceId=null where CustomerId = @CustId;
		end
		else
		begin
			insert into Devicetokens select @CustId,'',null,@email,null,0,null,null;
		end
		select 1;
	end
end

























														




												
GO
