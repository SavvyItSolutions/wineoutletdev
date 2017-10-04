using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Hangout.Models;
using System.Configuration;
using System.Data.Linq;

namespace Hangouts.DataAccess
{
    public class ItemDBManager : IItemDBManager
    {
        public HangoutsDBDataContext DBContext;

        public ItemDBManager()
        {
            string connection = System.Configuration.ConfigurationManager.ConnectionStrings["DBCON"].ConnectionString;

            DBContext = new DataAccess.HangoutsDBDataContext(connection);
        }
        
        public int InsertUpdateSKULike(SKULike skuLike)
        {
            try
            {
                int result = DBContext.InsertUpdateLike(skuLike.UserID, skuLike.SKU, skuLike.Liked,skuLike.BarCode);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public IList<AuthenticateUsersResult> AuthenticateUser(string CardNumber, string Email, string DeviceId)
        {
            try
            {
                ISingleResult<AuthenticateUsersResult> result = DBContext.AuthenticateUsers(CardNumber, Email, DeviceId);
                if (result != null)
                {
                    return result.ToList();
                }
                else
                    return null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public int InsertUpdateReview(Review review)
        {
            try
            {
                int result = DBContext.InsertUpdateReview(review.ReviewId,
                                                          review.PlantFinal,
                                                          review.ReviewDate,
                                                          review.CardId,
                                                          Convert.ToDecimal(review.Cost),
                                                          review.RatingStars,
                                                          review.SKU,
                                                          review.CommentsTitle,
                                                          review.RatingText,
                                                          review.ReviewUserId,
                                                          review.Name,
                                                          review.IsActive,
                                                          review.Barcode);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public int DeleteReview(string BarCode, int reviewUserId)
        {
            try
            {
                int result = DBContext.DeleteReview(BarCode, reviewUserId);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        

        public IList<RetrieveProfileDetailsResult> GetCustomerDetails(int customerID)
        {
            try {
                ISingleResult<RetrieveProfileDetailsResult> result =
                DBContext.RetrieveProfileDetails(customerID);
                return result.ToList();
            }
            catch(Exception ex) {
                return null;
            }
        }

        public int UpdateCustomerDetails(Customer CustomerObj)
        {
            try
            {
                int result = DBContext.UpdateCustomers(CustomerObj.FirstName,
                                                        CustomerObj.LastName,
                                                        CustomerObj.PhoneNumber,
                                                        CustomerObj.Phone2,
                                                        CustomerObj.Email,
                                                        CustomerObj.Address1,
                                                        CustomerObj.Address2,
                                                        CustomerObj.City,
                                                        CustomerObj.State,
                                                        CustomerObj.CustomerType,
                                                        CustomerObj.CustomerID,
                                                        CustomerObj.Zip,
                                                        CustomerObj.PreferredStore);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public IList<RetrieveMyTastingsResult> GetMyTastings(int custID)
        {
            try
            {
                ISingleResult<RetrieveMyTastingsResult> result =
                DBContext.RetrieveMyTastings(custID);
                return result.ToList();
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public int UpdateDeviceToken1(int CustId, string Devicetoken,int DeviceType)
        {
            try
            {
                int result = DBContext.UpdateDeviceToken1(CustId, Devicetoken,DeviceType);
                return result;
            }
            catch(Exception ex)
            {
                return 0;
            }
        }
        public int UpdateDeviceToken(int CustId, string Devicetoken)
        {
            try
            {
                int result = DBContext.UpdateDeviceToken(CustId, Devicetoken);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public IList<InsertActivationCodeResult> InsertActivationCode(string activationCode, string email,int CustomerId)
        {
            try
            {
                ISingleResult<InsertActivationCodeResult> result = DBContext.InsertActivationCode(activationCode, email,CustomerId);
                return result.ToList();
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public int UpdateVerfiedEmail(string activationCode)
        {
            try
            {
                int result = DBContext.UpdateVerificationEmail(activationCode);
                return result;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        
        public IList<GetVerificationStatusResult> GetVerifiedStatus(int CustId)
        {
            try
            {
                ISingleResult<GetVerificationStatusResult> result =
                DBContext.GetVerificationStatus(CustId);
                return result.ToList();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public IList<AuthorizeUserResult> AuthorizeUser(string CardNumber, string DeviceId)
        {
            try{
                ISingleResult<AuthorizeUserResult> retObj = DBContext.AuthorizeUser(CardNumber, DeviceId);
                return retObj.ToList();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

		public IList<RetrieveWineDetailsAltResult> GetDetailsBarcode(string Barcode, int StoreId)
		{
			try
			{
				ISingleResult<RetrieveWineDetailsAltResult> result =
				DBContext.RetrieveWineDetailsAlt(Barcode, StoreId);
				return result.ToList();
			}
			catch (Exception ex)
			{
				return null;
			}
		}
		public IList<RetrieveAvailableWinesAltResult> GetList(int plantFinal, int userid)
		{
			try
			{
				ISingleResult<RetrieveAvailableWinesAltResult> result =
				DBContext.RetrieveAvailableWinesAlt(plantFinal, userid);
				return result.ToList();
			}
			catch (Exception ex)
			{
				return null;
			}
		}
		public IList<RetrieveReviewsByWineIdAltResult> GetReviewsBarcode(string Barcode)
		{
			try
			{
				ISingleResult<RetrieveReviewsByWineIdAltResult> result =
				DBContext.RetrieveReviewsByWineIdAlt(Barcode);
				return result.ToList();
			}
			catch (Exception ex)
			{
				return null;
			}
		}
		public IList<RetrieveReviewsByUserIdAltResult> GetReviewUID(int uid)
		{
			try
			{
				ISingleResult<RetrieveReviewsByUserIdAltResult> result =
				DBContext.RetrieveReviewsByUserIdAlt(uid);
				return result.ToList();
			}
			catch (Exception ex)
			{
				return null;
			}
		}
		public IList<RetrieveFavouriteWinesByUserIdAltResult> GetItemFavUID(int userId)
		{
			try
			{
				ISingleResult<RetrieveFavouriteWinesByUserIdAltResult> result =
				DBContext.RetrieveFavouriteWinesByUserIdAlt(userId);
				return result.ToList();
			}
			catch (Exception ex)
			{
				return null;
			}
		}

        public IList<InsertUpdateGuestsResult> InsertUpdateGuests(string DeviceToken, int DeviceType)
        {
            try
            {
                ISingleResult<InsertUpdateGuestsResult> retobj = DBContext.InsertUpdateGuests(DeviceToken, DeviceType);
                return retobj.ToList();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public int GetTastingsCount(int CustomerId)
        {
            try
            {
                int retobj = Convert.ToInt32(DBContext.getNumberOfTastings(CustomerId));
                return retobj;
            }
            catch(Exception ex)
            {
                return 0;
            }
        }

        public IList<RetrieveCustomerDetailsResult> GetCustomerDetail(string cardNumber)
        {
            try
            {
                ISingleResult<RetrieveCustomerDetailsResult> result = 
                DBContext.RetrieveCustomerDetails(cardNumber);
                return result.ToList();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

        public IList<UpdateEmailAddressResult> UpdateEmailAddress(string email, int Customerid)
        {
            try
            {
                ISingleResult<UpdateEmailAddressResult> result = DBContext.UpdateEmailAddress(email, Customerid);
                return result.ToList();
            }
            catch(Exception ex)
            {
                return null;
            }
        }

    }
}
