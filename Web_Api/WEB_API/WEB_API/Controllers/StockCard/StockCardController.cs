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
using Newtonsoft.Json;


namespace WEB_API.Controllers.StockCard
{
    [ApiController]
    [Route("api/[controller]")]
    public class StockCardController : Controller
    {
        DbConn dbConn;
        public StockCardController()
        {
            dbConn = new DbConn();
        }



        [HttpGet("get/{LOGICALREF}")]
        public IActionResult Get(int LOGICALREF)
        {
            try
            {
                var result = dbConn.conn.QueryFirstOrDefault<StockCardModel>($@"SELECT * FROM VT_STOCK_CARD WHERE LOGICALREF = {LOGICALREF}");
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


        [HttpGet("")]
        public IActionResult List()
        {
            try
            {
                var result = dbConn.conn.Query<StockCardModel>($@"SELECT * FROM VT_STOCK_CARD").ToList();
                var json = JsonConvert.SerializeObject(result);
                if (result != null)
                   
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
        public IActionResult Add(StockCardModel model)
        {
            try
            {
                if (model.LOGICALREF > 0)
                {
                    
                    var result = dbConn.conn.Update<VT_STOCK_CARD>(model);
                    if (result)
                        return Json(result);
                    else
                        return BadRequest("Ürün Kaydı Güncellenemedi");

                }
                else
                {
                    var result = dbConn.conn.Insert<VT_STOCK_CARD>(model);
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
