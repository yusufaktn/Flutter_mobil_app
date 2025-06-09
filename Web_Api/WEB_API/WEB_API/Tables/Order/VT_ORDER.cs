using Dapper.Contrib.Extensions;
using System.Diagnostics.CodeAnalysis;
using WEB_API.Enums;
using static WEB_API.Models.Order.OrderModel;



namespace WEB_API.Tables.Order
{
    [Table("VT_ORDER")]
    public class VT_ORDER
    {

        [Key]
        public int LOGICALREF { get; set; } = 0;
        public int ACCOUNTREF { get; set; } = 0;
        public string PAYMENTREF { get; set; } = string.Empty;
        public DateTime ORDER_DATE_TIME { get; set; } = DateTime.Now;
        public string SHIP_ADDRESS {  get; set; } = string.Empty;
        public string ORDER_TOTAL_PRICE { get; set; } = string.Empty;
        public enOrderStatus ORDERSTATUS { get; set; } = enOrderStatus.Created;


    }
}
