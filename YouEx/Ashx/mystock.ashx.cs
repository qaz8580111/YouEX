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
    public class mystock : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            #region 参数列表
            int userid = Convert.ToInt32(context.Request.Cookies["YouEx_User"]["UserId"]); 
            string delete_no = context.Request.Form["delete_no"];
            string delete_delivno = context.Request.Form["delete_delivno"];
            string pay_bill = context.Request.QueryString["pay_bill"];
            string cancel_action = context.Request.QueryString["cancel_action"];
            string refund_package = context.Request.QueryString["refund_package"];
            string show_add_split_package = context.Request.QueryString["show_add_split_package"];
            string edit_package_action = context.Request.QueryString["edit_package_action"];
            string edit_delivery_action = context.Request.QueryString["edit_delivery_action"];
            #endregion


            #region 删除运单
            if (delete_delivno != null)
            {
                IList<DataInfo> packages = (new PackageService()).GetPackageByOrderNo(delete_delivno);
                foreach (DataInfo package in packages)
                {
                    if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                    {
                        (new PackageService()).DeletePackage(package["PackageNo"].ToString());                        
                    }
                    if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received)) 
                    {
                        if (Convert.ToInt32(package["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.Storage))
                        {
                            package["OrderNo"] = "";
                            (new PackageService()).UpdatePackage(package["PackageNo"].ToString(), package);
                        }
                        else
                        {
                            (new PackageService()).DeletePackage(package["PackageNo"].ToString());
                        }
                    }
                    
                }
                    
                context.Response.ContentType = "text/plain";
                context.Response.Write("yes");
                context.Response.End();
            }
            #endregion

            #region 判断是否需要付款
            if (pay_bill != null) {
                DataInfo order = (new OrderService()).GetOrder(pay_bill);
                if (Convert.ToInt32(order["PayStatus"]) == 1 && Convert.ToInt32(order["AutoPay"]) == 0)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                if (Convert.ToInt32(order["PayStatus"]) == 1 && Convert.ToInt32(order["AutoPay"]) == 1)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("no");
                    context.Response.End();
                }
                if (Convert.ToInt32(order["PayStatus"]) == 2)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("nono");
                    context.Response.End();
                }                
            }
            #endregion

            #region 取消分箱合箱操作
            if (cancel_action != null) {
                IList<DataInfo> packages = (new PackageService()).GetPackageByOrderNo(cancel_action);
                DataInfo order = (new OrderService()).GetOrder(cancel_action);
                int addpackagecount = Convert.ToInt32(order["PackageCount"]);
                int explainpackagecount = Convert.ToInt32(order["DeliveryCount"].ToString());
                //取消分合箱
                if ((addpackagecount == 1 && explainpackagecount > 1) || (addpackagecount > 1 && explainpackagecount >= 1))
                {
                    foreach (DataInfo package in packages)
                    {
                        if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received)) 
                        {
                            package["OrderNo"] = "";
                            (new PackageService()).UpdatePackage(package["PackageNo"].ToString(), package);
                        }
                        if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                        {
                            (new PackageService()).DeletePackage(package["PackageNo"].ToString());
                        }
                    }
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                
                
            }
            #endregion

            #region 申请退货
            if (refund_package != null)
            {
                IOrderService os = YouExService.GetIOrderService();
                IPackageCenter pc = YouExService.GetIPackageCenter();
                int depotid = Convert.ToInt32(pc.GetPackage(refund_package)["DepotId"]);
                
                DataInfo added = new DataInfo();
                added["UserId"] = userid;
                added["DepotId"] = depotid;
                added["PackageNo"] = refund_package;
                added["AccessStatus"] = 0;
                added["PayStatus"] = 0;
                added["ServiceCode"] = "Return";
                added["Request"] = "包裹退货";
                added["CreateTime"] = System.DateTime.UtcNow.ToString();
                
                DataInfo refundinfo = new DataInfo();
                refundinfo["OrderNo"] = (new PackageService()).GetOrderNo(refund_package);
                refundinfo["Recipients"] = getTransferString(context.Request.Form["refund_recipients"]);
                refundinfo["Phone"] = getTransferString(context.Request.Form["refund_mobile"]);
                refundinfo["Address1"] = getTransferString(context.Request.Form["refund_addressone"]);
                refundinfo["Address2"] = getTransferString(context.Request.Form["refund_addresstwo"]);
                refundinfo["State"] = getTransferString(context.Request.Form["refund_province"]);
                refundinfo["ZipCode"] = getTransferString(context.Request.Form["refund_zipcode"]);
                refundinfo["ShippingPrice"] = getTransferString(context.Request.Form["refund_price"]);
                refundinfo["Email"] = getTransferString(context.Request.Form["refund_email"]);
                string serviceno = os.CreateService(depotid, added, refundinfo);

                //修改包裹的状态
                DataInfo old_package = pc.GetPackage(refund_package);
                old_package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.ApplyReturn);
                bool result_package_status = pc.UpdatePackage(refund_package, old_package);

                

                if (serviceno != null && result_package_status)
                {
                    //记录申请退货日志
                    DataInfo packagelog = new DataInfo();
                    packagelog["UserId"] = userid;
                    packagelog["PackageNo"] = refund_package;
                    packagelog["CreateTime"] = System.DateTime.UtcNow.ToString();
                    packagelog["Message"] = "用户申请退货";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), refund_package, DataField.PACKAGE_ACTION.ApplyReturn.ToString(), packagelog);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                
            }
            #endregion

            #region 包裹弃货
            if (delete_no != null)
            {
                IPackageCenter pc = YouExService.GetIPackageCenter();
                DataInfo package = pc.GetPackage(delete_no);
                package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.ApplyAbort);
                bool result_delete = pc.UpdatePackage(delete_no, package);
                if (result_delete)
                {
                    //记录申请弃货日志
                    DataInfo packagelog = new DataInfo();
                    packagelog["UserId"] = userid;
                    packagelog["PackageNo"] = delete_no;
                    packagelog["CreateTime"] = System.DateTime.UtcNow.ToString();
                    packagelog["Message"] = "用户申请弃货";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), delete_no, DataField.PACKAGE_ACTION.ApplyAbort.ToString(), packagelog);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
            }
            #endregion

            #region 前台显示运单的形式
            if (show_add_split_package != null) {
                try
                {
                    string orderno = (new PackageService()).GetOrderNo(show_add_split_package);
                    string addpackagecount = (new OrderService()).GetOrder(orderno)["PackageCount"].ToString();
                    string explainpackagecount = (new OrderService()).GetOrder(orderno)["DeliveryCount"].ToString();

                    //运单分箱
                    if (explainpackagecount != "" && Convert.ToInt32(explainpackagecount) > 1)
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("yes");
                        context.Response.End();
                    }

                    //运单合箱
                    if (addpackagecount != "" && Convert.ToInt32(addpackagecount) > 1)
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("no");
                        context.Response.End();
                    }
                }
                catch { }
            }
            #endregion

            #region 修改新运单页的包裹
            if (edit_package_action != null)
            {
                DataInfo package = (new PackageService()).GetPackage(edit_package_action);
                DataInfo package_info = new DataInfo();
                //包裹的数据
                string str_packagegoods_name = "";
                string str_packagegoods_brand = "";
                string str_packagegoods_price = "";
                string str_packagegoods_count = "";
                string str_packagegoods_buyurl = "";
                string str_packagegoods_length = "";
                string str_package_shippingno = "";
                string str_package_photo = "";
                string str_package_photoremark = "";
                string str_package_image = "";
                string str_package_remark = "";
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
                str_packagegoods_length += packagegoods.Count + ",";
                str_package_shippingno += package["ShippingNo"] + ",";
                str_package_image += package["ShippingName"] + ",";
                str_package_remark += package["Remark"] + "|";
                //拍照服务
                IList<DataInfo> services = (new OrderService()).GetServiceByPackageNo(package["PackageNo"].ToString());
                if (services.Count != 0)
                {
                    str_package_photo += "1" + ",";
                    foreach (DataInfo service in services)
                    {
                        str_package_photoremark += service["Request"] + ",";
                    }
                }
                else
                {
                    str_package_photo += "0" + ",";
                    str_package_photoremark += ",";
                }
                package_info["PackageName"] = SplitLastOneWord(str_packagegoods_name);
                package_info["PackageBrand"] = SplitLastOneWord(str_packagegoods_brand);
                package_info["PackagePrice"] = SplitLastOneWord(str_packagegoods_price);
                package_info["PackageCount"] = SplitLastOneWord(str_packagegoods_count);
                package_info["PackageBuyUrl"] = SplitLastOneWord(str_packagegoods_buyurl);
                package_info["PackageGoodsCount"] = SplitLastOneWord(str_packagegoods_length);
                package_info["ShippingNo"] = SplitLastOneWord(str_package_shippingno);
                package_info["UploadImage"] = SplitLastOneWord(str_package_image);
                package_info["Remark"] = SplitLastOneWord(str_package_remark);
                package_info["IsPhoto"] = SplitLastOneWord(str_package_photo);
                package_info["PhotoRemark"] = SplitLastOneWord(str_package_photoremark);
                package_info["DepotId"] = str_package_depotid;
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(package_info));
                context.Response.End();
            }
            #endregion

            #region 修改新运单页的运单
            if (edit_delivery_action != null)
            {
                //根据订单取出所有符合的包裹和运单
                IList<DataInfo> packages = (new PackageService()).GetPackageByOrderNo(edit_delivery_action);
                DataInfo order = (new OrderService()).GetOrder(edit_delivery_action);
                DataInfo package_info = new DataInfo();
                //包裹的数据
                string str_packagegoods_name = "";
                string str_packagegoods_brand = "";
                string str_packagegoods_price = "";
                string str_packagegoods_count = "";
                string str_packagegoods_buyurl = "";
                string str_packagegoods_length = "";
                string str_package_shippingno = "";
                string str_package_photo = "";
                string str_package_photoremark = "";
                string str_package_image = "";
                string str_package_remark = "";
                string str_package_depotid = order["DepotId"].ToString();
                //运单的数据
                string str_deliverygoods_name = "";
                string str_deliverygoods_brand = "";
                string str_deliverygoods_price = "";
                string str_deliverygoods_count = "";
                string str_deliverygoods_buyurl = "";
                string str_deliverygoods_length = "";
                string str_delivery_roadline = "";
                string str_delivery_address = "";
                string str_delivery_reinforce = "";
                string str_delivery_reinforceremark = "";
                string str_delivery_noticeinfo = "";
                string str_delivery_otherservice = order["Insurance"] + "," + order["Invoice"] + "," + order["AutoPay"];                
                foreach (DataInfo package in packages)
                {                    
                    if(Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received))
                    {
                        IList<DataInfo> packagegoods = (IList<DataInfo>)package["PackageGoods"];
                        foreach(DataInfo packagegood in packagegoods)
                        {
                            str_packagegoods_name += packagegood["Name"]+",";
                            str_packagegoods_brand += packagegood["Brand"] + ",";
                            str_packagegoods_price += packagegood["Price"] + ",";
                            str_packagegoods_count += packagegood["Count"] + ",";
                            str_packagegoods_buyurl += packagegood["BuyUrl"] + ",";
                        }
                        str_packagegoods_length += packagegoods.Count+",";
                        str_package_shippingno += package["ShippingNo"] + ",";
                        str_package_image += package["ShippingName"] + ",";
                        str_package_remark += package["Remark"] + "|";
                        //拍照服务
                        IList<DataInfo> services = (new OrderService()).GetServiceByPackageNo(package["PackageNo"].ToString());
                        if (services.Count != 0)
                        {
                            str_package_photo += "1" + ",";
                            foreach (DataInfo service in services)
                            {
                                str_package_photoremark += service["Request"]+",";                            
                            }
                        }
                        else
                        {
                            str_package_photo += "0" + ",";
                            str_package_photoremark += ",";
                        }                        
                    }
                    if(Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                    {
                        IList<DataInfo> deliverygoods = (IList<DataInfo>)package["PackageGoods"];
                        foreach (DataInfo deliverygood in deliverygoods)
                        {
                            str_deliverygoods_name += deliverygood["Name"] + ",";
                            str_deliverygoods_brand += deliverygood["Brand"] + ",";
                            str_deliverygoods_price += deliverygood["Price"] + ",";
                            str_deliverygoods_count += deliverygood["Count"] + ",";
                            str_deliverygoods_buyurl += deliverygood["BuyUrl"] + ",";
                        }
                        str_deliverygoods_length += deliverygoods.Count + ",";
                        str_delivery_roadline += package["ShippingId"] + ",";
                        str_delivery_address += ((DataInfo)package["PackageAddress"])["Name"]+",";
                        str_delivery_noticeinfo += package["NotifyInfo"] + ",";                        
                        //加固服务
                        IList<DataInfo> services = (new OrderService()).GetServiceByPackageNo(package["PackageNo"].ToString());
                        if (services.Count != 0)
                        {
                            str_delivery_reinforce += "1" + ",";
                            foreach (DataInfo service in services)
                            {
                                str_delivery_reinforceremark += service["Request"] + ",";
                            }
                        }
                        else
                        {
                            str_delivery_reinforce += "0" + ",";
                            str_delivery_reinforceremark += ",";
                        }                        
                    }
                }
                package_info["PackageName"] = SplitLastOneWord(str_packagegoods_name);
                package_info["PackageBrand"] = SplitLastOneWord(str_packagegoods_brand);
                package_info["PackagePrice"] = SplitLastOneWord(str_packagegoods_price);
                package_info["PackageCount"] = SplitLastOneWord(str_packagegoods_count);
                package_info["PackageBuyUrl"] = SplitLastOneWord(str_packagegoods_buyurl);
                package_info["PackageGoodsCount"] = SplitLastOneWord(str_packagegoods_length);
                package_info["ShippingNo"] = SplitLastOneWord(str_package_shippingno);
                package_info["UploadImage"] = SplitLastOneWord(str_package_image);
                package_info["Remark"] = SplitLastOneWord(str_package_remark);
                package_info["IsPhoto"] = SplitLastOneWord(str_package_photo);
                package_info["PhotoRemark"] = SplitLastOneWord(str_package_photoremark);
                package_info["DepotId"] = str_package_depotid;

                package_info["DeliveryName"] = SplitLastOneWord(str_deliverygoods_name);
                package_info["DeliveryBrand"] = SplitLastOneWord(str_deliverygoods_brand);
                package_info["DeliveryPrice"] = SplitLastOneWord(str_deliverygoods_price);
                package_info["DeliveryCount"] = SplitLastOneWord(str_deliverygoods_count);
                package_info["DeliveryBuyUrl"] = SplitLastOneWord(str_deliverygoods_buyurl);
                package_info["DeliveryGoodsCount"] = SplitLastOneWord(str_deliverygoods_length);
                package_info["RoadLine"] = SplitLastOneWord(str_delivery_roadline);
                package_info["Address"] = SplitLastOneWord(str_delivery_address);
                package_info["NoticeInfo"] = SplitLastOneWord(str_delivery_noticeinfo);
                package_info["IsReinforce"] = SplitLastOneWord(str_delivery_reinforce);
                package_info["ReinforceRemark"] = SplitLastOneWord(str_delivery_reinforceremark);
                package_info["OtherService"] = str_delivery_otherservice;

                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(package_info));
                context.Response.End();
            }
            #endregion

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

        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
        }






        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}