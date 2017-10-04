using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class ItemDetails : BaseItem
    {
        //public decimal AvgRating { get; set; } Already in Base Class
        public decimal UsersRating { get; set; }
        public string LargeImageUrl { get; set; }
       // public string Producer { get; set; }
        //public List<Review> Reviews { get; set; }
        public List<Review> Reviews { get; set; }
        //Properties
        public Dictionary<string, string> WineProperties { get; set; }
        //public string Sub_Region { get; set; }
        //public string GrapeVerietal { get; set; }
        //public string Type { get; set; }
        //public string BottleSize { get; set; }
        //public string Alcohol_Levels { get; set; }
        //public string Food_Pairings { get; set; }
        //public string ServingAt { get; set; }
        //public string Tasting_Notes { get; set; }
        //public string WineMakerNotes { get; set; }
        //public string TechnicalNotes { get; set; }
        //public string Notes { get; set; }
        //public string OtherText { get; set; }

    }
}
