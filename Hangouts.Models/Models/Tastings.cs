using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class Tastings : BaseItem
    {
        public DateTime TastingDate { get; set; }
        public int PlantFinal { get; set; }
    }
}
