using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using System.Threading;

namespace WebSite.Package
{
    using DataInfo = Dictionary<string, object>;
    public partial class MyStock : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ordertype = Request.QueryString["ordertype"];
                        
            #region 判断ordertype
            string isordertype = Literal_OrderType.Text;
            isordertype = isordertype.Replace("ordertypeHere",ordertype);
            Literal_OrderType.Text = isordertype;
            #endregion

            if (ordertype == null)
            {
                #region 取出全部符合的包裹和商品
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IList<DataInfo> packages = pc.GetPackageByUserId(userId);
                string strPacks = "";
                foreach (DataInfo packageItem in packages)
                {
                    if (Convert.ToInt32(packageItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received) && Convert.ToInt32(packageItem["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.Storage))
                    {
                        string strPacksItem = Literal_Package.Text;
                        strPacks += getPackageInfoAndGoods(packageItem,strPacksItem);
                    }
                    if (Convert.ToInt32(packageItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received) && (Convert.ToInt32(packageItem["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.ApplyReturn)
                        || Convert.ToInt32(packageItem["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.ApplyAbort)))
                    {
                        string strPacksItem = Literal_Package.Text;
                        strPacks += getDeletePackageInfo(packageItem, strPacksItem);
                    }
                }
                Literal_Package.Text = strPacks;
                #endregion  
            }

            if (ordertype == "delivery_waiting")
            {
                #region 取出处理中全部符合的运单和商品
                ordertype = getTransferString(ordertype);
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IList<DataInfo> deliverys = pc.GetPackageByUserId(userId);                
                string strDelivs = "";
                string isdeliveryorder = "";
                foreach (DataInfo deliveryItem in deliverys)
                {
                    
                    if (Convert.ToInt32(deliveryItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send) && Convert.ToInt32(deliveryItem["Status"]) < Convert.ToInt32(DataField.PACKAGE_STATUS.Shipping))
                    {
                        if (isdeliveryorder == deliveryItem["OrderNo"].ToString())
                            continue;
                        isdeliveryorder = deliveryItem["OrderNo"].ToString();

                        int order_status = getOrderStatusByDelivery(deliveryItem);
                        if (order_status == 0)
                        {
                            IOrderCenter oc = YouExService.GetIOrderCenter();
                            string strDelivsItem = Literal_Delivery_Waiting.Text;
                            strDelivs += getWaitingDeliveryInfo(deliveryItem, strDelivsItem);
                        }
                    }
                }
                Literal_Delivery_Waiting.Text = strDelivs;
                #endregion
            }

            if (ordertype == "delivery_paybill")
            {
                #region 取出待支付全部符合的运单和商品
                ordertype = getTransferString(ordertype);
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IPackageGoods pg = YouExService.GetIPackageGoods();
                IList<DataInfo> deliverys = pc.GetPackageByUserId(userId);
                string strDelivs = "";
                string prev_delivery = "" ;
                foreach (DataInfo deliveryItem in deliverys)
                {
                    if (Convert.ToInt32(deliveryItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send) && Convert.ToInt32(deliveryItem["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.Ready))
                    {
                        try
                        {
                            int order_status = getOrderStatusByDelivery(deliveryItem);
                            if (order_status == 1)
                            {
                                if(deliveryItem["OrderNo"].ToString() != prev_delivery){
                                    prev_delivery = deliveryItem["OrderNo"].ToString();
                                    string strDelivsItem = Literal_Delivery_PayBill.Text;
                                    strDelivs += getPayBillDeliveryInfo(deliveryItem, strDelivsItem);
                                }
                            }
                        }
                        catch { Response.Write("<script>alert('不能成功获取发出的运单，请联系客服');</script>"); }
                    }
                }
                Literal_Delivery_PayBill.Text = strDelivs;
                #endregion
            }

            if (ordertype == "delivery_transport")
            {
                #region 取出运输中全部符合的运单和商品
                ordertype = getTransferString(ordertype);
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IPackageGoods pg = YouExService.GetIPackageGoods();
                IList<DataInfo> deliverys = pc.GetPackageByUserId(userId);
                string strDelivs = "";
                foreach (DataInfo deliveryItem in deliverys)
                {
                    if (Convert.ToInt32(deliveryItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send) && Convert.ToInt32(deliveryItem["Status"]) <= Convert.ToInt32(DataField.PACKAGE_STATUS.Shipping))
                    {
                        try
                        {
                            int order_status = getOrderStatusByDelivery(deliveryItem);
                            if (order_status == 2)
                            {
                                string strDelivsItem = Literal_Delivery_Transport.Text;
                                strDelivs += getTransportDeliveryInfo(deliveryItem, strDelivsItem);
                            }
                        }
                        catch { Response.Write("<script>alert('不能成功获取发出的运单，请联系客服');</script>"); }
                    }
                }
                Literal_Delivery_Transport.Text = strDelivs;
                #endregion
            }

            if (ordertype == "delivery_finished")
            {
                #region 取出已完成全部符合的运单和商品
                ordertype = getTransferString(ordertype);
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IPackageGoods pg = YouExService.GetIPackageGoods();
                IList<DataInfo> deliverys = pc.GetPackageByUserId(userId);
                string strDelivs = "";
                foreach (DataInfo deliveryItem in deliverys)
                {
                    if (Convert.ToInt32(deliveryItem["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send) && Convert.ToInt32(deliveryItem["Status"]) == Convert.ToInt32(DataField.PACKAGE_STATUS.Arrived))
                    {
                        try
                        {
                            string strDelivsItem = Literal_Delivery_Finished.Text;
                            strDelivs += getFinishedDeliveryInfo(deliveryItem,strDelivsItem);
                        }
                        catch { Response.Write("<script>alert('不能成功获取发出的运单，请联系客服');</script>"); }
                    } 
                }
                Literal_Delivery_Finished.Text = strDelivs;
                #endregion
            }
        }


        //根据包裹NO取商品信息
        protected IList<DataInfo> getPackageGoods(string packageno)
        {
            IPackageGoods good = YouExService.GetIPackageGoods();
            IList<DataInfo> goodlist = good.GetPackageGoodsList(packageno);
            return goodlist;
        }

        //根据用户id获取所有地址信息并返回字符串
        protected string getAddresses(int userid) {
            IUserAddress ua = YouExService.GetIUserAddress();
            IList<DataInfo> addresses = ua.GetAddressList(userid);
            IAreaCenter ac = YouExService.GetIAreaCenter();
            string address_str = "";
            string addressname = "0";
            foreach (DataInfo address in addresses)
            {
                addressname = address["Name"].ToString();
                address_str += "<option value='" + addressname + "'>" +
                            "(" + address["Name"].ToString() + ")" +
                            ac.GetAreaInfo(Convert.ToInt32(address["Country"]))["Name"].ToString() + " " +
                            ac.GetAreaInfo(Convert.ToInt32(address["Province"]))["Name"].ToString() + " " +
                            ac.GetAreaInfo(Convert.ToInt32(address["City"]))["Name"].ToString() + "</option>";
            }
            return address_str;
        }

        //根据orderno获取shippingno
        protected string getShippingNoByOrderNo(string orderno) {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            IList<DataInfo> packages = pc.GetPackageByOrderNo(orderno);
            string shippingno = null ;
            foreach (DataInfo package in packages) {
                if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received))
                {
                    shippingno = package["ShippingNo"].ToString();
                }
            }
            return shippingno;
        }

        //取出运单商品信息
        protected string getDeliveryGoodsInfo(IList<DataInfo> delivgoods,string deliveryno) {
            string strDelivGoods = "";
            foreach (DataInfo delivgoodsItem in delivgoods)
            {
                strDelivGoods += "<div class='t3-content'>" +
               "<div class='s1'><input type='text' name='good_name_" + deliveryno + "' value=" + delivgoodsItem["Name"].ToString() + " /></div>" +
               "<div class='s2'><input type='text' name='good_brand_" + deliveryno + "' value=" + delivgoodsItem["Brand"].ToString() + " /></div>" +
               "<div class='s3'><input type='text' name='good_price_" + deliveryno + "' value=" + delivgoodsItem["Price"].ToString() + " /></div>" +
               "<div class='s6'><span>（￥）</span></div>" +
               "<div class='s4'><input type='text' name='good_amount_" + deliveryno + "' value=" + delivgoodsItem["Count"].ToString() + " /></div>" +
               "<div class='s5'><input type='text' name='good_buyurl_" + deliveryno + "' value=" + delivgoodsItem["BuyUrl"].ToString() + " /></div>" +
               "<div class='s7'><input class='data_button' type='button' onclick='delTr_addPac(this);' value='删除' /></div></div>";
            }
            return strDelivGoods;
        }

        //取出运单克隆商品信息
        protected string getDeliveryCloneGoodsInfo(IList<DataInfo> delivgoods, string deliveryno)
        {
            string strDelivGoods = "";
            foreach (DataInfo beforegoodsItem in delivgoods)
            {
                strDelivGoods += "<div class='last-div'></div><div class='data_content'>" +
               "<div class='search_name'><input class='data_name' type='text' name='clone_name_" + deliveryno + "' disabled='disabled' value=" + beforegoodsItem["Name"].ToString() + " onkeyup='flush_name_value(this);' /></div>" +
               "<input class='data_brand' type='text' name='clone_brand_" + deliveryno + "' disabled='disabled' value=" + beforegoodsItem["Brand"].ToString() + " />" +
               "<input class='data_price' type='text' name='clone_price_" + deliveryno + "' disabled='disabled' value=" + beforegoodsItem["Price"].ToString() + " />" +
               "<input class='data_amount' type='text' name='clone_amount_" + deliveryno + "' disabled='disabled' value=" + beforegoodsItem["Count"].ToString() + " />" +
               "<input class='data_buyurl' type='text' name='clone_buyurl_" + deliveryno + "' disabled='disabled' value=" + beforegoodsItem["BuyUrl"].ToString() + " />" +
               "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>";
            }
            return strDelivGoods;
        }

        //取出运单克隆后商品信息
        protected string getDeliveryCloneGoodsInfo_After(IList<DataInfo> delivgoods, string deliveryno)
        {
            string strDelivGoods = "";
            foreach (DataInfo beforegoodsItem in delivgoods)
            {
                strDelivGoods += "<div class='last-div'></div><div class='data_content'>" +
               "<div class='search_name'><input class='data_name' type='text' name='delivery_name_" + deliveryno + "' value=" + beforegoodsItem["Name"].ToString() + " onkeyup='flush_name_value(this);' /></div>" +
               "<input class='data_brand' type='text' name='delivery_brand_" + deliveryno + "' value=" + beforegoodsItem["Brand"].ToString() + " />" +
               "<input class='data_price' type='text' name='delivery_price_" + deliveryno + "' value=" + beforegoodsItem["Price"].ToString() + " />" +
               "<input class='data_count' type='text' name='delivery_count_" + deliveryno + "' value=" + beforegoodsItem["Count"].ToString() + " />" +
               "<input class='data_buyurl' type='text' name='delivery_buyurl_" + deliveryno + "' value=" + beforegoodsItem["BuyUrl"].ToString() + " />" +
               "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>";
            }
            return strDelivGoods;
        }

        //通过运单获取订单支付状态
        protected int getOrderStatusByDelivery(DataInfo delivery) {
            IOrderCenter oc = YouExService.GetIOrderCenter();
            DataInfo order = oc.GetOrder(delivery["OrderNo"].ToString());
            int order_status = Convert.ToInt32(order["PayStatus"]);
            return order_status;
        }

        //运输路线转换文字
        protected string getRoadLineWord(int roadlineid) {
            string roadline_word = "";
            IList<DataInfo> roadlines = (new CommonService()).GetShippingList(roadlineid);
            foreach (DataInfo roadline in roadlines) {
                roadline_word = roadline["ShippingName"].ToString();
            }
            return roadline_word;
        }

        //获取分箱后多个路线
        protected string getMultiRoadLines(DataInfo order) 
        {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            IList<DataInfo> packages = pc.GetPackageByOrderNo(order["OrderNo"].ToString());
            string roadlines = "";
            foreach (DataInfo package in packages) {
                if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                {
                    roadlines += package["ShippingId"].ToString() + ",";
                }
            }
            return roadlines;
        }

        //获取分箱后多个地址
        protected string getMultiAddresses(DataInfo order)
        {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            IList<DataInfo> packages = pc.GetPackageByOrderNo(order["OrderNo"].ToString());
            string addresses = "";
            IPackageAddress pa = YouExService.GetIPackageAddress();
            foreach (DataInfo package in packages)
            {
                if (Convert.ToInt32(package["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                {
                    addresses += pa.GetPackageAddress(package["PackageNo"].ToString())["Name"].ToString() + ",";
                }
            }
            return addresses;
        }

        //根据仓库获取所有的路线并返回字符串
        protected string GetShipping(int depotid)
        {
            IList<DataInfo> roadlines = (new CommonService()).GetShippingList();            
            string str = "";
            foreach (DataInfo roadline in roadlines)
            {
                if(Convert.ToInt32(roadline["FromDepot"]) == depotid)
                    str += "<option value='" + roadline["ShippingId"].ToString() + "'>" +roadline["ShippingName"].ToString() + "</option>";
            }
            return str;
        }

        //判断该运单是否已分箱
        protected int isExplainDelivery(string deliveryno)
        {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            DataInfo delivery = pc.GetPackage(deliveryno);
            string orderno = delivery["OrderNo"].ToString();
            int deliverycount = pc.GetPackageByOrderNo(orderno).Count;
            return deliverycount;
        }

        //判断该运单是否已合箱
        protected int isAddDelivery(string deliveryno)
        {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            IOrderCenter oc = YouExService.GetIOrderCenter();
            DataInfo delivery = pc.GetPackage(deliveryno);
            string orderno = delivery["OrderNo"].ToString();
            string deliverycount_str = oc.GetOrder(orderno)["PackageCount"].ToString();
            if (deliverycount_str == "")
                return 0;
            else
            {
                int deliverycount = Convert.ToInt32(deliverycount_str);
                return deliverycount;
            }
        }

        //转换时间
        public static string GetXmlDateTime(string sDate = "")
        {
            DateTime dDate;
            if (sDate == "")
                dDate = DateTime.Now;
            else
                dDate = Convert.ToDateTime(sDate);

            return dDate.ToUniversalTime().ToString("s") + "Z";
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&=()]", "");
            return result_transfer;
        }

        //库存包裹和商品的前台展示
        protected string getPackageInfoAndGoods(DataInfo packageItem, string strPacksItem)
        {
            try
            {
                IPackageCenter pc = YouExService.GetIPackageCenter();
                string packageno = packageItem["PackageNo"].ToString();                
                string address_str = getAddresses(userId);
                string roadline_str = GetShipping(Convert.ToInt32(packageItem["DepotId"]));
                DataInfo order = (new OrderService()).GetOrder(packageItem["OrderNo"].ToString());

                strPacksItem = strPacksItem.Replace("createtimeHere", Convert.ToDateTime(packageItem["CreateTime"]).ToString());
                strPacksItem = strPacksItem.Replace("storagetimeHere", packageItem["StorageTime"].ToString());
                strPacksItem = strPacksItem.Replace("statusHere", packageItem["Status"].ToString());
                strPacksItem = strPacksItem.Replace("shippingnoHere", packageItem["ShippingNo"].ToString());
                strPacksItem = strPacksItem.Replace("addressHere", address_str);
                strPacksItem = strPacksItem.Replace("shippingHere", roadline_str); 
                strPacksItem = strPacksItem.Replace("packagenoHere", packageno);
                strPacksItem = strPacksItem.Replace("weightHere", packageItem["Weight"].ToString());
                strPacksItem = strPacksItem.Replace("remarkHere", packageItem["Remark"].ToString().Split('|')[0].ToString());

                //取出商品信息并在前台展示
                IPackageGoods pg = YouExService.GetIPackageGoods();
                IList<DataInfo> goods = pg.GetPackageGoodsList(packageno);
                string strGoods = getDeliveryGoodsInfo(goods, packageno);
                strPacksItem = strPacksItem.Replace("goodsHere", strGoods);

                //取出分箱前商品信息并在前台显示
                DataInfo explain_delivery_before = pc.GetPackage(packageno);
                IList<DataInfo> explain_delivery_packagegoods = pg.GetPackageGoodsList(packageno);
                string strExplainBefore = getDeliveryCloneGoodsInfo(explain_delivery_packagegoods, packageno);
                strPacksItem = strPacksItem.Replace("explainbeforeHere", strExplainBefore);
            }
            catch { Response.Write("<script>alert('不能成功获取包裹，请联系客服');</script>"); }
            
            return strPacksItem;
        }

        //处理中的运单和商品的前台展示
        protected string getWaitingDeliveryInfo(DataInfo deliveryItem,string strDelivsItem) 
        {
            try
            {
                //根据运单NO获取订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                IPackageAddress pa = YouExService.GetIPackageAddress();
                IPackageCenter pc = YouExService.GetIPackageCenter();
                IPackageGoods pg = YouExService.GetIPackageGoods();
                string deliveryno = deliveryItem["PackageNo"].ToString();
                DataInfo order = oc.GetOrder(deliveryItem["OrderNo"].ToString());
                string address_str = getAddresses(userId);
                string roadline_str = GetShipping(Convert.ToInt32(deliveryItem["DepotId"]));
                string delivery_addressno = pa.GetPackageAddress(deliveryno)["Name"].ToString();
                string multi_roadline = getMultiRoadLines(order);
                string multi_address = getMultiAddresses(order);

                strDelivsItem = strDelivsItem.Replace("createtimeHere", Convert.ToDateTime(deliveryItem["CreateTime"]).ToString());
                if (deliveryItem["ShippingId"].ToString() != "")
                    strDelivsItem = strDelivsItem.Replace("shippingidHere", getRoadLineWord(Convert.ToInt32(deliveryItem["ShippingId"])));
                else
                    strDelivsItem = strDelivsItem.Replace("shippingidHere", deliveryItem["ShippingName"].ToString());
                strDelivsItem = strDelivsItem.Replace("shippingidintHere", deliveryItem["ShippingId"].ToString());
                strDelivsItem = strDelivsItem.Replace("roadlinemultiHere", multi_roadline);
                strDelivsItem = strDelivsItem.Replace("statusHere", deliveryItem["Status"].ToString());
                strDelivsItem = strDelivsItem.Replace("shippingnoHere", getShippingNoByOrderNo(deliveryItem["OrderNo"].ToString()));
                strDelivsItem = strDelivsItem.Replace("deliverynoHere", deliveryno);
                strDelivsItem = strDelivsItem.Replace("addressHere", address_str);
                strDelivsItem = strDelivsItem.Replace("shippingHere", roadline_str);
                strDelivsItem = strDelivsItem.Replace("addressnameHere", delivery_addressno);
                strDelivsItem = strDelivsItem.Replace("addressmultiHere", multi_address);
                strDelivsItem = strDelivsItem.Replace("insuranceHere", order["Insurance"].ToString());
                strDelivsItem = strDelivsItem.Replace("invoiceHere", order["Invoice"].ToString());
                strDelivsItem = strDelivsItem.Replace("autopayHere", order["AutoPay"].ToString());
                strDelivsItem = strDelivsItem.Replace("weightHere", deliveryItem["Weight"].ToString());
                strDelivsItem = strDelivsItem.Replace("packagecountHere", order["PackageCount"].ToString());
                strDelivsItem = strDelivsItem.Replace("deliverycountHere", order["DeliveryCount"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifytypeHere", deliveryItem["NotifyType"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifyHere", deliveryItem["NotifyInfo"].ToString());
                strDelivsItem = strDelivsItem.Replace("remarkHere", deliveryItem["Remark"].ToString());
                if(order["PackageCount"].ToString() == "1" && order["DeliveryCount"].ToString() =="1")
                    strDelivsItem = strDelivsItem.Replace("packagestatusshowHere", "default");
                if (order["PackageCount"].ToString() == "1" && Convert.ToInt32(order["DeliveryCount"].ToString()) > 1)
                    strDelivsItem = strDelivsItem.Replace("packagestatusshowHere", "split");
                if (order["DeliveryCount"].ToString() == "1" && Convert.ToInt32(order["PackageCount"].ToString()) > 1)
                    strDelivsItem = strDelivsItem.Replace("packagestatusshowHere", "add");

                //取出原箱商品信息并在前台展示
                int deliverycount = isExplainDelivery(deliveryno);
                int adddeliverycount = isAddDelivery(deliveryno);
                if (deliverycount < 3 && adddeliverycount < 2)
                {
                    IList<DataInfo> delivgoods = pg.GetPackageGoodsList(deliveryno);
                    string strDelivGoods = getDeliveryGoodsInfo(delivgoods, deliveryno);
                    strDelivsItem = strDelivsItem.Replace("goodsHere", strDelivGoods);
                }

                //取出合箱前商品信息并在前台显示
                if (adddeliverycount > 1)
                {
                    IList<DataInfo> delivgoods = pg.GetPackageGoodsList(deliveryno);
                    string strDelivGoods = getDeliveryGoodsInfo(delivgoods, deliveryno);
                    strDelivsItem = strDelivsItem.Replace("goodsHere", strDelivGoods);
                }

                //取出分箱前商品信息并在前台显示
                if (deliverycount > 2 && adddeliverycount < 2)
                {
                    DataInfo delivery = pc.GetPackage(deliveryno);
                    string orderno_outside = delivery["OrderNo"].ToString();
                    IList<DataInfo> explain_packages_outside = pc.GetPackageByOrderNo(orderno_outside);
                    foreach (DataInfo explain_package_outside in explain_packages_outside)
                    {
                        if (Convert.ToInt32(explain_package_outside["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received))
                        {
                            IList<DataInfo> explain_delivery_packagegoods = pg.GetPackageGoodsList(explain_package_outside["PackageNo"].ToString());
                            string strDelivGoods = getDeliveryGoodsInfo(explain_delivery_packagegoods, deliveryno);
                            strDelivsItem = strDelivsItem.Replace("goodsHere", strDelivGoods);
                        }
                    }
                }

                //取出分箱前clone商品信息
                if (deliverycount < 3 && adddeliverycount < 2)
                {
                    DataInfo explain_delivery_before = pc.GetPackage(deliveryno);
                    IList<DataInfo> explain_delivery_packagegoods = pg.GetPackageGoodsList(deliveryno);
                    string strExplainBefore = getDeliveryCloneGoodsInfo(explain_delivery_packagegoods, deliveryno);
                    strDelivsItem = strDelivsItem.Replace("explainbeforeHere", strExplainBefore);
                }
                else
                {
                    DataInfo delivery_old = pc.GetPackage(deliveryno);
                    string orderno_before = delivery_old["OrderNo"].ToString();
                    IList<DataInfo> explain_packages_before = pc.GetPackageByOrderNo(orderno_before);
                    foreach (DataInfo explain_package_before in explain_packages_before)
                    {
                        if (Convert.ToInt32(explain_package_before["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Received))
                        {
                            IList<DataInfo> explain_delivery_packagegoods = pg.GetPackageGoodsList(explain_package_before["PackageNo"].ToString());
                            string strExplainBefore = getDeliveryCloneGoodsInfo(explain_delivery_packagegoods, deliveryno);
                            strDelivsItem = strDelivsItem.Replace("explainbeforeHere", strExplainBefore);
                        }
                    }
                }

                //取出分箱后clone商品信息
                string getCloneDeliveryGoods = Request.Form["clonegoodsno"];
                if (getCloneDeliveryGoods != null)
                {
                    IList<DataInfo> explain_delivery_deliverygoods = pg.GetPackageGoodsList(getCloneDeliveryGoods);
                    string orderno = pc.GetPackage(getCloneDeliveryGoods)["OrderNo"].ToString();
                    IList<DataInfo> explain_deliverys = pc.GetPackageByOrderNo(orderno);
                    string str_AllDeliverys = "";
                    foreach (DataInfo explain_delivery in explain_deliverys)
                    {
                        if (Convert.ToInt32(explain_delivery["Type"]) == Convert.ToInt32(DataField.PACKAGE_TYPE.Send))
                        {
                            IList<DataInfo> explain_delivery_goods = pg.GetPackageGoodsList(explain_delivery["PackageNo"].ToString());
                            string str_AllDelivery = getDeliveryCloneGoodsInfo_After(explain_delivery_goods, getCloneDeliveryGoods) + ",";
                            str_AllDeliverys += str_AllDelivery;
                        }
                    }
                    Response.ContentType = "text/plain";
                    Response.Write(str_AllDeliverys);
                    Response.End();
                }
            }
            catch { }

            return strDelivsItem;
        }

        //待支付的运单和商品的前台展示
        protected string getPayBillDeliveryInfo(DataInfo deliveryItem, string strDelivsItem)
        {
            try
            {
                //根据运单NO获取订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                IPackageAddress pa = YouExService.GetIPackageAddress();
                DataInfo order = oc.GetOrder(deliveryItem["OrderNo"].ToString());
                string deliveryno = deliveryItem["PackageNo"].ToString();

                strDelivsItem = strDelivsItem.Replace("createtimeHere", Convert.ToDateTime(deliveryItem["CreateTime"]).ToString());
                strDelivsItem = strDelivsItem.Replace("shippingidHere", getRoadLineWord(Convert.ToInt32(deliveryItem["ShippingId"])));
                strDelivsItem = strDelivsItem.Replace("statusHere", deliveryItem["Status"].ToString());
                strDelivsItem = strDelivsItem.Replace("shippingnoHere", deliveryItem["ShippingNo"].ToString());
                strDelivsItem = strDelivsItem.Replace("deliverynoHere", deliveryno);
                strDelivsItem = strDelivsItem.Replace("insuranceHere", order["Insurance"].ToString());
                strDelivsItem = strDelivsItem.Replace("invoiceHere", order["Invoice"].ToString());
                strDelivsItem = strDelivsItem.Replace("autopayHere", order["AutoPay"].ToString());
                strDelivsItem = strDelivsItem.Replace("weightHere", deliveryItem["Weight"].ToString());
                strDelivsItem = strDelivsItem.Replace("lengthHere", deliveryItem["Length"].ToString());
                strDelivsItem = strDelivsItem.Replace("widthHere", deliveryItem["Width"].ToString());
                strDelivsItem = strDelivsItem.Replace("heightHere", deliveryItem["Height"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifytypeHere", deliveryItem["NotifyType"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifyHere", deliveryItem["NotifyInfo"].ToString());
                strDelivsItem = strDelivsItem.Replace("remarkHere", deliveryItem["Remark"].ToString());
            }
            catch { }

            return strDelivsItem;
        }
        
        //运输中的运单和商品的前台展示
        protected string getTransportDeliveryInfo(DataInfo deliveryItem, string strDelivsItem) 
        {
            try
            {
                //根据运单NO获取订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                IPackageAddress pa = YouExService.GetIPackageAddress();
                DataInfo order = oc.GetOrder(deliveryItem["OrderNo"].ToString());
                string deliveryno = deliveryItem["PackageNo"].ToString();

                strDelivsItem = strDelivsItem.Replace("createtimeHere", Convert.ToDateTime(deliveryItem["CreateTime"]).ToString());
                strDelivsItem = strDelivsItem.Replace("shippingidHere", getRoadLineWord(Convert.ToInt32(deliveryItem["ShippingId"])));
                strDelivsItem = strDelivsItem.Replace("statusHere", deliveryItem["Status"].ToString());
                strDelivsItem = strDelivsItem.Replace("shippingnoHere", getShippingNoByOrderNo(deliveryItem["OrderNo"].ToString()));
                strDelivsItem = strDelivsItem.Replace("deliverynoHere", deliveryno);
                strDelivsItem = strDelivsItem.Replace("insuranceHere", order["Insurance"].ToString());
                strDelivsItem = strDelivsItem.Replace("invoiceHere", order["Invoice"].ToString());
                strDelivsItem = strDelivsItem.Replace("autopayHere", order["AutoPay"].ToString());
                strDelivsItem = strDelivsItem.Replace("weightHere", deliveryItem["Weight"].ToString());
                strDelivsItem = strDelivsItem.Replace("lengthHere", deliveryItem["Length"].ToString());
                strDelivsItem = strDelivsItem.Replace("widthHere", deliveryItem["Width"].ToString());
                strDelivsItem = strDelivsItem.Replace("heightHere", deliveryItem["Height"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifytypeHere", deliveryItem["NotifyType"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifyHere", deliveryItem["NotifyInfo"].ToString());
                strDelivsItem = strDelivsItem.Replace("remarkHere", deliveryItem["Remark"].ToString());
            }
            catch { }

            return strDelivsItem;
        }

        //已完成的运单和商品的前台展示
        protected string getFinishedDeliveryInfo(DataInfo deliveryItem, string strDelivsItem) 
        {
            try
            {
                //根据运单NO获取订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                IPackageAddress pa = YouExService.GetIPackageAddress();
                DataInfo order = oc.GetOrder(deliveryItem["OrderNo"].ToString());
                string deliveryno = deliveryItem["PackageNo"].ToString();

                strDelivsItem = strDelivsItem.Replace("createtimeHere", Convert.ToDateTime(deliveryItem["CreateTime"]).ToString());
                strDelivsItem = strDelivsItem.Replace("shippingidHere", getRoadLineWord(Convert.ToInt32(deliveryItem["ShippingId"])));
                strDelivsItem = strDelivsItem.Replace("statusHere", deliveryItem["Status"].ToString());
                strDelivsItem = strDelivsItem.Replace("shippingnoHere", getShippingNoByOrderNo(deliveryItem["OrderNo"].ToString()));
                strDelivsItem = strDelivsItem.Replace("deliverynoHere", deliveryno);
                strDelivsItem = strDelivsItem.Replace("insuranceHere", order["Insurance"].ToString());
                strDelivsItem = strDelivsItem.Replace("invoiceHere", order["Invoice"].ToString());
                strDelivsItem = strDelivsItem.Replace("autopayHere", order["AutoPay"].ToString());
                strDelivsItem = strDelivsItem.Replace("weightHere", deliveryItem["Weight"].ToString());
                strDelivsItem = strDelivsItem.Replace("lengthHere", deliveryItem["Length"].ToString());
                strDelivsItem = strDelivsItem.Replace("widthHere", deliveryItem["Width"].ToString());
                strDelivsItem = strDelivsItem.Replace("heightHere", deliveryItem["Height"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifytypeHere", deliveryItem["NotifyType"].ToString());
                strDelivsItem = strDelivsItem.Replace("notifyHere", deliveryItem["NotifyInfo"].ToString());
                strDelivsItem = strDelivsItem.Replace("remarkHere", deliveryItem["Remark"].ToString());
            }
            catch { }

            return strDelivsItem;
        }

        //弃货处理的包裹
        protected string getDeletePackageInfo(DataInfo packageItem, string strPacksItem)
        {
            try
            {
                IPackageCenter pc = YouExService.GetIPackageCenter();
                string packageno = packageItem["PackageNo"].ToString();
                string address_str = getAddresses(userId);
                DataInfo order = (new OrderService()).GetOrder(packageItem["OrderNo"].ToString());

                strPacksItem = strPacksItem.Replace("createtimeHere", Convert.ToDateTime(packageItem["CreateTime"]).ToString());
                strPacksItem = strPacksItem.Replace("storagetimeHere", packageItem["StorageTime"].ToString());
                strPacksItem = strPacksItem.Replace("statusHere", packageItem["Status"].ToString());
                strPacksItem = strPacksItem.Replace("shippingnoHere", packageItem["ShippingNo"].ToString());
                strPacksItem = strPacksItem.Replace("addressHere", address_str);
                strPacksItem = strPacksItem.Replace("packagenoHere", packageno);
                strPacksItem = strPacksItem.Replace("weightHere", packageItem["Weight"].ToString());
                strPacksItem = strPacksItem.Replace("lengthHere", packageItem["Length"].ToString());
                strPacksItem = strPacksItem.Replace("widthHere", packageItem["Width"].ToString());
                strPacksItem = strPacksItem.Replace("heightHere", packageItem["Height"].ToString());
                strPacksItem = strPacksItem.Replace("remarkHere", packageItem["Remark"].ToString());
            }
            catch { }

            return strPacksItem;
        }






    }
}