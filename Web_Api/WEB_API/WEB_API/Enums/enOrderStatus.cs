using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace WEB_API.Enums
{
    public enum enOrderStatus :byte
    {
        [Display(Name =" Sipariş Oluşturuldu")]
        Created=0,
        [Display(Name = "İşleme Alındı")]
        Finish =1,
        [Display(Name = "Sipariş Yolda")]
        OnTheWay = 2,
        [Display(Name = "Sipariş Tamamlandı")]
        Completed = 3
    }
}
