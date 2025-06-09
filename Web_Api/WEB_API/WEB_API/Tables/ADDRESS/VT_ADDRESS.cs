
using static WEB_API.Models.Address.AddressModel;
using Dapper.Contrib.Extensions;

namespace WEB_API.Tables.ADDRESS

{
    
    
        [Table("VT_ADDRESS")]
        public class VT_ADDRESS
        {

            [Key]
            public int LOGICALREF { get; set; } = 0;
            public int ACCOUNTREF { get; set; } = 0;
            public string CITY { get; set; } = string.Empty;
            public string  TOWN { get; set; } = string.Empty;
            public string DISTRICT { get; set; } = string.Empty;
            public string STREET { get; set; } = string.Empty;
            public string FLOOR_FLATNO{ get; set; } = string.Empty;
            public string BUILD_NO { get; set; } = string.Empty;


        }
    
}
