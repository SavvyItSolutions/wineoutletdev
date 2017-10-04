-------------------Soumik changes------------------------------
GO
create procedure RetrieveReviewsByUserIdServerPP
	@UserID int
as
begin
begin try
	(SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID,
			isnull(re.Name,'') as UserName, 
			isnull(re.PlantFinal,1) as PlantFinal,
			re.SKU,
			w.LabelName as Name,
			w.YearOfWine as Vintage,
			'' as Region,
			''  as Country,
			re.WineId as WineID
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.WineId = det.WineId 
	inner join [Enosoft].[dbo].[wines] w
	--inner join [Enosoft].[dbo].[wines] w
	on w.WineID = det.WineID 
	inner join [Enosoft].[dbo].[DispenserTaps] dis
	on w.WineId = dis.WineId
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1 and dis.PlantFinal = 1)
		union all
		(SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID,
			isnull(re.Name,'') as UserName, 
			isnull(re.PlantFinal,2) as PlantFinal,
			re.SKU,
			w.LabelName as Name,
			w.YearOfWine as Vintage,
			'' as Region,
			''  as Country,
			re.WineId as WineID
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.WineId = det.WineId inner join [pointpleasent].[Enosoft].[dbo].[wines] w
	on w.WineID = det.WineID 
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1)
		end try
		begin catch
			exec RetrieveReviewsByUserIdServer @UserID
		end catch
end
GO
-------------------------------------------
GO
create procedure RetrieveReviewsByUserIdServer
	@UserID int
as
begin
	SELECT	re.RatingStars, 	 
			re.RatingText, 
			ReviewDate as Date, 
			re.ReviewUserID,
			isnull(re.Name,'') as UserName, 
			isnull(re.PlantFinal,1) as PlantFinal,
			re.SKU,
			w.LabelName as Name,
			w.YearOfWine as Vintage,
			'' as Region,
			''  as Country,
			re.WineId as WineID
	FROM dbo.Reviews re with (nolock) 
		join dbo.WineDetails det with (nolock) 
	ON re.WineId = det.WineId 
	inner join [Enosoft].[dbo].[wines] w
	--inner join [Enosoft].[dbo].[wines] w
	on w.WineID = det.WineID 
		WHERE re.ReviewUserID = @UserID
		and re.IsActive=1
end
GO
-------------------------------------------
GO
create procedure RetrieveReviewsByWineIdServer
	 @WineID int
as
begin 
SELECT	re.RatingStars, 	 
				re.RatingText, 
				re.PlantFinal as PlantFinal,
				ReviewDate as Date, 
				u.FirstName as UserName,
				re.ReviewUserId as ReviewUserId,
				re.SKU,
				re.Name,
				w.YearOfWine as Vintage,
				'' as Region,
				'' as Country,
				re.ReviewID as ReviewId,
				re.WineId as WineId
		FROM dbo.Reviews re with (nolock) 
			join [Enosoft].[dbo].[Wines] w with (nolock)  
		ON re.WineId = w.WineID inner join ICSCustomers u on re.ReviewUserId = u.CustomerId
		WHERE re.WineId = @WineID and re.IsActive=1;
end
GO
-------------------------------------------
GO
Create PROCEDURE [dbo].[RetrieveWineDetailsServer]
         @WineID int,
		 @StoreId int
		 as
		 begin
			Select 
			convert(int, wines.Zone) as SKU
			,wines.LabelName as Name
			,convert(int, wines.YearOfWine) as Vintage
			,''  as Country--,isnull(det.Country,'') as Country
			,'' as Region --,isnull(det.Region,'') as Region
			,'' as [Sub-Region] --,isnull(det.[Sub-Region],'') as [Sub-Region]
			,'' as [GrapeVerietal] --,isnull(det.GrapeVerietal,'') as [GrapeVerietal]
			,'' as Type --,isnull(det.Type,'') as Type
			,wines.BottleSalesPrice as SalePrice 
			,wines.PurchasePrice as RegPrice
			,isNull(det.AverageRating, 5) as AverageRating
			,isNull(det.TotalRating,5) as UsersRating
			,isNull(det.ProductDescription, '') as Description
			,0 as BottleSize --,isnull(convert(int, det.BottleSize),0) as BottleSize
			,'' as LargeImageUrl --,isNull(det.LargeImageUrl, '') as LargeImageUrl
			,1 as Liked--,isNull(det.Liked, 1) as Liked
			,wines.WineId as WineId
	--Optional: Alcohol Levels, Food Pairings, ServingAt, Tasting Notes, WineMakerNotes, Technical Notes, OtherText, Producer, List<Rating>
 		from [Enosoft].dbo.Wines wines with (nolock) 
		inner join [Enosoft].dbo.DispenserTaps dt with (nolock)
		on wines.WineId = dt.WineId
		left outer join dbo.WineDetails det with (nolock) 
		on convert(int, wines.WineID) = isNull(det.WineID,0)
		where convert(int, wines.WineID) = @WineID and dt.PlantFinal = @StoreId;
		end
GO
-------------------------------------------
GO
create procedure AuthorizeUser
(
	@CardNumber varchar(50),
	@DeviceId varchar(max)
)
as
begin
	if exists (select CustomerId from ICSCustomers with (nolock) where CardNumber = @CardNumber)
	begin
		return 1;
	end
	else
	begin
		return 0;
	end
end
GO
-----------------------------------------------
GO
GO
ALTER PROCEDURE [dbo].[AuthenticateUsers]
(
	@CardNumber varchar(50),
	@DeviceId varchar(max),
	@EmailId nvarchar(100)
)
AS
BEGIN
declare @CustId int;
declare @verified tinyint;
		
	Begin
		set @CustId = (Select top 1 CustomerId from ICSCustomers with (nolock) where CardNumber = @CardNumber)
		if exists(select CustomerId from DeviceTokens with (nolock) where DeviceId = @DeviceId and CustomerId = @CustId)
		Begin	
			set @verified = (select verified from DeviceTokens with (nolock) where CustomerId = @CustId);
			if(@verified = 1)
			begin
				update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
				update DeviceTokens set email = @EmailId where CustomerId = @CustId;
				SELECT top 1 c.*,t.PrefferredStore,0 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
			end
			else
			begin
				update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
				update DeviceTokens set email = @EmailId where CustomerId = @CustId;
				SELECT top 1 c.*,t.PrefferredStore,1 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
			end
		End
		else
		Begin
			update ICSCustomers set Email = @EmailId where CustomerId = @CustId;
			update DeviceTokens set DeviceId = @DeviceId,Verified = 0,email = @EmailId where CustomerId = @CustId;
			SELECT top 1 c.*,t.PrefferredStore,1 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CustomerId = @CustId;
		End
	End
	else
	Begin
		--Select 0 as CustomerId,'' as FirstName,'' as LastName,'' as  PhoneNumber,'' as Phone2,'' as Email,'' as Address1,'' as Address2,'' as City,'' as State,'' as CustomerType,'' as CustomerAdded,'' as CardNumber, '' as Notes1,'' as IsUpdated,'' as LastUpdated,'' as PrefferredStore,0 as IsMailSent;
		SELECT top 1 c.*,t.PrefferredStore,0 as IsMailSent FROM ICSCustomers c with (nolock) inner join DeviceTokens t on c.CustomerID = t.CustomerId where c.CardNumber = CardNumber;
	End
END
GO
-------------------------------------------------------