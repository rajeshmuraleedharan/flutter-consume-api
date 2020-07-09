using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace rest_api.Models
{
    public class Item
    {
        public int Id { get; set; }

        public string Body { get; set; }

        public bool Completed { get; set; }
    }
}
