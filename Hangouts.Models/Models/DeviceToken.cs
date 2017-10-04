using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class DeviceToken
    {
        public int DBKey { get; set; }
        public int CustomerID { get; set; }
        public string DeviceTokens { get; set; }
        public int DeviceType { get; set; }
        public string EmailId { get; set; }
        public string ActivationCode { get; set; }
        public int VerificationStatus { get; set; }
        public int PrefferedStore { get; set; }
    }
}
