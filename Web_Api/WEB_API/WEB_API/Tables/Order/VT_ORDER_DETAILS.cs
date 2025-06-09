
using Dapper.Contrib.Extensions;
using System.Diagnostics.CodeAnalysis;
using static WEB_API.Models.Order.OrderModel;


namespace WEB_API.Tables.Order
{
    [Table("VT_ORDER_DETAILS")]
    public class VT_ORDER_DETAILS
    {

        [Key]
        public int LOGICALREF { get; set; } = 0;
        public int ORDERREF { get; set; } = 0;
        public int STOCKCARDREF { get; set; } = 0;
        public int AMOUNT { get; set; } = 0;

     
      

    }
}
