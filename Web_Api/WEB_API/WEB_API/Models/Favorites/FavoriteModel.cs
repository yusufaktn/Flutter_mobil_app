using WEB_API.Models.StockCard;
using WEB_API.Tables.Favorites;


namespace WEB_API.Models.Favorites
{
    public class FavoriteModel: VT_FAVORITES
    {
        public List<StockCardModel> StockCard { get; set; } = new List<StockCardModel>();
    }
}
