using Dapper.Contrib.Extensions;
using System.Diagnostics.CodeAnalysis;

namespace WEB_API.Tables.Account
{
    [Table("VT_ACCOUNT")]
    public class VT_ACCOUNT
    {
        [Key]
        public int LOGICALREF { get; set; } = 0;
        public string NAME { get; set; } = string.Empty;
        public string SURNAME { get; set; } = string.Empty;
        public string MAIL { get; set; } = string.Empty;
        public string PASSWORD { get; set; } = string.Empty;
        public string TEL { get; set; } = string.Empty;

    }
    
 

}
