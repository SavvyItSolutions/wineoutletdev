using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class Rating
    {
        public string SKU { get; set; }
        public decimal RatingStars { get; set; }
        public string RatingText { get; set; }
        public DateTime Date { get; set; }
        public string Username { get; set; }
        public string Name { get; set; }
        public string Vintage { get; set; }
        public string Region { get; set; }
        public string Country { get; set; }
    }
}
