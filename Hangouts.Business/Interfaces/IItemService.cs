using Hangout.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangouts.Business
{
    public interface IItemService
    {
        int InsertUpdateSKULike(SKULike skuLike);
        CustomerResponse AuthenticateUser(string CardNumber, string Email,string DeviceId);
        int InsertUpdateReview(Review review);
        int DeleteReview(string BarCode, int reviewUserId);
        CustomerResponse GetCustomerDetails(int CustomerID);
        int UpdateCustomer(Customer CustomerObj);
        TastingListResponse GetMyTastingsList(int customerID);
        int UpdateDeviceToken1(int CustomerId, string DeviceToken, int DeviceType);        
        string InsertActivationCode(string activationCode, string email,int CustomerId);
        int UpdateVerfiedEmail(string activationCode);
        DeviceToken GetVerificationStatus(int CustId);
        int AuthorizeUser(string CardNumber, string DeviceId);
		ItemListResponse GetItemLists(int plantFinal, int userid);
		ItemDetailsResponse GetItemDetailsBarcode(string Barcode, int StoreId);
		ItemReviewResponse GetReviewsBarcode(string Barcode);
		ItemReviewResponse GetReviewUID(int uid);
		ItemListResponse GetItemFavUID(int userId);
        Customer InsertUpdateGuests(string DeviceToken,int DeviceType);
        int GetTastingsCount(int CustomerID);
        IList<Customer> GetCustomerDetail(string cardNumber);
        CustomerResponse UpdateEmailAddress(string email, int CustomerId);
	}
}
