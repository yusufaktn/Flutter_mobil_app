using Dapper;
using Dapper.Contrib.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using MimeKit;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WEB_API.Models.Account;
using WEB_API.Shared;
using MailKit.Net.Smtp;
using System.Net;
using System.Net.Mail;
using SmtpClient = System.Net.Mail.SmtpClient;
using WEB_API.Tables.Account;

namespace WEB_API.Controllers.Account
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountController : Controller
    {
        DbConn dbConn;
        public AccountController()
        {
             dbConn  = new DbConn();
        }

        [HttpGet("login/{MAIL}/{PASSWORD}")]
        public IActionResult Login(string MAIL, string PASSWORD)
        {
            try
            {
                var result = dbConn.conn.QueryFirstOrDefault<AccountModel>($@"SELECT * FROM VT_ACCOUNT WHERE MAIL = '{MAIL}' AND PASSWORD = '{PASSWORD}'");
                if (result != null)
                    return Json(result);
                else
                    return BadRequest("Kullanıcı Bulunamadı");
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
                var result = dbConn.conn.Query<AccountModel>($@"SELECT * FROM VT_ACCOUNT").ToList();
                if (result != null)
                    return Json(result);
                else
                    return BadRequest("Kullanıcılar Bulunamadı");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpPost("register")]
        public IActionResult Register(AccountModel model)
        {
            try
            {
                if (model.LOGICALREF > 0)
                {

                    var result = dbConn.conn.Update<VT_ACCOUNT>(model);
                    if (result)
                        return Json(result);
                    else
                        return BadRequest("Kullanıcı Kaydı Güncellenemedi");
                }
                else
                {
                    var result = dbConn.conn.Insert<VT_ACCOUNT>(model);
                    if (result > 0)
                        return Json(result);
                    else
                        return BadRequest("Kullanıcı Kaydı Güncellenemedi");
                }

            }
              catch (Exception e) {

                string duplicate = e.Message.Contains("duplicate") ? "Bu Maili Kullanan zaten bir hesap var." : e.Message;

                return BadRequest(duplicate);
            }
        }

        





        [HttpPost("send-verification-code/{toEmail}/{subject}/{body}")]
        public ActionResult<string> SendEmailWithAttachment(string toEmail, string subject, string body)
        {
            var code = GenerateVerificationCode();

            try
            {
                string fromEmail = "appFltt@hotmail.com";
                string smtpServer = "smtp-mail.outlook.com";
                string smtpUser = "appFltt@hotmail.com";
                string smtpPassword = "enenemenene123";


                

                MailMessage mail = new MailMessage(fromEmail, toEmail, subject,GenerateHtmlWithCode(code) );
                mail.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient(smtpServer)
                {
                    Port = 587,
                    Credentials = new NetworkCredential(smtpUser, smtpPassword),
                    EnableSsl = true
                };


                smtpClient.Send(mail);
                
                return Ok(code);

            }
            catch (Exception e)
            {
                return e.Message;
            }




        }
        private string GenerateHtmlWithCode(string verificationCode)
        {
            return $@"
    <!DOCTYPE html>
    <html lang=""tr"" xmlns=""http://www.w3.org/1999/xhtml"" xmlns:v=""urn:schemas-microsoft-com:vml"" xmlns:o=""urn:schemas-microsoft-com:office:office"">
    <head>
        <meta charset=""utf-8"">
        <meta name=""viewport"" content=""width=device-width"">
        <meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">
        <meta name=""x-apple-disable-message-reformatting"">
        <title></title>

        <link href=""https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700"" rel=""stylesheet"">

        <style>
            html, body {{
                margin: 0 auto !important;
                padding: 0 !important;
                height: 100% !important;
                width: 100% !important;
                background: #f1f1f1;
            }}
            * {{
                -ms-text-size-adjust: 100%;
                -webkit-text-size-adjust: 100%;
            }}
            div[style*=""margin: 16px 0""] {{
                margin: 0 !important;
            }}
            table, td {{
                mso-table-lspace: 0pt !important;
                mso-table-rspace: 0pt !important;
            }}
            table {{
                border-spacing: 0 !important;
                border-collapse: collapse !important;
                table-layout: fixed !important;
                margin: 0 auto !important;
            }}
            img {{
                -ms-interpolation-mode:bicubic;
            }}
            a {{
                text-decoration: none;
            }}
            *[x-apple-data-detectors], .unstyle-auto-detected-links *, .aBn {{
                border-bottom: 0 !important;
                cursor: default !important;
                color: inherit !important;
                text-decoration: none !important;
                font-size: inherit !important;
                font-family: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
            }}
            .a6S {{
                display: none !important;
                opacity: 0.01 !important;
            }}
            .im {{
                color: inherit !important;
            }}
            img.g-img + div {{
                display: none !important;
            }}
            @media only screen and (min-device-width: 320px) and (max-device-width: 374px) {{
                u ~ div .email-container {{
                    min-width: 320px !important;
                }}
            }}
            @media only screen and (min-device-width: 375px) and (max-device-width: 413px) {{
                u ~ div .email-container {{
                    min-width: 375px !important;
                }}
            }}
            @media only screen and (min-device-width: 414px) {{
                u ~ div .email-container {{
                    min-width: 414px !important;
                }}
            }}

            .primary {{
                background: #17bebb;
            }}
            .bg_white {{
                background: #ffffff;
            }}
            .bg_light {{
                background: #f7fafa;
            }}
            .bg_black {{
                background: #000000;
            }}
            .bg_dark {{
                background: rgba(0,0,0,.8);
            }}
            .email-section {{
                padding:2.5em;
            }}
            .btn {{
                padding: 10px 15px;
                display: inline-block;
            }}
            .btn.btn-primary {{
                border-radius: 5px;
                background: #17bebb;
                color: #ffffff;
            }}
            .btn.btn-white {{
                border-radius: 5px;
                background: #ffffff;
                color: #000000;
            }}
            .btn.btn-white-outline {{
                border-radius: 5px;
                background: transparent;
                border: 1px solid #fff;
                color: #fff;
            }}
            .btn.btn-black-outline {{
                border-radius: 0px;
                background: transparent;
                border: 2px solid #000;
                color: #000;
                font-weight: 700;
            }}
            .btn-custom {{
                color: rgba(0,0,0,.3);
                text-decoration: underline;
            }}
            h1, h2, h3, h4, h5, h6 {{
                font-family: 'Poppins', sans-serif;
                color: #000000;
                margin-top: 0;
                font-weight: 400;
            }}
            body {{
                font-family: 'Poppins', sans-serif;
                font-weight: 400;
                font-size: 15px;
                line-height: 1.8;
                color: rgba(0,0,0,.4);
            }}
            a {{
                color: #36B8EA;
            }}
            .logo h1 {{
                margin: 0;
            }}
            .logo h1 a {{
                color: #36B8EA;
                font-size: 24px;
                font-weight: 700;
                font-family: 'Poppins', sans-serif;
            }}
            .hero {{
                position: relative;
                z-index: 0;
            }}
            .hero .text {{
                color: rgba(0,0,0,.3);
            }}
            .hero .text h2 {{
                color: #000;
                font-size: 34px;
                margin-bottom: 0;
                font-weight: 200;
                line-height: 1.4;
            }}
            .hero .text h3 {{
                font-size: 24px;
                font-weight: 300;
            }}
            .hero .text h2 span {{
                font-weight: 600;
                color: #000;
            }}
            .text-author {{
                border: 1px solid rgba(0,0,0,.05);
                max-width: 50%;
                margin: 0 auto;
                padding: 2em;
            }}
            .text-author img {{
                border-radius: 50%;
                padding-bottom: 20px;
            }}
            .text-author h3 {{
                margin-bottom: 0;
            }}
            ul.social {{
                padding: 0;
            }}
            ul.social li {{
                display: inline-block;
                margin-right: 10px;
            }}
            .footer {{
                border-top: 1px solid rgba(0,0,0,.05);
                color: rgba(0,0,0,.5);
            }}
            .footer .heading {{
                color: #36B8EA;
                font-size: 20px;
            }}
            .footer ul {{
                margin: 0;
                padding: 0;
            }}
            .footer ul li {{
                list-style: none;
                margin-bottom: 10px;
            }}
            .footer ul li a {{
                color: rgba(0,0,0,1);
            }}
            @media screen and (max-width: 500px) {{}}
        </style>
    </head>
    <body width=""100%"" style=""margin: 0; padding: 0 !important; mso-line-height-rule: exactly; background-color: #f1f1f1;"">
        <center style=""width: 100%; background-color: #f1f1f1;"">
        <div style=""display: none; font-size: 1px;max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; mso-hide: all; font-family: sans-serif;"">
            &zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;
        </div>
        <div style=""max-width: 600px; margin: 0 auto;"" class=""email-container"">
            <table align=""center"" role=""presentation"" cellspacing=""0"" cellpadding=""0"" border=""0"" width=""100%"" style=""margin: auto;"">
                <tr>
                <td valign=""top"" class=""bg_white"" style=""padding: 1em 2.5em 0 2.5em;"">
                    <table role=""presentation"" border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"">
                        <tr>
                            <td class=""logo"" style=""text-align: center;"">
                                <h1><a href=""#"">2v Yazılım</a></h1>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
                <tr>
                <td valign=""middle"" class=""hero bg_white"" style=""padding: 2em 0 4em 0;"">
                    <table role=""presentation"" border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"">
                        <tr>
                            <td style=""padding: 0 2.5em; text-align: center; padding-bottom: 3em;"">
                                <div class=""text"">
                                    <h2>Merhaba, İşte doğrulama kodunuz:</h2>
                                    <h1><span>{verificationCode}</span></h1>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style=""text-align: center;"">
                                <div class=""text-author"">
                                    <img src=""C:\Users\myusu\OneDrive\Masaüstü\_2vseffaf.png"" alt="""" style=""width: 100px; max-width: 600px; height: auto; margin: auto; display: block;"">
                                    <h3 class=""name"">2v Yazılım</h3>
                                    
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
                <tr>
                <td valign=""middle"" class=""bg_light footer email-section"">
                    <table>
                        <tr>
                            <td valign=""top"" width=""33.333%"" style=""padding-top: 20px;"">
                                <table role=""presentation"" cellspacing=""0"" cellpadding=""0"" border=""0"" width=""100%"">
                                    <tr>
                                        <td style=""text-align: left; padding-right: 10px;"">
                                            <h3 class=""heading"">Hakkımızda</h3>
                                            <p>Yazılım geliştirme ve teknoloji çözümlerinde öncü bir firmayız.</p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign=""top"" width=""33.333%"" style=""padding-top: 20px;"">
                                <table role=""presentation"" cellspacing=""0"" cellpadding=""0"" border=""0"" width=""100%"">
                                    <tr>
                                        <td style=""text-align: left; padding-left: 5px; padding-right: 5px;"">
                                            <h3 class=""heading"">İletişim</h3>
                                            <ul>
                                                <li><span class=""text"">Adres: Bursa, Türkiye</span></li>
                                                <li><span class=""text"">Telefon: +90 123 456 7890</span></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign=""top"" width=""33.333%"" style=""padding-top: 20px;"">
                                <table role=""presentation"" cellspacing=""0"" cellpadding=""0"" border=""0"" width=""100%"">
                                    <tr>
                                        <td style=""text-align: left; padding-left: 10px;"">
                                            <h3 class=""heading"">Bağlantılar</h3>
                                            <ul>
                                                <li><a href=""#"" class=""text"">Web Sitemiz</a></li>
                                                <li><a href=""#"" class=""text"">Linkedln</a></li>
                                              
                                                <li><a href=""#"" class=""text"">Instagram</a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
            </table>
        </div>
        </center>
    </body>
    </html>
    ";
        }



         
        private string GenerateVerificationCode()
        {
            var random = new Random();
            return random.Next(1000, 9999).ToString();
        }

        private string Codefltt()
        {
            var code = GenerateVerificationCode();
            return code;
        }

        




        /*
        [HttpPost("sendMail/{toEmail}/{subject}/{body}")]
        public async Task SendMail(string toEmail, string subject, string body)
        {
            try
            {
                SmtpClient smtp = new SmtpClient("smtp-mail.outlook.com", 587);
                smtp.EnableSsl = false;
                smtp.Credentials = new NetworkCredential("appFltt@hotmail.com", "enenemenene123");

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("appFltt@hotmail.com", "ev rahat tabii... :))) Fenaaa");
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = html;
                mail.IsBodyHtml = true;
                await smtp.SendMailAsync(mail);
            }
            catch (Exception e)
            {

            }
        }*/


    }



}
