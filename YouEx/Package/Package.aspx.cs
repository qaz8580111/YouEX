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
    public partial class Package : Tool.UserPage
    {
        string relative_path_front = "";
        string relative_path_back = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string shippingno = Request.QueryString["shippingno"];
            string depotid = Request.QueryString["depotid"];
            IList<DataInfo> addresses = getAddressByUserId(userId);

            if (!IsPostBack)
            {
                //显示出所有地区
                IList<DataInfo> countrys = (new AreaService()).GetCountryList();
                foreach (DataInfo country in countrys)
                {
                    DropDownList_country.Items.Add(new ListItem(country["Name"].ToString(), country["Id"].ToString()));
                }

                //获取所有仓库
                IList<DataInfo> depots = (new CommonService()).GetDepot();
                foreach (DataInfo depot in depots)
                {
                    DropDownList_DepotId.Items.Add(new ListItem(depot["Name"].ToString(), depot["DepotId"].ToString()));
                }

                //获取该用户所有地址
                string str = "";
                int number = 100;
                foreach (DataInfo address in addresses)
                {
                    string stritem = LiteralAddress.Text;
                    string info_total = address["Address"].ToString() + "&nbsp&nbsp" + address["Recipients"].ToString() + "&nbsp&nbsp" + address["Mobile"].ToString();
                    stritem = stritem.Replace("addressHere", "(" + address["Name"].ToString() + ")" +
                                      getAreaByAreaId(Convert.ToInt32(address["Country"]))["Name"].ToString() + "&nbsp&nbsp" +
                                      getAreaByAreaId(Convert.ToInt32(address["Province"]))["Name"].ToString() + "&nbsp&nbsp" +
                                      getAreaByAreaId(Convert.ToInt32(address["City"]))["Name"].ToString());
                    stritem = stritem.Replace("infoHere", info_total);
                    stritem = stritem.Replace("nameHere", address["Name"].ToString());
                    stritem = stritem.Replace("shippingnoHere", shippingno);
                    stritem = stritem.Replace("numberHere", (number++).ToString());
                    str += stritem;
                }
                LiteralAddress.Text = str;

                //获取分箱地址簿
                string strsel = "";
                foreach (DataInfo address in addresses)
                {
                    try
                    {
                        string stritem = Literal_select_address.Text;
                        string addressname = address["Name"].ToString();

                        stritem = stritem.Replace("addressHere", getAreaByAreaId(Convert.ToInt32(address["Country"]))["Name"].ToString() + " " +
                                      getAreaByAreaId(Convert.ToInt32(address["Province"]))["Name"].ToString() + " " +
                                      getAreaByAreaId(Convert.ToInt32(address["City"]))["Name"].ToString() + "(" + address["Name"].ToString() + ")");
                        stritem = stritem.Replace("nameHere", addressname);
                        strsel += stritem;
                    }
                    catch { }
                }
                Literal_select_address.Text = strsel;
            }

            if (depotid != null) {
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
                Response.ContentType = "text/plain";
                Response.Write(Serialize(roadlines_reverse));
                Response.End();
            }

            //根据用户资料选择原箱的不同提醒方式
            DataInfo UserInfo = (new UserService()).GetUserInfo(userId);
            string strNotice = Literal_NoticeType.Text;
            strNotice = strNotice.Replace("mobileHere", UserInfo["Mobile"].ToString());
            strNotice = strNotice.Replace("emailHere", UserInfo["Email"].ToString());
            Literal_NoticeType.Text = strNotice;

            Image_IdCardFront.ImageUrl = "../Images/Pic_User/idcard_front.png";
            Image_IdCardBack.ImageUrl = "../Images/Pic_User/idcard_back.png";

        }

        //根据用户ID获取所有地址
        protected IList<DataInfo> getAddressByUserId(int userid)
        {
            IUserAddress ua = YouExService.GetIUserAddress();
            IList<DataInfo> addresses = ua.GetAddressList(userid);
            return addresses;
        }

        //根据用户ID得到用户信息
        protected DataInfo getUserInfoByUserId(int userid)
        {
            IUserCenter uc = YouExService.GetIUserCenter();
            DataInfo user = uc.GetUserInfo(userid);
            return user;
        }

        //根据areaid获取area
        protected DataInfo getAreaByAreaId(int areaid)
        {
            IAreaCenter ac = YouExService.GetIAreaCenter();
            DataInfo address = ac.GetAreaInfo(areaid);
            return address;
        }

        //获取国家地区
        protected IList<DataInfo> getCountrys()
        {
            IAreaCenter ac = YouExService.GetIAreaCenter();
            IList<DataInfo> countrys = ac.GetCountryList();
            return countrys;
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&=()]", "");
            return result_transfer;
        }

        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
        }

        //增加地址簿
        protected void addAddress(object sender, EventArgs e)
        {
            int add_result = 0;
            try
            {
                //得到图片数据并创建文件信息
                string strfront = uploadPicFront.PostedFile.FileName;
                string suffix_front = strfront.Substring(strfront.LastIndexOf("."));
                //得到证件正面byte数组
                System.IO.Stream fileDataStream_front = uploadPicFront.PostedFile.InputStream;
                int fileLength_Front = uploadPicFront.PostedFile.ContentLength;
                byte[] fileData_Front = new byte[fileLength_Front];
                fileDataStream_front.Read(fileData_Front, 0, fileLength_Front);
                //创建证件正面文件
                int result_idcard_front = (new FileService()).CreateFile(1, userId, "IDCard_Front_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_F" + suffix_front, "IdCard");
                bool result_issave_front = (new FileService()).SaveFile(result_idcard_front, fileData_Front);


                string strback = uploadPicBack.PostedFile.FileName;
                string suffix_back = strback.Substring(strback.LastIndexOf("."));
                //得到证件反面byte数组
                System.IO.Stream fileDataStream_back = uploadPicBack.PostedFile.InputStream;
                int fileLength_Back = uploadPicBack.PostedFile.ContentLength;
                byte[] fileData_Back = new byte[fileLength_Back];
                fileDataStream_back.Read(fileData_Back, 0, fileLength_Back);
                //创建证件反面文件
                int result_idcard_back = (new FileService()).CreateFile(1, userId, "IDCard_Back_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_B" + suffix_back, "IdCard");
                bool result_issave_back = (new FileService()).SaveFile(result_idcard_back, fileData_Back);


                IUserAddress ud = YouExService.GetIUserAddress();
                DataInfo address = new DataInfo();
                address.Add("UserId", userId);
                address.Add("Recipients", getTransferString(TB_Address_Recipients.Text));
                address.Add("Mobile", getTransferString(TB_Address_Mobile.Text));
                address.Add("Name", getTransferString(TB_Address_Name.Text));
                address.Add("Country", Request.Form[DropDownList_country.UniqueID]);
                address.Add("Province", Request.Form[DropDownList_province.UniqueID]);
                address.Add("City", Request.Form[DropDownList_city.UniqueID]);
                address.Add("Address", getTransferString(TB_Address_Address.Text));
                address.Add("ZipCode", getTransferString(TB_Address_ZipCode.Text));
                address.Add("IdCard", getTransferString(TB_Address_IdCard.Text));
                address.Add("IdFront", result_idcard_front.ToString());
                address.Add("IdBack", result_idcard_back.ToString());
                add_result = ud.AddUserAddress(userId, address);

                //记录增加地址簿日志
                if (add_result > 0)
                {
                    DataInfo userlog_addaddress = new DataInfo();
                    userlog_addaddress["UserId"] = userId;
                    userlog_addaddress["AddressName"] = getTransferString(TB_Address_Name.Text);
                    userlog_addaddress["CreateTime"] = System.DateTime.Now.ToString();
                    userlog_addaddress["Message"] = "增加地址成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService().GetStorageNo(userId)), DataField.USER_ACTION.AddAddress.ToString(), userlog_addaddress);
                }
            }
            catch { Response.Redirect("../Help/ErrorPage.aspx"); }

            if (add_result > 0){
                Response.Redirect("./Package.aspx");
            }else
                Response.Redirect("../Help/ErrorPage.aspx");
        }

        //获取时间戳
        public static long ConvertDateTimeToInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t;
        }

        //获取所有的路线   
        protected string GetShipping(string depotid,string literal_str){
            IList<DataInfo> roadlines = (new CommonService()).GetShippingList();
            string str = "";
            foreach (DataInfo roadline in roadlines)
            {
                if (roadline["FromDepot"].ToString() == depotid)
                {
                    string strItem = literal_str;
                    strItem = strItem.Replace("shippingidHere", roadline["ShippingId"].ToString());
                    strItem = strItem.Replace("shippingnameHere", roadline["ShippingName"].ToString());
                    str += strItem;
                }
            }
            return str;
        }

        //上传购物图片
        protected string UploadShoppingImg()
        {
            string upload_path_id = "";
            try
            {
                if (FileUpload1.PostedFile.FileName != "" && Request.Form["Label_Upload1"] != "" && Request.Form["Label_Upload1"] != null)
                {
                    //得到图片数据并创建文件信息
                    string strfilename = FileUpload1.PostedFile.FileName;
                    string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                    //得到byte数组
                    System.IO.Stream fileDataStream = FileUpload1.PostedFile.InputStream;
                    int FileUploadLength = FileUpload1.PostedFile.ContentLength;
                    byte[] fileData = new byte[FileUploadLength];
                    fileDataStream.Read(fileData, 0, FileUploadLength);
                    //创建文件
                    int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                    bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                    if (result_shopping > 0)
                        upload_path_id += "|" + result_shopping;
                }
                if (FileUpload2.PostedFile.FileName != "" && Request.Form["Label_Upload2"] != "" && Request.Form["Label_Upload2"] != null)
                {
                    //得到图片数据并创建文件信息
                    string strfilename = FileUpload2.PostedFile.FileName;
                    string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                    //得到byte数组
                    System.IO.Stream fileDataStream = FileUpload2.PostedFile.InputStream;
                    int FileUploadLength = FileUpload2.PostedFile.ContentLength;
                    byte[] fileData = new byte[FileUploadLength];
                    fileDataStream.Read(fileData, 0, FileUploadLength);
                    //创建文件
                    int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                    bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                    if (result_shopping > 0)
                        upload_path_id += "|" + result_shopping;
                }
                if (FileUpload3.PostedFile.FileName != "" && Request.Form["Label_Upload3"] != "" && Request.Form["Label_Upload3"] != null)
                {
                    //得到图片数据并创建文件信息
                    string strfilename = FileUpload3.PostedFile.FileName;
                    string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                    //得到byte数组
                    System.IO.Stream fileDataStream = FileUpload3.PostedFile.InputStream;
                    int FileUploadLength = FileUpload3.PostedFile.ContentLength;
                    byte[] fileData = new byte[FileUploadLength];
                    fileDataStream.Read(fileData, 0, FileUploadLength);
                    //创建文件
                    int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                    bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                    if (result_shopping > 0)
                        upload_path_id += "|" + result_shopping;
                }
                if (FileUpload4.PostedFile.FileName != "" && Request.Form["Label_Upload4"] != "" && Request.Form["Label_Upload4"] != null)
                {
                    //得到图片数据并创建文件信息
                    string strfilename = FileUpload4.PostedFile.FileName;
                    string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                    //得到byte数组
                    System.IO.Stream fileDataStream = FileUpload4.PostedFile.InputStream;
                    int FileUploadLength = FileUpload4.PostedFile.ContentLength;
                    byte[] fileData = new byte[FileUploadLength];
                    fileDataStream.Read(fileData, 0, FileUploadLength);
                    //创建文件
                    int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                    bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                    if (result_shopping > 0)
                        upload_path_id += "|" + result_shopping;
                }
                if (FileUpload5.PostedFile.FileName != "" && Request.Form["Label_Upload5"] != "" && Request.Form["Label_Upload5"] != null)
                {
                    //得到图片数据并创建文件信息
                    string strfilename = FileUpload5.PostedFile.FileName;
                    string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                    //得到byte数组
                    System.IO.Stream fileDataStream = FileUpload5.PostedFile.InputStream;
                    int FileUploadLength = FileUpload5.PostedFile.ContentLength;
                    byte[] fileData = new byte[FileUploadLength];
                    fileDataStream.Read(fileData, 0, FileUploadLength);
                    //创建文件
                    int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                    bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                    if (result_shopping > 0)
                        upload_path_id += "|" + result_shopping;
                }
            }
            catch {}
            return upload_path_id;
        }

        //提交包裹信息
        protected void submit_package(object sender, EventArgs e)
        {
            IPackageCenter pc = YouExService.GetIPackageCenter();
            IPackageGoods pg = YouExService.GetIPackageGoods();
            DataInfo package = new DataInfo();

            string upload_path_id = UploadShoppingImg();

            //添加包裹信息
            string shippingorder = getTransferString(Request.Form["shippingorder"]);
            package["Remark"] = getTransferString(Request.Form["remark"]) + upload_path_id;
            package["UserId"] = userId;
            package["DepotId"] = DropDownList_DepotId.SelectedValue;
            package["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Received);
            package["CreateTime"] = System.DateTime.Now.ToString();
            package["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
            package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast);
            string result_package = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), shippingorder, package);

            //记录添加包裹日志
            if (result_package != "")
            {
                DataInfo packagelog_addpackage = new DataInfo();
                packagelog_addpackage["UserId"] = userId;
                packagelog_addpackage["PackageNo"] = result_package;
                packagelog_addpackage["CreateTime"] = System.DateTime.Now.ToString();
                packagelog_addpackage["Message"] = "添加包裹成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_package, DataField.PACKAGE_ACTION.Forcast.ToString(), packagelog_addpackage);
            }

            //是否添加增值服务
            int isphoto = Convert.ToInt32(Request.Form["isphoto"]);
            if (isphoto != 0)
            {
                IOrderService os = YouExService.GetIOrderService();
                DataInfo added = new DataInfo();
                added["UserId"] = userId;
                added["PackageNo"] = result_package;
                added["AccessStatus"] = 0;
                added["PayStatus"] = 0;
                added["ServiceCode"] = "Photo";
                added["Request"] = getTransferString(Request.Form["photo_remark"]);
                added["CreateTime"] = System.DateTime.Now.ToString();
                string result_isphoto = os.CreateService(Convert.ToInt32(Request.Form["depotid"]), added);

                //记录添加增值服务日志
                if (result_package != "")
                {
                    DataInfo servicelog_addservice = new DataInfo();
                    servicelog_addservice["UserId"] = userId;
                    servicelog_addservice["ServiceNo"] = result_isphoto;
                    servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                    servicelog_addservice["Message"] = "添加拍照服务成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isphoto, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                }
            }

            //是否添加加固服务
            int isreinforce = Convert.ToInt32(Request.Form["reinforce"]);
            if (isreinforce != 0)
            {
                IOrderService os = YouExService.GetIOrderService();
                DataInfo added = new DataInfo(); ;
                added["UserId"] = userId;
                added["DepotId"] = DropDownList_DepotId.SelectedValue;
                added["PackageNo"] = result_package;
                added["AccessStatus"] = 0;
                added["PayStatus"] = 0;
                added["ServiceCode"] = "Fasten";
                added["Request"] = getTransferString(Request.Form["reinforce_remark"]);
                added["CreateTime"] = System.DateTime.Now.ToString();
                string result_isreinforce = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                //记录添加增值服务日志
                if (result_package != "")
                {
                    DataInfo servicelog_addservice = new DataInfo();
                    servicelog_addservice["UserId"] = userId;
                    servicelog_addservice["ServiceNo"] = result_isreinforce;
                    servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                    servicelog_addservice["Message"] = "添加加固服务成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isreinforce, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                }
            }

            //添加多个商品信息
            string[] good_brand = Request.Form.GetValues("good_brand");
            string[] good_name = Request.Form.GetValues("good_name");
            string[] good_price = Request.Form.GetValues("good_price");
            string[] good_amount = Request.Form.GetValues("good_amount");
            string[] good_buyurl = Request.Form.GetValues("good_buyurl");
            for (int i = 0; i < good_name.Length; i++)
            {
                DataInfo good = new DataInfo();
                good["Brand"] = getTransferString(good_brand[i]);
                good["Name"] = getTransferString(good_name[i]);
                good["Price"] = Convert.ToDecimal(getTransferString(good_price[i]));
                good["Count"] = getTransferString(good_amount[i]);
                good["BuyUrl"] = getTransferString(good_buyurl[i]);
                pg.CreatePackageGoods(result_package, good);
            }
            if (result_package != null)
                Page.ClientScript.RegisterStartupScript(ClientScript.GetType(), "", "<script>alert('包裹预报成功，请耐心等待');location.href='../UserCenter/UserCenter.aspx';</script>");
        }

        //提交运单信息
        protected void submit_delivery(object sender, EventArgs e){
            string ispackagetype = getTransferString(Request.Form["isPackageType"]);
            string upload_path_id = UploadShoppingImg();
            
            if (ispackagetype == "default")
            {
                #region 一个箱子进行原箱操作
                bool result_dead = false;
                string result_package = null;
                string result_delivery = null;
                
                try
                {
                    //生成订单信息
                    IOrderCenter oc = YouExService.GetIOrderCenter();
                    DataInfo order = new DataInfo();
                    order["CreateTime"] = System.DateTime.Now.ToString();
                    order["Type"] = 1;
                    order["DepotId"] = DropDownList_DepotId.SelectedValue;
                    order["Insurance"] = Convert.ToInt32(Request.Form["insurance_default"]);
                    order["Invoice"] = Convert.ToInt32(Request.Form["invoice_default"]);
                    order["AutoPay"] = Convert.ToInt32(Request.Form["type_pay_default"]);
                    order["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                    //order["DeliveryCount"] = 1;
                    //order["PackageCount"] = 1;
                    order["UserId"] = userId;
                    order["PayStatus"] = 0;
                    order["AccessStatus"] = 0;
                    string result_order = oc.CreateOrder(Convert.ToInt32(DropDownList_DepotId.SelectedValue), order);
                    //记录添加订单日志
                    DataInfo orderlog_create = new DataInfo();
                    orderlog_create["UserId"] = userId;
                    orderlog_create["Event"] = "预报入库";
                    orderlog_create["CreateTime"] = System.DateTime.Now.ToString();
                    orderlog_create["Message"] = "订单创建成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Order), result_order, DataField.ORDER_ACTION.WaitPackage.ToString(),orderlog_create);
                    
                    //添加包裹信息
                    IPackageCenter pc = YouExService.GetIPackageCenter();
                    DataInfo package = new DataInfo();
                    string shippingorder = getTransferString(Request.Form["shippingorder"]);
                    package["OrderNo"] = result_order;
                    package["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                    package["Remark"] = getTransferString(Request.Form["remark"]);
                    package["UserId"] = userId;
                    package["DepotId"] = DropDownList_DepotId.SelectedValue;
                    package["CreateTime"] = System.DateTime.Now.ToString();
                    package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast);
                    package["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Received);
                    package["Remark"] = upload_path_id;
                    result_package = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), shippingorder, package);

                    //记录添加包裹日志
                    if (result_package != "")
                    {
                        DataInfo packagelog_addpackage = new DataInfo();
                        packagelog_addpackage["UserId"] = userId;
                        packagelog_addpackage["PackageNo"] = result_package;
                        packagelog_addpackage["CreateTime"] = System.DateTime.Now.ToString();
                        packagelog_addpackage["Message"] = "添加包裹成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_package, DataField.PACKAGE_ACTION.Forcast.ToString(), packagelog_addpackage);
                    }
                    
                    //添加多个商品信息
                    IPackageGoods pg = YouExService.GetIPackageGoods();
                    string[] good_brand = Request.Form.GetValues("good_brand");
                    string[] good_name = Request.Form.GetValues("good_name");
                    string[] good_price = Request.Form.GetValues("good_price");
                    string[] good_amount = Request.Form.GetValues("good_amount");
                    string[] good_buyurl = Request.Form.GetValues("good_buyurl");
                    for (int i = 0; i < good_name.Length; i++)
                    {
                        DataInfo good = new DataInfo();
                        good["Brand"] = getTransferString(good_brand[i]);
                        good["Name"] = getTransferString(good_name[i]);
                        good["Price"] = Convert.ToDecimal(getTransferString(good_price[i]));
                        good["Count"] = getTransferString(good_amount[i]);
                        good["BuyUrl"] = getTransferString(good_buyurl[i]);
                        pg.CreatePackageGoods(result_package,good);
                    }

                    //生成运单信息
                    DataInfo muti_delivery = new DataInfo();
                    muti_delivery["UserId"] = userId;
                    muti_delivery["DepotId"] = DropDownList_DepotId.SelectedValue;
                    muti_delivery["ShippingId"] = Request.Form["roadline_default"];
                    muti_delivery["OrderNo"] = result_order;
                    muti_delivery["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Send);
                    muti_delivery["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Blank);
                    muti_delivery["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                    muti_delivery["CreateTime"] = System.DateTime.Now.ToString();
                    muti_delivery["NotifyType"] = Convert.ToInt32(Request.Form["type_notice_default"]);
                    if (Convert.ToInt32(Request.Form["type_notice_default"]) < 2)
                        muti_delivery["NotifyInfo"] = getTransferString(Request.Form["connection_default"]).Split(',')[Convert.ToInt32(Request.Form["type_notice_default"])];
                    muti_delivery["Remark"] = getTransferString(Request.Form["remark"]);
                    result_delivery = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), "", muti_delivery);

                    //记录添加运单日志
                    if (result_package != "")
                    {
                        DataInfo deliverylog_adddelivery = new DataInfo();
                        deliverylog_adddelivery["UserId"] = userId;
                        deliverylog_adddelivery["DeliveryNo"] = result_delivery;
                        deliverylog_adddelivery["CreateTime"] = System.DateTime.Now.ToString();
                        deliverylog_adddelivery["Message"] = "添加运单成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_delivery, DataField.PACKAGE_ACTION.Blank.ToString(), deliverylog_adddelivery);
                    }

                    //是否添加拍照服务
                    int isphoto = Convert.ToInt32(Request.Form["isphoto"]);
                    if (isphoto != 0)
                    {
                        IOrderService os = YouExService.GetIOrderService();
                        DataInfo added = new DataInfo();
                        added["UserId"] = userId;
                        added["DepotId"] = DropDownList_DepotId.SelectedValue;
                        added["PackageNo"] = result_package;
                        added["AccessStatus"] = 0;
                        added["PayStatus"] = 0;
                        added["ServiceCode"] = "Photo";
                        added["Request"] = getTransferString(Request.Form["photo_remark"]);
                        added["CreateTime"] = System.DateTime.Now.ToString();
                        string result_isphoto = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                        //记录添加增值服务日志
                        if (result_package != "")
                        {
                            DataInfo servicelog_addservice = new DataInfo();
                            servicelog_addservice["UserId"] = userId;
                            servicelog_addservice["ServiceNo"] = result_isphoto;
                            servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                            servicelog_addservice["Message"] = "添加拍照服务成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isphoto, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                        }
                    }

                    //是否添加加固服务
                    int isreinforce = Convert.ToInt32(Request.Form["reinforce"]);
                    if (isreinforce != 0)
                    {
                        IOrderService os = YouExService.GetIOrderService();
                        DataInfo added = new DataInfo(); ;
                        added["UserId"] = userId;
                        added["DepotId"] = DropDownList_DepotId.SelectedValue;
                        added["PackageNo"] = result_package;
                        added["AccessStatus"] = 0;
                        added["PayStatus"] = 0;
                        added["ServiceCode"] = "Fasten";
                        added["Request"] = getTransferString(Request.Form["reinforce_remark"]);
                        added["CreateTime"] = System.DateTime.Now.ToString();
                        string result_isreinforce = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                        //记录添加增值服务日志
                        if (result_package != "")
                        {
                            DataInfo servicelog_addservice = new DataInfo();
                            servicelog_addservice["UserId"] = userId;
                            servicelog_addservice["ServiceNo"] = result_isreinforce;
                            servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                            servicelog_addservice["Message"] = "添加加固服务成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isreinforce, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                        }
                    }

                    //生成运单地址信息
                    IPackageAddress pa = YouExService.GetIPackageAddress();
                    IUserAddress ua = YouExService.GetIUserAddress();
                    DataInfo address = ua.GetUserAddress(userId, Request.Form["address_default"]);
                    DataInfo deliveryaddress = new DataInfo();
                    deliveryaddress["UserId"] = userId;
                    deliveryaddress["DepotId"] = DropDownList_DepotId.SelectedValue;
                    deliveryaddress["Name"] = address["Name"];
                    deliveryaddress["Email"] = address["Email"];
                    deliveryaddress["Phone"] = address["Phone"];
                    deliveryaddress["Mobile"] = address["Mobile"];
                    deliveryaddress["Recipients"] = address["Recipients"];
                    deliveryaddress["Country"] = address["Country"];
                    deliveryaddress["Province"] = address["Province"];
                    deliveryaddress["City"] = address["City"];
                    deliveryaddress["Address"] = address["Address"];
                    deliveryaddress["ZipCode"] = address["ZipCode"];
                    deliveryaddress["IdCard"] = address["IdCard"];
                    deliveryaddress["IdFront"] = address["IdFront"];
                    deliveryaddress["IdBack"] = address["IdBack"];
                    result_dead = pa.CreatePackageAddress(result_delivery,deliveryaddress);

                    //添加多个商品信息
                    string[] default_brand = Request.Form.GetValues("good_brand");
                    string[] default_name = Request.Form.GetValues("good_name");
                    string[] default_price = Request.Form.GetValues("good_price");
                    string[] default_amount = Request.Form.GetValues("good_amount");
                    string[] default_buyurl = Request.Form.GetValues("good_buyurl");
                    for (int i = 0; i < default_name.Length; i++)
                    {
                        DataInfo deliverygood = new DataInfo();
                        deliverygood["Brand"] = getTransferString(default_brand[i]);
                        deliverygood["Name"] = getTransferString(default_name[i]);
                        deliverygood["Price"] = getTransferString(default_price[i]);
                        deliverygood["Count"] = getTransferString(default_amount[i]);
                        deliverygood["BuyUrl"] = getTransferString(default_buyurl[i]);
                        pg.CreatePackageGoods(result_delivery,deliverygood);
                    }
                }
                catch
                {
                    Response.Write("<script>alert('出错了！');</script>");
                }
                #endregion
                if (result_package != null && result_delivery != null && result_dead == true)
                {
                    Response.Write("<script>alert('提交成功！');</script>");
                    Response.Redirect("./MyStock.aspx?ordertype=delivery_waiting");
                }else
                    Response.Write("<script>alert('提交出错了！');</script>");
            }
            if (ispackagetype == "explain")
            {
                #region 一个箱子进行分箱操作
                Random rd = new Random();
                string result_order = null;
                string result_package = null;

                //每个运单的所拥有的商品数量
                string calculate = Request.Form["calculate"].ToString();
                string[] str_calcus = calculate.Split(',');
                int[] int_calcus = new int[10];
                int_calcus = Array.ConvertAll<string, int>(str_calcus, s => int.Parse(s));
                int clone_count = int_calcus.Length;

                //多个地址簿
                string addressids = Request.Form["address_explain"].ToString();
                string[] str_ids = addressids.Split(',');
                                
                //多个路线
                string delivery_line = Request.Form["roadline_explain"].ToString();
                string[] str_lines = delivery_line.Split(',');
                int[] int_lines = new int[10];
                int_lines = Array.ConvertAll<string, int>(str_lines, s => int.Parse(s));

                //获取所有商品信息
                //多个商品品牌
                string delivery_brand = Request.Form["delivery_brand"].ToString();
                string[] old_brand = delivery_brand.Split(',');

                //多个商品名称
                string delivery_name = Request.Form["delivery_name"].ToString();
                string[] old_name = delivery_name.Split(',');

                //多个商品价格
                string delivery_price = Request.Form["delivery_price"].ToString();
                string[] old_price = delivery_price.Split(',');

                //多个商品数量
                string delivery_amount = Request.Form["delivery_count"].ToString();
                string[] str_counts = delivery_amount.Split(',');
                int[] old_count = new int[30];
                old_count = Array.ConvertAll<string, int>(str_counts, s => int.Parse(s));

                //多个商品URL
                string delivery_buyurl = Request.Form["delivery_buyurl"].ToString();
                string[] old_buyurl = delivery_buyurl.Split(',');

                //生成一个订单，多个运单，多个运单地址，多个运单商品
                try
                    {
                //生成订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                DataInfo order = new DataInfo();
                System.DateTime time = System.DateTime.Now;
                order.Add("CreateTime", time.ToString());
                order["UserId"] = userId;
                order["DepotId"] = DropDownList_DepotId.SelectedValue;
                order["Insurance"] = Convert.ToInt32(Request.Form["insurance_explain"]);
                order["Invoice"] = Convert.ToInt32(Request.Form["invoice_explain"]);
                order["AutoPay"] = Convert.ToInt32(Request.Form["type_pay_explain"]);
                order["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                order["CreateTime"] = System.DateTime.Now.ToString();
                order["Type"] = 1;
                order["PayStatus"] = 0;
                order["AccessStatus"] = 0;
                result_order = oc.CreateOrder(Convert.ToInt32(DropDownList_DepotId.SelectedValue), order);
                //记录添加订单日志
                DataInfo orderlog_create = new DataInfo();
                orderlog_create["UserId"] = userId;
                orderlog_create["Event"] = "预报入库";
                orderlog_create["CreateTime"] = System.DateTime.Now.ToString();
                orderlog_create["Message"] = "订单创建成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Order), result_order, DataField.ORDER_ACTION.WaitPackage.ToString(), orderlog_create);

                //添加包裹信息
                IPackageCenter pc = YouExService.GetIPackageCenter();
                DataInfo package = new DataInfo();
                string shippingorder = getTransferString(Request.Form["shippingorder"]);
                package["OrderNo"] = result_order;
                package["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                package["CreateTime"] = System.DateTime.Now.ToString();
                package["Remark"] = getTransferString(Request.Form["remark"]);
                package["UserId"] = userId;
                package["DepotId"] = DropDownList_DepotId.SelectedValue;
                package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast);
                package["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Received);
                package["Remark"] = upload_path_id;
                result_package = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), shippingorder, package);

                //记录添加包裹日志
                if (result_package != "")
                {
                    DataInfo packagelog_addpackage = new DataInfo();
                    packagelog_addpackage["UserId"] = userId;
                    packagelog_addpackage["PackageNo"] = result_package;
                    packagelog_addpackage["CreateTime"] = System.DateTime.Now.ToString();
                    packagelog_addpackage["Message"] = "添加包裹成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_package, DataField.PACKAGE_ACTION.Forcast.ToString(), packagelog_addpackage);
                }

                //是否添加增值服务
                int isphoto = Convert.ToInt32(Request.Form["isphoto"]);
                string result_added = null;
                if (isphoto != 0)
                {
                    IOrderService os = YouExService.GetIOrderService();
                    DataInfo added = new DataInfo();
                    added["UserId"] = userId;
                    added["DepotId"] = DropDownList_DepotId.SelectedValue;
                    added["PackageNo"] = result_package;
                    added["AccessStatus"] = 0;
                    added["PayStatus"] = 0;
                    added["ServiceCode"] = "Photo";
                    added["Request"] = getTransferString(Request.Form["photo_remark"]);
                    added["CreateTime"] = System.DateTime.Now.ToString();
                    result_added = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                    //记录添加增值服务日志
                    if (result_package != "")
                    {
                        DataInfo servicelog_addservice = new DataInfo();
                        servicelog_addservice["UserId"] = userId;
                        servicelog_addservice["ServiceNo"] = result_added;
                        servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                        servicelog_addservice["Message"] = "添加拍照服务成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_added, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                    }
                }

                //是否添加加固服务
                int isreinforce = Convert.ToInt32(Request.Form["reinforce"]);
                if (isreinforce != 0)
                {
                    IOrderService os = YouExService.GetIOrderService();
                    DataInfo added = new DataInfo();
                    added["UserId"] = userId;
                    added["DepotId"] = DropDownList_DepotId.SelectedValue;
                    added["PackageNo"] = result_package;
                    added["AccessStatus"] = 0;
                    added["PayStatus"] = 0;
                    added["ServiceCode"] = "Fasten";
                    added["Request"] = getTransferString(Request.Form["reinforce_remark"]);
                    added["CreateTime"] = System.DateTime.Now.ToString();
                    string result_isreinforce = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                    //记录添加增值服务日志
                    if (result_package != "")
                    {
                        DataInfo servicelog_addservice = new DataInfo();
                        servicelog_addservice["UserId"] = userId;
                        servicelog_addservice["ServiceNo"] = result_isreinforce;
                        servicelog_addservice["CreateTime"] = System.DateTime.Now.ToString();
                        servicelog_addservice["Message"] = "添加加固服务成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isreinforce, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                    }
                }

                //添加多个商品信息
                IPackageGoods pg = YouExService.GetIPackageGoods();
                string[] package_brand = Request.Form.GetValues("good_brand");
                string[] package_name = Request.Form.GetValues("good_name");
                string[] package_price = Request.Form.GetValues("good_price");
                string[] package_amount = Request.Form.GetValues("good_amount");
                string[] package_buyurl = Request.Form.GetValues("good_buyurl");
                for (int i = 0; i < package_name.Length; i++)
                {
                    DataInfo good = new DataInfo();
                    good["Brand"] = getTransferString(package_brand[i]);
                    good["Name"] = getTransferString(package_name[i]);
                    good["Price"] = Convert.ToDecimal(getTransferString(package_price[i]));
                    good["Count"] = getTransferString(package_amount[i]);
                    good["BuyUrl"] = getTransferString(package_buyurl[i]);
                    pg.CreatePackageGoods(result_package,good);
                }

                int explain_good = 0;
                for (int i = 0; i < clone_count; i++)
                {                        
                        if (i == 0)
                            explain_good = 0;
                        else
                            explain_good += int_calcus[i-1];

                        //生成运单信息
                        DataInfo muti_delivery = new DataInfo();
                        muti_delivery["UserId"] = userId;
                        muti_delivery["DepotId"] = DropDownList_DepotId.SelectedValue;
                        muti_delivery["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Send);
                        muti_delivery["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Blank);
                        muti_delivery["OrderNo"] = result_order;
                        muti_delivery["CreateTime"] = System.DateTime.Now.ToString();
                        muti_delivery["StorageNo"] = getUserInfoByUserId(userId)["StorageNo"].ToString();
                        muti_delivery["ShippingId"] = int_lines[i];
                        muti_delivery["NotifyType"] = Convert.ToInt32(Request.Form["type_notice_explain"]);
                        if (Convert.ToInt32(Request.Form["type_notice_explain"]) < 2)
                            muti_delivery["NotifyInfo"] = getTransferString(Request.Form["connection_explain"]).Split(',')[Convert.ToInt32(Request.Form["type_notice_explain"])];
                        muti_delivery["Remark"] = getTransferString(Request.Form["remark"]);
                        string result_delivery = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), "", muti_delivery);

                        //记录添加运单日志
                        if (result_delivery != "")
                        {
                            DataInfo deliverylog_adddelivery = new DataInfo();
                            deliverylog_adddelivery["UserId"] = userId;
                            deliverylog_adddelivery["DeliveryNo"] = result_delivery;
                            deliverylog_adddelivery["CreateTime"] = System.DateTime.Now.ToString();
                            deliverylog_adddelivery["Message"] = "添加运单成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_delivery, DataField.PACKAGE_ACTION.Blank.ToString(), deliverylog_adddelivery);
                        }

                        //生成运单地址信息
                        IPackageAddress pa = YouExService.GetIPackageAddress();
                        IUserAddress ua = YouExService.GetIUserAddress();
                        DataInfo address = ua.GetUserAddress(userId, str_ids[i]);
                        DataInfo deliveryaddress = new DataInfo();
                        deliveryaddress["UserId"] = userId;
                        deliveryaddress["DepotId"] = DropDownList_DepotId.SelectedValue;
                        deliveryaddress["Name"] = address["Name"];
                        deliveryaddress["Email"] = address["Email"];
                        deliveryaddress["Phone"] = address["Phone"];
                        deliveryaddress["Mobile"] = address["Mobile"];
                        deliveryaddress["Recipients"] = address["Recipients"];
                        deliveryaddress["Country"] = address["Country"];
                        deliveryaddress["Province"] = address["Province"];
                        deliveryaddress["City"] = address["City"];
                        deliveryaddress["Address"] = address["Address"];
                        deliveryaddress["ZipCode"] = address["ZipCode"];
                        deliveryaddress["IdCard"] = address["IdCard"];
                        deliveryaddress["IdFront"] = address["IdFront"];
                        deliveryaddress["IdBack"] = address["IdBack"];
                        bool result_dead = pa.CreatePackageAddress(result_delivery,deliveryaddress);

                        //生成运单商品信息
                        int d = 0;
                        for (int n = 0; n < int_calcus[i]; n++)
                        {
                            d = n + explain_good;
                            DataInfo good = new DataInfo();
                            good["Brand"] = getTransferString(old_brand[d]);
                            good["Name"] = getTransferString(old_name[d]);
                            good["Price"] = Convert.ToDecimal(getTransferString(old_price[d]));
                            good["Count"] = Convert.ToInt32(old_count[d]);
                            good["BuyUrl"] = getTransferString(old_buyurl[d]);
                            pg.CreatePackageGoods(result_delivery, good);
                        }
                    }
                }
                catch { Response.Write("<script>alert('提交数据出错了！');</script>"); }
                #endregion
                if (result_package != null && result_order != null)
                {
                    Response.Write("<script>alert('提交成功！');</script>");
                    Response.Redirect("./MyStock.aspx?ordertype=delivery_waiting");
                }
                else
                    Response.Write("<script>alert('提交出错了！');</script>");
            }
        }        


    }
}