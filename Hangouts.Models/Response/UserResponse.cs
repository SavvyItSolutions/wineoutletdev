using Hangout.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class UserResponse : BaseServiceResponse
    {
        public User user { get; set; }
    }
}
