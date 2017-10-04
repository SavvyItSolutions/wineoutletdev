using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hangout.Models
{
    public class Item: BaseItem
    {
        public int DispenserCode { get; set; }
        public int PositionTap { get; set; }
        public int PlantFinal { get; set; }
    }
}
