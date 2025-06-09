
using Dapper.Contrib.Extensions;
using System.Diagnostics.CodeAnalysis;
using WEB_API.Enums;
using static WEB_API.Models.Favorites.FavoriteModel;


namespace WEB_API.Tables.Favorites
{
    [Table("VT_FAVORITES")]
    public class VT_FAVORITES
    {

        [Key]
        public int LOGICALREF { get; set; } = 0;
        public int ACCOUNTREF { get; set; } = 0;
        public int STOCKCARDREF { get; set; } = 0;
        public string ADDEDDATE { get; set; } =string.Empty;



    }
}
