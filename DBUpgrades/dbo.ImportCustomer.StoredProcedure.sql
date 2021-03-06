USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[ImportCustomer]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImportCustomer]
(
	@xmlDoc varchar(max)

)
AS

BEGIN
SET NOCOUNT ON;
DECLARE @ID INT;
DECLARE @hdoc INT;
DECLARE @pat_mrn varchar(32);
DECLARE @visit_number varchar(32);
declare @InsertedRows int;
declare @UpdatedRows int;

EXEC sp_xml_preparedocument @hDoc OUTPUT, @xmlDoc;
DECLARE @tmp_customer_insert As Table
(
	CustomerID int,
	FirstName varchar(max),
	LastName varchar(max),
	PhoneNumber nvarchar(max),
	Phone2 nvarchar(100),
	Email nvarchar(100),
	Address1 nvarchar(100),
	Address2 nvarchar(100),
	City nvarchar(50),
	State nvarchar(50),
	CustomerType nvarchar(100),
	CustomerAdded varchar(128),
	CardNumber varchar(50),
	Notes1 varchar(max),
	IsUpdated tinyint,
	LastUpdatedOn datetime
)


INSERT @tmp_customer_insert
SELECT *
FROM OPENXML(@hdoc, '/Customer/CustomerData', 3) WITH
(
	CustomerID int,
	FirstName varchar(max),
	LastName varchar(max),
	PhoneNumber nvarchar(max),
	Phone2 nvarchar(100),
	Email nvarchar(100),
	Address1 nvarchar(100),
	Address2 nvarchar(100),
	City nvarchar(50),
	State nvarchar(50),
	CustomerType nvarchar(100),
	CustomerAdded varchar(128),
	CardNumber varchar(50),
	Notes1 varchar(max),
	IsUpdated tinyint,
	LastUpdatedOn datetime
);

--select * into #inssert from @tmp_customer_insert where CustomerID not in (select CustomerID from ICSCustomers with (nolock));
select * into #update from @tmp_customer_insert where CustomerID in (select CustomerID from ICSCustomers with (nolock));

--select * from @tmp_customer_insert

insert into ICSCustomers select 
	CustomerID ,
	FirstName ,
	LastName ,
	PhoneNumber,
	Phone2 ,
	Email ,
	Address1 ,
	Address2 ,
	City ,
	State ,
	CustomerType ,
	CustomerAdded ,
	CardNumber ,
	Notes1,
	IsUpdated,
	LastUpdatedOn 
--	from #inssert;
from @tmp_customer_insert where CustomerID not in (select CustomerID from ICSCustomers with (nolock));
set @InsertedRows=@@ROWCOUNT;
--select @InsertedRows;
	insert into DeviceTokens select CustomerID,'',null,'',null,0,null,null
	from @tmp_customer_insert where CustomerID not in (select CustomerID from ICSCustomers with (nolock));

	update ICSCustomers set 
	FirstName = u.FirstName ,
	LastName = u.LastName ,
	PhoneNumber = u.PhoneNumber,
	Phone2 = u.Phone2 ,
	Email = u.Email,
	Address1 = u.Address1,
	Address2 =u.Address2,
	City =u.City,
	State =u.State,
	Notes1 = u.Notes1,
	LastUpdatedOn = u.LastUpdatedOn
	from ICSCustomers c
	join #update u on c.CustomerId = u.CustomerID
	where c.IsUpdated = 0 and u.CustomerId in (select CustomerID from ICSCustomers with (nolock));
	set @UpdatedRows = @@RowCount;

	select @InsertedRows as inserted,@UpdatedRows as updated;
end
GO
