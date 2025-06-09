using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using WEB_API.Models.Account;
using WEB_API.Models.Order;
using WEB_API.Models.StockCard;
using WEB_API.Shared;
using Dapper;
using WEB_API.Models.Favorites;
using Dapper.Contrib.Extensions;
using WEB_API.Tables.Order;
using WEB_API.Tables.Favorites;


namespace WEB_API.Controllers.Favorites
{
    [ApiController]
    [Route("api/[controller]")]
    public class FavoritesController:Controller
    {

        DbConn dbConn;
        public FavoritesController()
        {
            dbConn = new DbConn();
        }


        [HttpGet("{LOGICALREF}")]
        public IActionResult List(int LOGICALREF)
        {
            try
            {
                string query = $@" 
                                SELECT 
		                        FAVORITES_.*,
		                        ''SPLIT,
		                        CARD_.*
		                        FROM 
		                        VT_FAVORITES FAVORITES_ LEFT JOIN VT_STOCK_CARD CARD_  ON FAVORITES_.STOCKCARDREF = CARD_.LOGICALREF
		                        WHERE ACCOUNTREF= {LOGICALREF}";
               

                IDictionary<int, FavoriteModel> datas = new Dictionary<int, FavoriteModel>();

                var result = dbConn.conn.Query<FavoriteModel, StockCardModel,FavoriteModel>(
                sql: query,
                map: (M1, M2) =>
                {
                    FavoriteModel data;
                    if (!datas.TryGetValue(M1.LOGICALREF, out data))
                    {
                        data = M1;

                        datas.Add(data.LOGICALREF, data);
                    }
                    if (M2 != null)
                    {
                        if (!data.StockCard.Any(a => a.LOGICALREF == M2.LOGICALREF) && M2.LOGICALREF > 0)
                            data.StockCard.Add(M2);
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

        [HttpPost("add")]
        public IActionResult Add(FavoriteModel model)
        {
            try
            {
                
                if (model.LOGICALREF > 0)
                {

                    var result = dbConn.conn.Update<VT_FAVORITES>(model);
                    var json = JsonConvert.SerializeObject(result);
                    if (result)
                        return Ok(json);
                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }
                else
                {
                    var result = dbConn.conn.Insert<VT_FAVORITES>(model);
                    var json = JsonConvert.SerializeObject(result);
                    if (result > 0)
                        
                    return Ok(json);
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

       


        [HttpPost("delete/{LOGICALREF}")]
        public IActionResult Delete(int LOGICALREF)
        {
            try
            {
                var result = dbConn.conn.QueryFirstOrDefault<VT_FAVORITES>($@"DELETE FROM VT_FAVORITES WHERE STOCKCARDREF = {LOGICALREF}");
                    
                    var json = JsonConvert.SerializeObject(result);
                    if (result!=null)
                        return Ok(json);
                    else
                        return BadRequest("Ürün Kaydı Silinemedi");

            }
            catch (Exception e)
            {
                string duplicate = e.Message.Contains("duplicate") ? "Tanımlı kayıt." : e.Message;
                
                Console.WriteLine($"Hata: {duplicate}");
                return BadRequest(duplicate);
            }

        }
    }
}
