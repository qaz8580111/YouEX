using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;

namespace WebSite.Ashx
{
    using DataInfo = Dictionary<string, object>;
    public class package : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            int userid = Convert.ToInt32(context.Request.Cookies["YouEx_User"]["UserId"]); 
            int countryid = Convert.ToInt32(context.Request.Form["Cvalue"]);
            int provinceid = Convert.ToInt32(context.Request.Form["Pvalue"]);            
            string depotid = context.Request.QueryString["depotid"];
            string shippingorder = context.Request.QueryString["shippingorder"];
            string auto_writein = context.Request.QueryString["auto_writein"];

            #region 获取省份
            if (countryid > 0)
            {
                IList<DataInfo> provinces = getProvinces(countryid);

                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(provinces));
                context.Response.End();
            }
            #endregion

            #region 获取城市
            if (provinceid > 0)
            {
                IList<DataInfo> cities = getCities(provinceid);

                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(cities));
                context.Response.End();
            }
            #endregion

            #region 判断运单号是否存在
            if (shippingorder != null){
                DataInfo package = (new PackageService()).GetPackageByShippingNo(shippingorder);
                if (package == null)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                else 
                {
                    if ((new PackageService()).GetOrderNo(package["PackageNo"].ToString()) != "")
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("nono");
                        context.Response.End();
                    }else {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("no_"+package["PackageNo"].ToString());
                        context.Response.End();
                    }
                }
            }
            #endregion

            #region 根据仓库id获取转运路线
            if (depotid != null)
            {
                //根据仓库显示不同路线
                IList<DataInfo> roadlines = (new CommonService()).GetShippingList();
                List<DataInfo> roadlines_reverse = new List<DataInfo>();
                foreach (DataInfo roadline in roadlines)
                {
                    if (roadline["FromDepot"].ToString() == depotid)
                    {
                        roadlines_reverse.Add(roadline);
                    }
                }
                roadlines_reverse.Reverse();
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(roadlines_reverse));
                context.Response.End();
            }
            #endregion

            #region 根据包裹运单号自动填充
            if (auto_writein != null)
            {
                DataInfo package = (new PackageService()).GetPackage(auto_writein);
                DataInfo package_info = new DataInfo();
                //包裹的数据
                string str_packagegoods_name = "";
                string str_packagegoods_brand = "";
                string str_packagegoods_price = "";
                string str_packagegoods_count = "";
                string str_packagegoods_buyurl = "";
                string str_package_photo = "";
                string str_package_photoremark = "";
                string str_package_depotid = package["DepotId"].ToString();
                IList<DataInfo> packagegoods = (IList<DataInfo>)package["PackageGoods"];
                foreach (DataInfo packagegood in packagegoods)
                {
                    str_packagegoods_name += packagegood["Name"] + ",";
                    str_packagegoods_brand += packagegood["Brand"] + ",";
                    str_packagegoods_price += packagegood["Price"] + ",";
                    str_packagegoods_count += packagegood["Count"] + ",";
                    str_packagegoods_buyurl += packagegood["BuyUrl"] + ",";
                }
                string str_package_shippingno = package["ShippingNo"].ToString();
                string str_package_image = package["ShippingName"].ToString();
                string str_package_remark = package["Remark"].ToString();
                //拍照服务
                IList<DataInfo> services = (new OrderService()).GetServiceByPackageNo(package["PackageNo"].ToString());
                if (services.Count != 0)
                {
                    str_package_photo = "1";
                    foreach (DataInfo service in services)
                    {
                        str_package_photoremark = service["Request"].ToString();
                    }
                }
                else
                {
                    str_package_photo = "0";
                    str_package_photoremark = "";
                }
                package_info["PackageName"] = SplitLastOneWord(str_packagegoods_name);
                package_info["PackageBrand"] = SplitLastOneWord(str_packagegoods_brand);
                package_info["PackagePrice"] = SplitLastOneWord(str_packagegoods_price);
                package_info["PackageCount"] = SplitLastOneWord(str_packagegoods_count);
                package_info["PackageBuyUrl"] = SplitLastOneWord(str_packagegoods_buyurl);
                package_info["ShippingNo"] = str_package_shippingno;
                package_info["UploadImage"] = str_package_image;
                package_info["Remark"] = str_package_remark;
                package_info["IsPhoto"] = str_package_photo;
                package_info["PhotoRemark"] = str_package_photoremark;
                package_info["DepotId"] = str_package_depotid;
                
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(package_info));
                context.Response.End();
            }
            #endregion
        }
        




        //获取省份地区
        protected IList<DataInfo> getProvinces(int countryid)
        {
            IAreaCenter ac = YouExService.GetIAreaCenter();
            IList<DataInfo> provinces = ac.GetAreaList(countryid);
            return provinces;
        }

        //获取城市地区
        protected IList<DataInfo> getCities(int provinceid)
        {
            IAreaCenter ac = YouExService.GetIAreaCenter();
            IList<DataInfo> cities = ac.GetAreaList(provinceid);
            return cities;
        }

        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&=()]", "");
            return result_transfer;
        }

        //去掉最后一个字符
        protected string SplitLastOneWord(string str_words){
            string str_words_final = str_words.Substring(0,str_words.Length-1);
            return str_words_final;
        }

        //
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}