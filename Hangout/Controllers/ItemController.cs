using System;
using System.Collections.Generic;
using System.Linq;
using System.Diagnostics;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Hangout.Models;
using Hangouts.Business;
using System.Configuration;

namespace Hangout.Controllers
{

    public class ItemController : ApiController
    {
        [AllowAnonymous]
        [HttpGet]
        public string TestService()
        {
            return "Ankur";
        }

        [HttpGet]
        public string TestService(int objectId)
        {
            return "Ankur Dubey";
        }

        [Authorize]
        [HttpPost]
        public int InsertUpdateLike(SKULike skuLike)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Started service InsertUpdateLike");
            IItemService itemService = new ItemService();
            int resp = itemService.InsertUpdateSKULike(skuLike);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken to InsertUpdateLike like =" + tm);
            return resp;
        }

        [Authorize]
        [HttpPost]
        public int InsertUpdateReview(Review review)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start service InsertUpdateReview");
            IItemService itemService = new ItemService();
            int resp = itemService.InsertUpdateReview(review);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for InsertUpdateReview ="+tm);
            return resp;
        }

        [Authorize]
        [HttpPost]
        public int DeleteReview(Review review)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service DeleteReview");
            IItemService itemService = new ItemService();
            int resp = itemService.DeleteReview(review.Barcode, review.ReviewUserId);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for DeleteReview="+tm);
            return resp;
        }

        [HttpGet]
        public CustomerResponse GetCustomerDetails(int objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service GetCustomerDetails");
            CustomerResponse resp = new CustomerResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetCustomerDetails(objectId);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetCustomerDetails="+tm);
            return resp;
        }

        [Authorize]
        [HttpPost]
        public int UpdateCustomer(Customer CustomerObj)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service UpdateCustomer");
            IItemService itemService = new ItemService();
            int resp =itemService.UpdateCustomer(CustomerObj);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for UpdateCustomer=" + tm);
            return resp;
        }
        [HttpGet]
        public TastingListResponse GetMyTastingsList(int objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service GetMyTastingsList");
            TastingListResponse resp = new TastingListResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetMyTastingsList(objectId);
            if (resp.TastingList.Count < 1)
            {
                resp.ErrorDescription = "Please start tasting our amazing collection of wines.";
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetMyTastingsList ="+tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpPost]
        public int UpdateDeviceToken1(int objectId, string DeviceToken, int DeviceType)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service UpdateDeviceToken1");
            IItemService itemService = new ItemService();
            int resp = itemService.UpdateDeviceToken1(objectId, DeviceToken, DeviceType);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for UpdateDeviceToken1=" + tm);
            return resp;
        }

        [HttpGet]
        public int UpdateVerifiedEmail(string objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service UpdateVerifiedEmail");
            IItemService itemService = new ItemService();
            int resp = itemService.UpdateVerfiedEmail(objectId);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for UpdateVerifiedEmail=" + tm);
            return resp;
        }
        
        [HttpGet]
        public DeviceToken GetVerificationStatus(int objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service GetVerificationStatus");
            DeviceToken resp = new DeviceToken();
            IItemService itemService = new ItemService();
            resp = itemService.GetVerificationStatus(objectId);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetVerificationStatus=" + tm);
            return resp;

        }

        [AllowAnonymous]
        [HttpGet]
        public ItemListResponse GetItemLists(int objectId, int userid)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service GetItemLists");
            ItemListResponse resp = new ItemListResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetItemLists(objectId, userid);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetItemLists=" + tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public ItemListResponse GetItemFavUID(int objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of service GetItemFavUID");
            ItemListResponse resp = new ItemListResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetItemFavUID(objectId);
            if (resp.ItemList.Count == 0)
            {
                int count = itemService.GetTastingsCount(objectId);
                if (count > 0)
                    resp.ErrorDescription = "You have tasted " + count + " wines. \nTell us your favorites.";
                else
                    resp.ErrorDescription = "All your favorite wines will be listed here.\n To mark a wine as your favorite select the heart button.";
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetItemFavUID=" + tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public ItemDetailsResponse GetItemDetailsBarcode(string objectId, int userid)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service GetItemDetailsBarcode");
            ItemDetailsResponse resp = new ItemDetailsResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetItemDetailsBarcode(objectId, userid);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetItemDetailsBarcode=" + tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public ItemReviewResponse GetReviewsBarcode(string objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service GetReviewsBarcode");
            ItemReviewResponse resp = new ItemReviewResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetReviewsBarcode(objectId);
            if (resp.Reviews.Count == 0)
            {
                resp.ErrorDescription = "Be the first one to review this wine. \nSelect the Stars above to add your comments.";
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetReviewsBarcode=" + tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public ItemReviewResponse GetReviewUID(int objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service GetReviewUID");
            ItemReviewResponse resp = new ItemReviewResponse();
            IItemService itemService = new ItemService();
            resp = itemService.GetReviewUID(objectId);
            if (resp.Reviews.Count == 0)
            {
                int count = itemService.GetTastingsCount(objectId);
                if (count > 0)
                {
                    resp.ErrorDescription = "You have tasted " + count + " of our wines. \nWe would love to hear your feedback";
                }
                else
                {
                    resp.ErrorDescription = "Please start tasting our wines. \nWe would love to hear your feedback";
                }
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for GetReviewUID=" + tm);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public CustomerResponse InsertUpdateGuests(string objectId, int DeviceToken)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service InsertUpdateGuests");
            IItemService itemService = new ItemService();
            CustomerResponse resp = new CustomerResponse();
            resp.customer = itemService.InsertUpdateGuests(objectId, DeviceToken);
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for InsertUpdateGuests=" + tm);
            return resp;
        }

        [HttpGet]
        public int ResendEmail(string objectId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service ResendEmail for customerid="+objectId);
            IList<Customer> resp = new List<Customer>();
            IItemService itemService = new ItemService();
            resp = itemService.GetCustomerDetail(objectId);
            if (resp != null && resp[0].CardNumber != null)
            {
                string activationCode = Guid.NewGuid().ToString();
                activationCode = itemService.InsertActivationCode(activationCode, resp[0].Email,resp[0].CustomerID);
                if (activationCode != null && activationCode != "")
                {
                    SendEmail se = new SendEmail();
                    var result = se.SendOneEmail(activationCode, resp[0].Email, resp[0].FirstName);
                }
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for ResendEmail=" + tm+" for customerid="+objectId);
            return 1;
        }

        [Authorize]
        [HttpGet]
        public CustomerResponse UpdateEmailAddress(string objectId, int userid)
        {
            string SMSuser = ConfigurationManager.AppSettings["SMS_ID"];
            string SMSpwd = ConfigurationManager.AppSettings["SMS_PWD"];
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service UpdateEmailAddress for customerId="+userid);
            string response = null;
            IItemService itemService = new ItemService();
            CustomerResponse resp = new CustomerResponse();
            resp = itemService.UpdateEmailAddress(objectId, userid);
            string activationCode = Guid.NewGuid().ToString();
            response = itemService.InsertActivationCode(activationCode, resp.customer.Email,resp.customer.CustomerID);
            if (response != null && response != "")
            {
                resp.customer.IsMailSent = 1;
                SendEmail se = new SendEmail();
                SMSCAPI sms = new SMSCAPI();
                var result = se.SendOneEmail(response, resp.customer.Email, resp.customer.FirstName);
                resp.ErrorDescription = "Hi " + resp.customer.FirstName + " " + resp.customer.LastName + ",\nWe have sent you a verification link to " + resp.customer.Email + ". Please click on the activation link to activate the account.";
                string mobile = resp.customer.PhoneNumber;
                if (mobile != "" || mobile != null)
                {
                    if (mobile.Contains("-"))
                    {
                        mobile.Replace("-", "");
                    }
                    sms.SendSMS(SMSuser, SMSpwd, "1" + mobile, "Click here to activate our exiting Wine Outlet app." + "https://hangoutz.azurewebsites.net/VerificationPage.html?ActivationCode=" + response);
                }
            }
            else
            {
                Trace.TraceError("Error in Update Email Click, CustomerID = " + resp.customer.CustomerID + " and mail sent = " + resp.customer.IsMailSent);
                resp.ErrorDescription = "Oops! Something went wrong. Please click Resend Email so that we can confirm the email id!";
                resp.customer.IsMailSent = 0;
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for UpdateEmailAddress=" + tm +" for customerId ="+userid);
            return resp;
        }

        [Authorize]
        [HttpPost]
        public CustomerResponse ContinueClick(CustomerResponse objectId)
        {
            string SMSuser = ConfigurationManager.AppSettings["SMS_ID"];
            string SMSpwd = ConfigurationManager.AppSettings["SMS_PWD"];
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service ContinueClick for CustomerId="+objectId.customer.CustomerID);
            string response = null;
            IItemService itemService = new ItemService();
            string activationCode = Guid.NewGuid().ToString();
            response = itemService.InsertActivationCode(activationCode, objectId.customer.Email,objectId.customer.CustomerID);
            if (response != null && response != "")
            {
                objectId.customer.IsMailSent = 1;
                SendEmail se = new SendEmail();
                SMSCAPI sms = new SMSCAPI();
                var result = se.SendOneEmail(response, objectId.customer.Email, objectId.customer.FirstName);
                objectId.ErrorDescription = "Hi " + objectId.customer.FirstName + " " + objectId.customer.LastName + ",\nWe have sent you a verification link to your registered email. Please click on the link to activate the account.";
                string mobile = objectId.customer.PhoneNumber;
                if (mobile != "" || mobile != null)
                {
                    if (mobile.Contains("-"))
                    {
                        mobile.Replace("-", "");
                    }
                    sms.SendSMS(SMSuser, SMSpwd, "1" + mobile, "Click here to activate our exiting Wine Outlet app." + "https://hangoutz.azurewebsites.net/VerificationPage.html?ActivationCode=" + response);
                }
            }
            else
            {
                Trace.TraceError("Error in ContinueClick, CustomerID = "+objectId.customer.CustomerID+" and mail sent = "+objectId.customer.IsMailSent);
                objectId.ErrorDescription = "Oops! Something went wrong. Please click Resend Email so that we can confirm the email id!";
                objectId.customer.IsMailSent = 0;
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for ContinueClick=" + tm+ " for customerid="+objectId.customer.CustomerID);
            return objectId;
        }

        [Authorize]
        [HttpGet]
        public CustomerResponse AuthenticateUserBeta(string objectId, string EmailId, string DeviceId)
        {
            DateTime start = DateTime.Now;
            Trace.TraceInformation("Start of the service AuthenticateUserBeta for card number="+objectId);
            string response = null;
            CustomerResponse resp = new CustomerResponse();
            IItemService itemService = new ItemService();
            resp = itemService.AuthenticateUser(objectId, EmailId, DeviceId);
            if (resp.customer.CustomerID == 0)//&& resp.customer.IsMailSent == 0)
                resp.ErrorDescription = "We do not have your email address in our records. Please update it by contacting the store.";
            if (resp.customer.CustomerID != 0 && resp.customer.IsMailSent == 0)
            {
                if (resp.customer.Email != "" && resp.customer.Email != null)
                    resp.ErrorDescription = "Please press Continue to receive an email at " + resp.customer.Email + ". To activate your account or change the email by clicking on Update";
                //"Hi " + resp.customer.FirstName + " " + resp.customer.LastName + ", \nWe are sending a verification email to " + resp.customer.Email + " . To proceed press continue. To change your emailAddress click on Update.";
                else
                    resp.ErrorDescription = "Hi " + resp.customer.FirstName + resp.customer.LastName + ", \nIt seems we do not have your email address! Please update it so we can send you a verification link that will activate your account.";

            }
            else
            {
                Trace.TraceError("Error in AuthenticateuserBeta,Customer Id= " + resp.customer.CustomerID + " Mail Sent = " + resp.customer.IsMailSent);
                Trace.TraceError("Error in AuthenticateuserBeta,EmailId= " + EmailId + " DeviceID = " + DeviceId);
                resp.ErrorDescription = "Oops! Something went wrong. Please scan the card again!";
            }
            DateTime end = DateTime.Now;
            TimeSpan tm = end - start;
            Trace.TraceInformation("Time taken for AuthenticateUserBeta=" + tm + " for cardnumber="+objectId);
            return resp;
        }

        [AllowAnonymous]
        [HttpGet]
        public int SendEmail(string objectId, string userid)
        {
            int result = 0;
            SendEmail se = new SendEmail();
            var response = se.SendOneEmail(objectId, userid);
            return result;
        }
    }
}
