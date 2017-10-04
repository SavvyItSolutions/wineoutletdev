using Hangout.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class ItemDetailsResponse: BaseServiceResponse
    {
        public ItemDetails ItemDetails { get; set; }
    }
}
