using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class Customer
    {
        public int CustomerID { get; set; }
        public string FirstName{ get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string Phone2 { get; set; }
        public string Email { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string CustomerType { get; set; }
        public DateTime CustsomerAdded { get; set; }
        public string CardNumber { get; set; }
        public string Notes1 { get; set; }
        public int IsUpdated { get; set; }
        public int PreferredStore { get; set; }
        public int IsMailSent { get; set; }
        public string Zip { get; set; }
        public DateTime ExpireDate { get; set; }
    }
}
