using WEB_API.Models.Account;
using WEB_API.Models.StockCard;
using WEB_API.Tables.Order;

namespace WEB_API.Models.Order
{
    public class OrderModel:VT_ORDER
    {
        public List<StockCardModel> StockCard { get; set; } = new List<StockCardModel>();
        public List<OrderDetailModel> Details { get; set; } = new List<OrderDetailModel>();
        public AccountModel Account { get; set; } = new AccountModel();
        
    }
}
