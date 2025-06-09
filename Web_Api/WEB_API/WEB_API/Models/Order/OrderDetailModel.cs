using WEB_API.Models.Account;
using WEB_API.Models.StockCard;
using WEB_API.Tables.Order;

namespace WEB_API.Models.Order
{
    public class OrderDetailModel : VT_ORDER_DETAILS
    {
        public string STOCK_NAME { get; set; } = string.Empty;
    }
}
