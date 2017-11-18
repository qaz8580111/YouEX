using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.Manager
{
    using DataInfo = Dictionary<string, object>;
    public partial class CouponAction : Tool.AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            IList<DataInfo> couponts = (new CommonService()).GetCouponTemplet();
            foreach (DataInfo coupont in couponts)
            {
                DropDownList.Items.Add(new ListItem(coupont["CouponName"].ToString(), coupont["CouponId"].ToString()));
            }
        }
    }
}