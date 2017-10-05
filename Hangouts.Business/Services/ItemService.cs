using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Hangout.Models;
using Hangouts.DataAccess;

namespace Hangouts.Business
{
    public class ItemService : IItemService
    {
        public int InsertUpdateSKULike(SKULike skuLike)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            return (itemDBManager.InsertUpdateSKULike(skuLike));
        }
        public int CheckConnection(int ID)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            return (itemDBManager.CheckConnection(ID));
        }
        public CustomerResponse AuthenticateUser(string CardNumber, string Email,string DeviceToken)
        {
            CustomerResponse respObj = new CustomerResponse();
            Customer userObj = new Customer();
            IItemDBManager itemDBManager = new ItemDBManager();
            IList<AuthenticateUsersResult> resultObj = itemDBManager.AuthenticateUser(CardNumber, Email, DeviceToken).ToList();
            if (resultObj != null)
                foreach (AuthenticateUsersResult result in resultObj)
                {
                    userObj = new Customer
                    {
                        CustomerID = Convert.ToInt32(result.CustomerID),
                        FirstName = result.FirstName,
                        LastName = result.LastName,
                        Email = result.Email,
                        PhoneNumber = result.PhoneNumber,
                        Phone2 = result.Phone2,
                        PreferredStore = Convert.ToInt32(result.PrefferredStore),
                        IsMailSent = result.IsMailSent
                    };
                }
            respObj.customer = userObj;
            return respObj;
        }

        public int DeleteReview(string BarCode, int reviewUserId)
        {
            try
            {
                IItemDBManager itemDBManager = new ItemDBManager();
                itemDBManager.DeleteReview(BarCode, reviewUserId);
                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public int InsertUpdateReview(Review review)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            itemDBManager.InsertUpdateReview(review);
            return 1;
        }
        
        public CustomerResponse GetCustomerDetails(int CustomerID)
        {
            CustomerResponse respObj = new CustomerResponse();
            Customer CustObj = new Customer();
            respObj.customer = CustObj;
            IItemDBManager dbObj = new ItemDBManager();
            IList<RetrieveProfileDetailsResult> CustomerDetailsObj = dbObj.GetCustomerDetails(CustomerID);
            if (CustomerDetailsObj != null)
            {
                foreach (RetrieveProfileDetailsResult result in CustomerDetailsObj)
                {
                    CustObj = new Customer();
                    CustObj.CustomerID = Convert.ToInt32(result.CustomerID);
                    CustObj.FirstName = result.FirstName;
                    CustObj.LastName = result.LastName;
                    CustObj.PhoneNumber = result.PhoneNumber;
                    if (CustObj.PhoneNumber != null && CustObj.PhoneNumber != "")
                            CustObj.PhoneNumber =  CustObj.PhoneNumber.Replace("-", string.Empty);
                    CustObj.Phone2 = result.Phone2;
                    if (CustObj.Phone2 != null && CustObj.Phone2 != "")
                        CustObj.Phone2 =  CustObj.Phone2.Replace("-", string.Empty);
                    CustObj.Email = result.Email;
                    CustObj.Address1 = result.Address1;
                    CustObj.Address2 = result.Address2;
                    CustObj.City = result.City;
                    CustObj.State = result.State;
                    CustObj.CustomerType = result.CustomerType;
                    CustObj.CustsomerAdded = Convert.ToDateTime(result.CustomerAdded);
                    CustObj.CardNumber = result.CardNumber;
                    CustObj.Notes1 = result.Notes1;
                    CustObj.Zip = result.zip;
                    CustObj.PreferredStore = Convert.ToInt32(result.PrefferredStore);
                    CustObj.ExpireDate = Convert.ToDateTime(result.ExpireDate);
                }
            }
            respObj.customer = CustObj;
            return respObj;
        }

        public int UpdateCustomer(Customer CustomerObj)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            int ret = itemDBManager.UpdateCustomerDetails(CustomerObj);
            return ret;
        }

        public TastingListResponse GetMyTastingsList(int customerID)
        {
            TastingListResponse respObj = new TastingListResponse();
            List<Tastings> itemObj = new List<Tastings>();

            respObj.TastingList = itemObj;

            IItemDBManager dbObj = new ItemDBManager();
            IList<RetrieveMyTastingsResult> wineDetailsObj = dbObj.GetMyTastings(customerID);
            if (wineDetailsObj != null)
            {
                foreach (RetrieveMyTastingsResult resultObj in wineDetailsObj)
                {
                    itemObj.Add(new Tastings
                    {
                        SKU = resultObj.SKU.ToString(),
                        Name = resultObj.Name,
                        Vintage = Convert.ToInt32(resultObj.Vintage),
                        SalePrice = Convert.ToDouble(resultObj.SalePrice),
                        RegPrice = Convert.ToDouble(resultObj.RegPrice),
                        Description = resultObj.Description,
                        TastingDate = Convert.ToDateTime(resultObj.TastingDate),
                        PlantFinal = Convert.ToInt32(resultObj.PlantFinal),
						Barcode=resultObj.BarCode,
                        IsLike = resultObj.Liked,
                        SmallImageUrl = resultObj.SmallImageURL
					});
                }
                respObj.TastingList = itemObj;
            }
            return respObj;
        }
        public int UpdateDeviceToken1(int CustomerId, string DeviceToken,int DeviceType)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            int ret = itemDBManager.UpdateDeviceToken1(CustomerId,DeviceToken,DeviceType);
            return ret;
        }
        
        public string InsertActivationCode(string activationCode, string email,int CustomerId)
        {
            string retObj = null;
            IItemDBManager itemDBManager = new ItemDBManager();
            IList<InsertActivationCodeResult> resultObj = itemDBManager.InsertActivationCode(activationCode, email, CustomerId);
            foreach (InsertActivationCodeResult i in resultObj)
                retObj = i.ActivationCode;
            return retObj;
        }

        public int UpdateVerfiedEmail(string activationCode)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            itemDBManager.UpdateVerfiedEmail(activationCode);
            return 1;
        }
        
        public DeviceToken GetVerificationStatus(int CustId)
        {
            DeviceToken retObj = new DeviceToken();
            IItemDBManager dbObj = new ItemDBManager();
            IList<GetVerificationStatusResult> result = dbObj.GetVerifiedStatus(CustId);
            if(result != null)
            {
                retObj.VerificationStatus = Convert.ToInt32(result[0].Verified);
            }
            return retObj;
        }

        public int AuthorizeUser(string CardNumber, string DeviceId)
        {
            IList<AuthorizeUserResult> retObj;
            IItemDBManager itemDBManager = new ItemDBManager();
            retObj = itemDBManager.AuthorizeUser(CardNumber,DeviceId);
            return retObj[0].Column1;
        }

		public ItemListResponse GetItemLists(int plantFinal, int userid)
		{
			ItemListResponse itemListResponse = new ItemListResponse();
			List<Item> itemList = new List<Item>();

			IItemDBManager itemDBManager = new ItemDBManager();
			IList<RetrieveAvailableWinesAltResult> wineResults = itemDBManager.GetList(plantFinal, userid).ToList();
			foreach (RetrieveAvailableWinesAltResult result in wineResults)
			{
				itemList.Add(new Item
				{
					SKU = result.SKU,
					Name = result.Name,
					Region = result.Region,
					Country = result.Country,
					SalePrice = Convert.ToDouble(result.SalePrice),
					RegPrice = Convert.ToDouble(result.RegPrice),
					AverageRating = Convert.ToDecimal(result.AverageRating),
					IsLike = Convert.ToBoolean(result.Liked),
					SmallImageUrl = result.SmallImageURL,
					Vintage = result.Vintage,
					WineId = Convert.ToInt32(result.WineId),
					DispenserCode = Convert.ToInt32(result.DispenserCode),
					PositionTap = Convert.ToInt32(result.PositionTap),
					Barcode = result.BarCode,
                    AvailableVolume = Convert.ToDouble(result.AvailableVolume),
                    InsertionTime = result.InsertionTime
				});
			}
			itemListResponse.ItemList = itemList;
			return itemListResponse;
		}
		public ItemDetailsResponse GetItemDetailsBarcode(string Barcode, int StoreId)
		{
			ItemDetailsResponse itemDetailsResponse = new ItemDetailsResponse();
			ItemDetails itemDetailsList = new ItemDetails();


			itemDetailsResponse.ItemDetails = itemDetailsList;

			#region DB Interaction

			IItemDBManager itemDBManager = new ItemDBManager();
			IList<RetrieveWineDetailsAltResult> wineDetailsResults = itemDBManager.GetDetailsBarcode(Barcode, StoreId).ToList();

			if (wineDetailsResults.Any())
			{
				foreach (RetrieveWineDetailsAltResult result in wineDetailsResults)
				{
					itemDetailsList = new ItemDetails
					{
						SKU = result.SKU.ToString(),
						Name = result.Name,
						Region = result.Region,
						Country = result.Country,
						SalePrice = Convert.ToDouble(result.SalePrice),
						RegPrice = Convert.ToDouble(result.RegPrice),

						AverageRating = Convert.ToDecimal(result.AverageRating),
						IsLike = Convert.ToBoolean(result.Liked),
						LargeImageUrl = result.LargeImageUrl,
						//Sub_Region = result.Sub_Region,
						//GrapeVerietal = result.GrapeVerietal,
						Vintage = Convert.ToInt32(result.Vintage),
						UsersRating = Convert.ToDecimal(result.UsersRating),
						Description = result.Description,
						Producer =result.Producer,
						WineProperties = new Dictionary<string, string>(),
						WineId = Convert.ToInt32(result.WineId),
						Barcode = result.BarCode,
                        AvailableVolume = Convert.ToDouble(result.AvailableVolume),
                        InsertionTime = result.InsertionTime						
					};
				}
				itemDetailsResponse.ItemDetails = itemDetailsList;
			}
			#endregion
			return itemDetailsResponse;
		}
		public ItemReviewResponse GetReviewsBarcode(string Barcode)
		{
			ItemReviewResponse itemReviewResponse = new ItemReviewResponse();
			IList<Review> raingList = new List<Review>();
			IItemDBManager itemDBManager = new ItemDBManager();
			IList<RetrieveReviewsByWineIdAltResult> reviewsSKUresult = itemDBManager.GetReviewsBarcode(Barcode).ToList();
			foreach (RetrieveReviewsByWineIdAltResult result in reviewsSKUresult)
			{
				raingList.Add(new Review
				{
					SKU = Convert.ToInt32(result.SKU),
					RatingStars = result.RatingStars,
					Date = Convert.ToDateTime(result.Date),
					Username = result.UserName.ToString(),
					Name = result.Name,
					Vintage = result.Vintage.ToString(),
					Region = result.Region,
					Country = result.Country,
					RatingText = result.RatingText,
					ReviewId = result.ReviewId,
					Barcode = result.BarCode.ToString(),
					ReviewUserId = Convert.ToInt32(result.ReviewUserId),
					PlantFinal = result.PlantFinal

				});
			}
			itemReviewResponse.Reviews = raingList;
			return itemReviewResponse;
		}
		public ItemReviewResponse GetReviewUID(int uid)
		{
			ItemReviewResponse itemReviewResponse = new ItemReviewResponse();
			IList<Review> raingList = new List<Review>();
			IItemDBManager itemDBManager = new ItemDBManager();
			IList<RetrieveReviewsByUserIdAltResult> reviewsUserresult = itemDBManager.GetReviewUID(uid).ToList();
			foreach (RetrieveReviewsByUserIdAltResult result in reviewsUserresult)
			{
				raingList.Add(new Review
				{
					SKU = Convert.ToInt32(result.SKU),
					RatingStars = result.RatingStars,
					Date = Convert.ToDateTime(result.Date),
					PlantFinal = result.PlantFinal,
					RatingText = result.RatingText,
					Username = result.UserName.ToString(),
					Name = result.Name,
					Vintage = result.Vintage.ToString(),
					Region = result.Region,
					Country = result.Country,
					Barcode = result.BarCode.ToString(),
                    Liked = Convert.ToInt32(result.Liked),
                    SmallImageURL = result.SmallImageURL
				});
			}
			itemReviewResponse.Reviews = raingList;
			return itemReviewResponse;
		}
		public ItemListResponse GetItemFavUID(int userId)
		{
			ItemListResponse respObj = new ItemListResponse();
			List<Item> itemObj = new List<Item>();

			respObj.ItemList = itemObj;

			IItemDBManager dbObj = new ItemDBManager();
			IList<RetrieveFavouriteWinesByUserIdAltResult> wineDetailsObj = dbObj.GetItemFavUID(userId);
			if (wineDetailsObj.Any())
			{
				foreach (RetrieveFavouriteWinesByUserIdAltResult resultObj in wineDetailsObj)
				{
					itemObj.Add(new Item
					{
						SKU = resultObj.SKU.ToString(),
						Name = resultObj.Name,
						Vintage = resultObj.Vintage,
						SalePrice = Convert.ToDouble(resultObj.SalePrice),
						RegPrice = Convert.ToDouble(resultObj.RegPrice),
						IsLike = Convert.ToBoolean(resultObj.Liked),
						WineId = Convert.ToInt32(resultObj.WineId),
						AverageRating = Convert.ToInt32(resultObj.AverageRating),
						PlantFinal = Convert.ToInt32(resultObj.PlantFinal),
						Barcode = resultObj.BarCode,
                        SmallImageUrl = resultObj.SmallImageURL

					});
				}
				respObj.ItemList = itemObj;
			}
			return respObj;
		}

        public Customer InsertUpdateGuests(string DeviceToken,int DeviceType)
        {
            IItemDBManager dbManager = new ItemDBManager();
            IList<InsertUpdateGuestsResult> resultObj = dbManager.InsertUpdateGuests(DeviceToken,DeviceType);
            Customer cust = new Customer();
            cust.CustomerID = Convert.ToInt32(resultObj[0].Column1);
            return cust;
        }

        public int GetTastingsCount(int CustomerID)
        {
            IItemDBManager itemDBManager = new ItemDBManager();
            int count = itemDBManager.GetTastingsCount(CustomerID);
            return count;
        }

        public IList<Customer> GetCustomerDetail(string cardNumber)
        {
            IList<Customer> cust = new List<Customer>();
            IItemDBManager itemDBManager = new ItemDBManager();
            IList<RetrieveCustomerDetailsResult> resultList = itemDBManager.GetCustomerDetail(cardNumber).ToList();
            foreach (RetrieveCustomerDetailsResult result in resultList)
            {
                cust.Add(new Customer
                {
                    CardNumber = cardNumber,
                    FirstName = result.FirstName.ToString(),
                    Email = result.Email
                });
            }
            return cust;
        }

        public CustomerResponse UpdateEmailAddress(string email, int CustomerId)
        {
            CustomerResponse custs = new CustomerResponse();
            Customer cust = new Customer();
            IItemDBManager itemDBManager = new ItemDBManager();
            IList<UpdateEmailAddressResult> resultList = itemDBManager.UpdateEmailAddress(email, CustomerId);
            foreach(UpdateEmailAddressResult result in resultList)
            {
                cust = new Customer
                {
                    CardNumber = result.CardNumber,
                    FirstName = result.FirstName,
                    Email = result.Email,
                    PhoneNumber = result.PhoneNumber,
                    CustomerID = Convert.ToInt32(result.CustomerID)
                };
            }
            custs.customer = cust;
            return custs;
        }

    }
}
