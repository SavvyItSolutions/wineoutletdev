using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class SKULike
    { 
        public int LikeID { get; set; }
        public int UserID { get; set; }
        public int SKU { get; set; }
        public bool Liked { get; set; }
        public int WineId { get; set; }
        public string BarCode { get; set; }
    }
}
