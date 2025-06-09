using Dapper;
using Dapper.Contrib.Extensions;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using WEB_API.Models.Account;
using WEB_API.Models.Address;
using WEB_API.Models.Favorites;
using WEB_API.Models.Order;
using WEB_API.Shared;
using WEB_API.Tables.ADDRESS;
using WEB_API.Tables.Favorites;

namespace WEB_API.Controllers.Address
{
    [ApiController]
    [Route("api/[controller]")]
    public class AddressController:Controller
    {
        DbConn dbConn;
        public AddressController()
        {
            dbConn = new DbConn();
        }

        [HttpGet("get/{LOGICALREF}")]
        public IActionResult Get(int LOGICALREF)
        {
            try
            {
                var result = dbConn.conn.Query<AddressModel>($@"                          
                               SELECT ADDRESS_.* FROM  VT_ADDRESS ADDRESS_ LEFT JOIN VT_ACCOUNT ACCOUNT_ ON
                               ADDRESS_.ACCOUNTREF=ACCOUNT_.LOGICALREF 
                               WHERE ACCOUNT_.LOGICALREF={LOGICALREF};").ToList();
                var json = JsonConvert.SerializeObject(result);
                if (result != null)
                    return Ok(json);
                else
                    return BadRequest("Adresler Bulunamadı");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpPost("add")]
        public IActionResult Add(AddressModel model)
        {
            try
            {

                if (model.LOGICALREF > 0)
                {

                    var result = dbConn.conn.Update<VT_ADDRESS>(model);
                    var json = JsonConvert.SerializeObject(result);
                    if (result)
                        return Ok(json);
                    else
                        return BadRequest("Address Kaydı Güncellenemedi");

                }
                else
                {
                    var result = dbConn.conn.Insert<VT_ADDRESS>(model);
                    var json = JsonConvert.SerializeObject(result);
                    if (result > 0)

                        return Ok(json);
                    else
                        return BadRequest("Address Kaydı Oluşturulmadı");

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
                var result = dbConn.conn.QueryFirstOrDefault<VT_ADDRESS>($@"DELETE FROM VT_ADDRESS WHERE LOGICALREF ={LOGICALREF}");

                var json = JsonConvert.SerializeObject(result);
                if (result != null)
                    return Ok(json);
                else
                    return BadRequest("Address Kaydı Silinemedi");

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
