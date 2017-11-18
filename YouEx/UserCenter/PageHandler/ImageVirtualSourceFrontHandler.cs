using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using YouExLib.Service;

namespace WebSite
{
    public class ImageVirtualSourceFrontHandler : IHttpHandler
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
            /*string idcard = context.Request.QueryString["idcard"];
            int idfront = Convert.ToInt32(idcard.Split(',')[0]);
            int idback = Convert.ToInt32(idcard.Split(',')[1]);*/
            string idfront = context.Request.QueryString["idfront"];            


            //正面
            if (idfront != "")
            {
                try
                {
                    byte[] input_idcard_front = (new FileService()).LoadFile(Convert.ToInt32(idfront));
                    MemoryStream ms_front = new MemoryStream(input_idcard_front);
                    System.Drawing.Image image_front = System.Drawing.Image.FromStream(ms_front);
                    Byte[] imgBytes_Front = ImageToBytes(image_front);
                    context.Response.BinaryWrite(imgBytes_Front);
                }
                catch { }
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
