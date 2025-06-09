using Dapper;
using Dapper.Contrib.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using MimeKit;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WEB_API.Models.StockCard;
using WEB_API.Shared;
using MailKit.Net.Smtp;
using System.Net;
using System.Net.Mail;
using SmtpClient = System.Net.Mail.SmtpClient;
using WEB_API.Tables.StockCard;
using WEB_API.Models.Order;
using WEB_API.Tables.Order;
using WEB_API.Models.Account;
using System.Text.Json.Serialization;
using Newtonsoft.Json;

namespace WEB_API.Controllers.StockCard
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : Controller
    {
        DbConn dbConn;
        public OrderController()
        {
            dbConn = new DbConn();
        }



        [HttpGet("get/{LOGICALREF}")]
        public IActionResult Get(int LOGICALREF)
        {
            try
            {
                var result = dbConn.conn.Query<OrderModel>($@"                          
                                SELECT * FROM VT_ORDER ORDER_
                                LEFT JOIN VT_STOCK_CARD STOCK_ ON STOCK_.LOGICALREF = ORDER_.STOCKCARDREF
                                WHERE ORDER_.LOGICALREF = {LOGICALREF}").ToList();
                if (result != null)
                    return Json(result);
                else
                    return BadRequest("Ürün Bulunamadı");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpGet("{LOGICALREF}")]
        public IActionResult List(int LOGICALREF)
        {
            try
            {
                string query = $@" 
                                SELECT  ORDER_.*,
		                                ''SPLIT,
		                                STOCKCARD_.*,
		                                ''SPLIT,
		                                ACCOUNT_.*,
		                                ''SPLIT,
		                                DETAILS_.*,
                                        STOCKCARD_.NAME STOCK_NAME
                                        FROM VT_ACCOUNT ACCOUNT_
                                        LEFT JOIN VT_ORDER ORDER_ ON ACCOUNT_.LOGICALREF=ORDER_.ACCOUNTREF
                                        LEFT JOIN VT_ORDER_DETAILS DETAILS_ ON  DETAILS_.ORDERREF = ORDER_.LOGICALREF
                                        LEFT JOIN VT_STOCK_CARD STOCKCARD_    ON STOCKCARD_.LOGICALREF = DETAILS_.STOCKCARDREF
                                        WHERE ACCOUNT_.LOGICALREF={LOGICALREF}";

                IDictionary<int, OrderModel> datas = new Dictionary<int, OrderModel>();

                var result = dbConn.conn.Query<OrderModel,StockCardModel,AccountModel, OrderDetailModel, OrderModel>(
                sql: query,
                map: (M1, M2,M3,M4) =>
                {
                    OrderModel data;
                    if (!datas.TryGetValue(M1.LOGICALREF, out data))
                    {
                        data = M1;

                        datas.Add(data.LOGICALREF, data);
                    }
                    if (M2!=null)
                    {
                        if (!data.StockCard.Any(a => a.LOGICALREF == M2.LOGICALREF) && M2.LOGICALREF > 0)
                            data.StockCard.Add(M2);
                    }
                    if (M3!=null)
                    {
                        data.Account = M3;
                    }

                    if (M4 != null)
                    {
                        if (!data.Details.Any(a => a.LOGICALREF == M4.LOGICALREF) && M4.LOGICALREF > 0)
                            data.Details.Add(M4);
                    }

                    return data;
                },
                splitOn: "SPLIT"
            );

                var resultData = datas.Values.ToList();
                var json = JsonConvert.SerializeObject(resultData);
                if (resultData != null)
                    return Ok(json);
                else
                    return BadRequest("Ürünler Bulunamadı");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }



        //ÜRÜN EKLEME

        [HttpPost("add")]
        public IActionResult Add(OrderModel model)
        {
            try
            {
                if (model.LOGICALREF > 0)
                {

                    var result = dbConn.conn.Update<VT_ORDER>(model);
                    if (result)
                        return Json(result);
                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }
                else
                {
                    var result = dbConn.conn.Insert<VT_ORDER>(model);
                    if (result > 0)
                        return Json(model.LOGICALREF);
                        
                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }

            }
            catch (Exception e)
            {

                string duplicate = e.Message.Contains("duplicate") ? "Tanımlı kayıt." : e.Message;

                return BadRequest(duplicate);

            }
        }

        [HttpPost("orderadd")]
        public IActionResult AddDetails(OrderDetailModel model)
        {
            try
            {
                if (model.LOGICALREF > 0)
                {

                    var result = dbConn.conn.Update<VT_ORDER_DETAILS>(model);
                    if (result)
                        return Json(result);
                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }
                else
                {
                    var result = dbConn.conn.Insert<VT_ORDER_DETAILS>(model);
                    if (result > 0)
                        return Json(result);

                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }

            }
            catch (Exception e)
            {

                string duplicate = e.Message.Contains("duplicate") ? "Tanımlı kayıt." : e.Message;

                return BadRequest(duplicate);

            }
        }
    }
}


// Bu yolla her şeyi gösterebilirsin. İki yolu var dapper olmasaydı el ile istediğin alanları yazacaktın. hem sorguya hem şuraya bak
//gibi fakat dapper var gerek yok. Peki ne yaptık ve daha nasıl yapabiliriz. Şöyle bir seçeneğimiz de var biz sadece bir kayıt getirdik ya birden fazla da getirebiliriz.
//Fakat bunun için örneğin bir sipariş olmalı x diye o siparişin kayıtları olmalı x,y,z şu and aöyle değil. şu anda bizim elimizde x,y,z var bunların da sadece bir tane stok kartı var.
//O yüzden data.StockCard.Add(M2) yerine data.StockCard = M2; dedik List<StockCardModel> diye tanımlamadık çünkü StockCardModel diye tanımladık
//Bu yüzden senin yaptığın gibi şunu yapınca kullanamıyosun
//Bu yüüzden model mantığı çok önemli.
//Sen modelinin ana tablosunu kalıtımlıyosun. Alt tablolarını da yine model ile veya ek alanlarını properties ler ile tanımlıyosun tabloyu ellemeden.
//Gelelim kod kısmına modeli tanımladık.
//Modele istediğimiz tabloyu özelliği ekledik
//Bunlardan sonra sorgumuzu yazdık normal bir LeftJoin sorgusu.
//Ardından IDictionary interface inden bir generic yapı oluşturduk.
//Bu sayede istediğimiz verileri içine doldurucaz.
//Daha sonra bu kafanı karıştırmasın. Genel kullanımı bu sql:sql sorgusu map:(M1,M2) Sondaki hariç sayısı kadar yazılır M3 M4 diye gidebilir ne kadar tablo varsa ve parantez içinde denir ki 
//Sorgudaki ilt SPLIT yazan yer M1 olsun hop gidiyoruz ekliyoruz.
//İkinci yazan yer M2 olsun gidiyoruz ekliyoruz.
//Karşımıza muazzam bir model çıkıyor çiçek gibi 
//Bu yöntem çok işine yarıcak knk kral yöntem güzel ama biraz birden kodlar gelince kafam karıştı:) Çok normal knk ama burada senin çaban önemli kodu okuman önemli
//Mantığı anlattım ama denemen lazım gel veri gir 87 gir sonra kodu oku de burda ne yapmış orada SPLIT yazıyo burada da yazıyor napmış bölmüş M1 M2 ne mantığı ne kod oku kendin mantık kur
//Aynı zamanda da ekleme yap sonra silersin mesela account ekle sorguna da modeline de yani her kayda accountmodel de ekle kendin sonra anlıcan nasıl yaptığını zaten  aynen öyle yapcam biraz okuyup denemeler yapmam lazım tam oturması için  birde bunlar haricinde bir şey sorucam    
//şimdi ben flutterda ürünleri isfavorite ise favorilere ekle olarak tutuyorum ama dün ürün çekmek için bunu sql de stockcart a tanımladım doğr bir k yanlış dur u tuşuu çıktı:)uuuu99999:)))))))))
//  basıyor işte kral nolduu  dediğm gibi doğru bir kullanım değil onun için şöyle bir yöntem yapsam nasuul yaparım mesela favorilere eklendiğinde  sql e 1 olarak true düşsün 
//bak gösteriyorum
//Olması gereken bu fakat doğru tabloda değil
//Şimdi bu ürünler herkese açık ürünler ne demiştim bir ürüne ait ötneğin sipariş açılcak sen o tabloya mı kayıt attın kullanıcıyı VT_STOCK_CARD a mı attın yoksa VT_ORDER diye tablo açıp birbirine mi bağladın.
//Sen burada favori yaptığın an herkeste favori olacak
//Çünkü sen listeyi buna göre dolduracaksın
//Fakat senin bu ürünleri herkesten bağımsız tutman lazı aynen kral ondan doğru kuullanım değil dedim işte onu soruyorumü
//O da şöyle nasıl ki kullanıcıya ait siparişler için VT_ORDER yaptıysak kullanıcıya ait favoriler için VT_FAVORITE yaparsın LOGICALREF ACCOUNT_REF STOCK_CARD_REF STATUS alanlarını açarsın kendisi favorilere ekler çıkarır veya hiç o alanı koymazsın STATUS u direkt kaydı silersin favoridden çıkarığı an ekledğinde yine eklersin böyle çözesin işini okeyy
