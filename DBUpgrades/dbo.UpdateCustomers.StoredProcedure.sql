USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomers]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateCustomers]
(
	@FirstName varchar(max),
	@LastName varchar(max),
	@PhoneNumber nvarchar(max),
	@Phone2 nvarchar(100),
	@Email nvarchar(100),
	@Address1 nvarchar(100),
	@Address2 nvarchar(100),
	@City nvarchar(50),
	@State nvarchar(50),
	@CustomerType nvarchar(100),
	@CustomerID int
)
as
begin
	Update ICSCustomers set
	 FirstName = @FirstName
	,LastName = @LastName
	,PhoneNumber = @PhoneNumber
	, Phone2 = @Phone2
	, Email = @Email
	, Address1 =  @Address1
	, Address2 = @Address2
	, City = @City
	, State = @State
	, CustomerType = @CustomerType
	, IsUpdated = 1
	,LastUpdatedOn = getdate()
	where CustomerID = @CustomerID

	update DeviceTokens set Email = @Email where CustomerID = @CustomerID;
end




GO
