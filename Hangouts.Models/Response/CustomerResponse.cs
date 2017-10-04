using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Hangout.Models;

namespace Hangout.Models
{
    public class CustomerResponse :BaseServiceResponse
    {
        public Customer customer { get; set; }
    }
}
