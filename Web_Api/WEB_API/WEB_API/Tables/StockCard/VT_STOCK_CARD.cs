using Dapper.Contrib.Extensions;
using System.Diagnostics.CodeAnalysis;

namespace WEB_API.Tables.StockCard
{
    [Table("VT_STOCK_CARD")]
    public class VT_STOCK_CARD
    {
        [Key]
        public int LOGICALREF { get; set; } = 0;
        public int CATEGORYREF { get; set; } = 0;
        public string CODE { get; set; } = string.Empty;
        public string NAME { get; set; } = string.Empty;
        public string DESCRIPTION { get; set; } = string.Empty;
        public string  IMAGE{ get; set; } = string.Empty;
        public double PRICE { get; set; } = 0;
        public double RATING { get; set; } = 0;
        public string EXTRAINFO { get; set; } = string.Empty;
        public string ISFAVORITE { get; set; } = string.Empty;
        public string ISPOPULAR { get; set; } = string.Empty;
        



    }

}
