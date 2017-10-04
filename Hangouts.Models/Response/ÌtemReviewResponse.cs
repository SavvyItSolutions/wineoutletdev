using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class ItemReviewResponse : BaseServiceResponse
    {
        public IList<Review> Reviews { get; set; }
    }
}
