using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.Help
{
    public partial class VerifyCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            YouExLib.Common.VerifyCode gen = new YouExLib.Common.VerifyCode();
            gen.BackgroundColor = System.Drawing.Color.FromArgb(0xff, 0xfd, 0xfe);
            gen.Chaos = true;
            gen.FontSize = 13;
            gen.Padding = 7;
            //gen.LineType = 1;
            gen.ChaosLine = true;
            gen.ChaosColor = System.Drawing.Color.FromArgb(0x22, 0x1e, 0x1b);

            gen.Fonts = new string[2] { "Arial", "Arial Rounded MT Bold" };
            gen.Colors = new System.Drawing.Color[] { System.Drawing.Color.FromArgb(0x17, 0x1e, 0x4b), System.Drawing.Color.FromArgb(0x33, 0x51, 0x47), System.Drawing.Color.FromArgb(0x41, 0x55, 0x32), System.Drawing.Color.FromArgb(0x57, 0x40, 0x38), System.Drawing.Color.FromArgb(0x3b, 0x2c, 0x43) };
            string verifyCode = gen.CreateVerifyCode(5, 0);
            Session["VerifyCode"] = verifyCode.ToUpper();
            System.Drawing.Bitmap bitmap = gen.CreateImage(verifyCode, false);
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            bitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            Response.Clear();
            Response.ContentType = "image/Png";
            Response.BinaryWrite(ms.GetBuffer());
            bitmap.Dispose();
            ms.Dispose();
            ms.Close();
            Response.End();
        }
    }
}