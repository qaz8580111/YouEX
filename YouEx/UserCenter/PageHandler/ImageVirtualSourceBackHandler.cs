using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using YouExLib.Service;

namespace WebSite
{
    public class ImageVirtualSourceBackHandler : IHttpHandler
    {
        /// <summary>
        /// 您将需要在网站的 Web.config 文件中配置此处理程序 
        /// 并向 IIS 注册它，然后才能使用它。有关详细信息，
        /// 请参见下面的链接: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            //如果无法为其他请求重用托管处理程序，则返回 false。
            //如果按请求保留某些状态信息，则通常这将为 false。
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            string idback = context.Request.QueryString["idback"];

            //反面
            if (idback != "")
            {
                byte[] input_idcard_back = (new FileService()).LoadFile(Convert.ToInt32(idback));
                MemoryStream ms_back = new MemoryStream(input_idcard_back);
                System.Drawing.Image image_back = System.Drawing.Image.FromStream(ms_back);
                Byte[] imgBytes_Back = ImageToBytes(image_back);
                context.Response.BinaryWrite(imgBytes_Back);
            }
        }

        private byte[] ImageToBytes(System.Drawing.Image image)
        {
            byte[] buffer = null;
            using (MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                buffer = new byte[ms.Length];
                ms.Seek(0, SeekOrigin.Begin);
                ms.Read(buffer, 0, buffer.Length);
            }

            return buffer;
        }

        #endregion
    }
}
