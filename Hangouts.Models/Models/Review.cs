using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class Review
    {
        public int ReviewId { get; set; }
        public string PlantFinal { get; set; }
        public int CardId { get; set; }
        public double Cost { get; set; }
        public DateTime ReviewDate { get; set; }
        public string CommentsTitle { get; set; }
        public int RatingStars { get; set; }
        public int SKU { get; set; }
        public string RatingText { get; set; }
        public int ReviewUserId { get; set; }
        public string Name { get; set; }
        public bool IsActive { get; set; }
        public DateTime Date { get; set; }
        public string Username { get; set; }
        public string Vintage { get; set; }
        public string Region { get; set; }
        public string Country { get; set; }
        public int WineId { get; set; }
        public string Barcode { get; set; }
        public int Liked { get; set; }
        public string SmallImageURL { get; set; }
	}
}
