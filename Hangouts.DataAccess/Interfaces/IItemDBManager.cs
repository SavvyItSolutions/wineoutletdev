using Hangout.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangouts.DataAccess
{
    public interface IItemDBManager
    {
        
        
        
        
        int InsertUpdateSKULike(SKULike skuLike);
        IList<AuthenticateUsersResult> AuthenticateUser(string CardNumber, string Email, string DeviceId);
        int InsertUpdateReview(Review review);
        int DeleteReview(string BarCode, int reviewUserId);
        
        IList<RetrieveProfileDetailsResult> GetCustomerDetails(int customerid);
        int UpdateCustomerDetails(Customer customerObj);
        IList<RetrieveMyTastingsResult> GetMyTastings(int custID);
        int UpdateDeviceToken1(int CustId, string Devicetoken,int DeviceType);
        int UpdateDeviceToken(int CustId, string Devicetoken);
        IList<InsertActivationCodeResult> InsertActivationCode(string activationCode, string email,int CustomerId);
        int UpdateVerfiedEmail(string activationCode);
        IList<GetVerificationStatusResult> GetVerifiedStatus(int CustId);
        IList<AuthorizeUserResult> AuthorizeUser(string CardNumber, string DeviceId);
		IList<RetrieveReviewsByUserIdAltResult> GetReviewUID(int uid);
		IList<RetrieveAvailableWinesAltResult> GetList(int plantFinal, int userid);
		IList<RetrieveWineDetailsAltResult> GetDetailsBarcode(string Barcode, int StoreId);
		IList<RetrieveReviewsByWineIdAltResult> GetReviewsBarcode(string Barcode);
		IList<RetrieveFavouriteWinesByUserIdAltResult> GetItemFavUID(int userId);
        IList<InsertUpdateGuestsResult> InsertUpdateGuests(string DeviceTokens, int DeviceType);
        int GetTastingsCount(int CustomerId);
        IList<RetrieveCustomerDetailsResult> GetCustomerDetail(string cardNumber);
        IList<UpdateEmailAddressResult> UpdateEmailAddress(string email, int Customerid);
    }
}
