using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class ItemRatingResponse: BaseServiceResponse
    {
        public IList<Rating> Ratings { get; set; }
    }
}
