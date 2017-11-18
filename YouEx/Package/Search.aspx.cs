using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.Package
{
    using DataInfo = Dictionary<string, object>;
    public partial class Search : System.Web.UI.Page
    {
        string shippingorder = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    Search newWeb = (Search)Context.Handler;
                    string shippingorder = newWeb.ShippingOrder;

                    string strItem = "";
                    IList<DataInfo> tracks = PackageTrack.GetPackageTrack(shippingorder);

                    if (tracks == null && shippingorder == "")
                        Literal_AllTrack.Text = Literal_AllTrack.Text.Replace("isshowHere", "none");
                    if (tracks == null)
                        Literal_AllTrack.Text = Literal_AllTrack.Text.Replace("isshowHere", "no");

                    foreach (DataInfo track in tracks)
                    {
                        string track_strItem = Literal_AllTrack.Text;
                        track_strItem = track_strItem.Replace("tracktimeHere", Convert.ToDateTime(track["TrackTime"]).ToString());
                        track_strItem = track_strItem.Replace("messageHere", track["Message"].ToString());
                        track_strItem = track_strItem.Replace("isshowHere", "yes");
                        strItem += track_strItem;
                    }
                    Literal_AllTrack.Text = strItem;//strack_strItem = track_strItem.Replace("message")
                }
            }
            catch { }
        }

        protected void searchClick(object sender, EventArgs e)
        {
            shippingorder = Request.Form["search_shippingorder"];
            Server.Transfer("./Search.aspx");
        }
        
        public string ShippingOrder { get { return shippingorder; } }
    }
}