using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;

namespace WebSite.Package
{
    using DataInfo = Dictionary<string, object>;
    public partial class Track : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string orderstatus = Request.QueryString["orderstatus"];            
            try
            {
                //显示跟踪进度和日期
                if (orderstatus != null && (new PackageService()).GetPackageByUserId(userId) != null)
                {
                    IPackageCenter pc = YouExService.GetIPackageCenter();
                    IOrderCenter oc = YouExService.GetIOrderCenter();
                    DataInfo package = pc.GetPackage(orderstatus);
                    string strItem = Literal_Track.Text;
                    int show_blue = 0;
                    string orderno = package["OrderNo"].ToString();
                    int Package_Status = Convert.ToInt32(package["Status"]);
                    int Order_Status = Convert.ToInt32(oc.GetOrder(orderno)["PayStatus"]);
                    IList<DataInfo> bills = (new OrderService()).GetBillByOrderNo(orderno);
                    IList<DataInfo> packages = pc.GetPackageByOrderNo(orderno);

                    foreach (DataInfo package_ in packages)
                    {
                        if (Convert.ToInt32(package_["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received) && Convert.ToInt32(package_["Status"]) > Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast))
                        {
                            show_blue = Convert.ToInt32(TRACK_STATUS.Arrived);
                            strItem = strItem.Replace("trackoneHere", package_["StorageTime"].ToString());
                            break;
                        }
                        else
                            show_blue = Convert.ToInt32(TRACK_STATUS.Forcast);
                    }
                    if (Order_Status == 1)
                    {
                        show_blue = Convert.ToInt32(TRACK_STATUS.WaitPay);
                        foreach (DataInfo bill in bills)
                        {
                            strItem = strItem.Replace("tracktwoHere", bill["CreateTime"].ToString());
                        }
                    }
                    if (Order_Status == 2)
                    {
                        show_blue = Convert.ToInt32(TRACK_STATUS.Ready);
                        foreach (DataInfo bill in bills)
                        {
                            strItem = strItem.Replace("trackthreeHere", bill["PayTime"].ToString());
                        }
                    }
                    if (Package_Status == Convert.ToInt32(DataField.PACKAGE_STATUS.Shipping))
                    {
                        show_blue = Convert.ToInt32(TRACK_STATUS.Transport);
                        //strItem = strItem.Replace("trackfourHere", );
                    }
                    if (Package_Status == Convert.ToInt32(DataField.PACKAGE_STATUS.Arrived))
                    {
                        show_blue = Convert.ToInt32(TRACK_STATUS.Finish);
                        //strItem = strItem.Replace("trackfiveHere", );
                    }
                    strItem = strItem.Replace("showblueHere", show_blue.ToString());
                    Literal_Track.Text = strItem;
                }
            }
            catch { Response.Redirect("./MyStock.aspx"); }
        }

        //包裹跟踪状态
        protected enum TRACK_STATUS {
            Forcast = 1,
            Arrived = 2,
            WaitPay = 3,
            Ready = 4,
            Transport = 5,
            Finish = 6
        }
    }
}