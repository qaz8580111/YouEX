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
    public partial class NewPackage : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList<DataInfo> addresses = (new UserService()).GetAddressList(userId);
                IList<DataInfo> countrys = (new AreaService()).GetCountryList();
                IList<DataInfo> fordeliverys = (new PackageService()).GetPackageByUserId(userId);
                IList<DataInfo> depots = (new CommonService()).GetDepot();

                //加载用户所有信息
                GetUserAllInfo(addresses, fordeliverys, countrys, depots);
                IdCardFront.ImageUrl = "../Images/Pic_User/idcard_front.png";
                IdCardBack.ImageUrl = "../Images/Pic_User/idcard_back.png";
            }
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
                    userlog_addaddress["CreateTime"] = System.DateTime.UtcNow.ToString();
                    userlog_addaddress["Message"] = "增加地址成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService().GetStorageNo(userId)), DataField.USER_ACTION.AddAddress.ToString(), userlog_addaddress);
                }
            }
            catch { Response.Redirect("../Help/ErrorPage.aspx"); }

            if (add_result > 0)
            {
                Response.Redirect("./NewPackage.aspx");
            }
            else
                Response.Redirect("../Help/ErrorPage.aspx");
        }

        //获取该用户所有信息
        protected void GetUserAllInfo(IList<DataInfo> addresses, IList<DataInfo> fordeliverys, IList<DataInfo> countrys, IList<DataInfo> depots)
        {
            string strsel = "";
            string strfordel = "";
            try
            {
                //显示出所有地区
                foreach (DataInfo country in countrys)
                {
                    DropDownList_country.Items.Add(new ListItem(country["Name"].ToString(), country["Id"].ToString()));
                }

                //获取所有仓库
                foreach (DataInfo depot in depots)
                {
                    DropDownList_DepotId.Items.Add(new ListItem(depot["Name"].ToString(), depot["DepotId"].ToString()));
                }

                //显示用户所有地址
                foreach (DataInfo address in addresses)
                {
                    string stritem = Literal_select_address.Text;
                    string addressname = address["Name"].ToString();

                    stritem = stritem.Replace("addressHere", (new AreaService()).GetAreaInfo(Convert.ToInt32(address["Country"]))["Name"].ToString() + " " +
                                    (new AreaService()).GetAreaInfo(Convert.ToInt32(address["Province"]))["Name"].ToString() + " " +
                                    (new AreaService()).GetAreaInfo(Convert.ToInt32(address["City"]))["Name"].ToString() + "(" + address["Name"].ToString() + ")");
                    stritem = stritem.Replace("nameHere", addressname);
                    strsel += stritem;
                }
                Literal_select_address.Text = strsel;
                Literal_Address_Clone.Text = strsel;

                //显示用户所有预报的包裹
                foreach (DataInfo fordelivery in fordeliverys)
                {                
                    if (fordelivery["OrderNo"] == "")
                    {
                        string stritem = Literal_ForcastDelivery.Text;
                        stritem = stritem.Replace("packagenoHere", fordelivery["PackageNo"].ToString());
                        stritem = stritem.Replace("shippingnoHere", fordelivery["ShippingNo"].ToString());
                        strfordel += stritem;
                    }
                }
                Literal_ForcastDelivery.Text = strfordel;
                Literal_ForcastDelivery_Clone.Text = strfordel;
            }
            catch { }
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&=()]", "");
            return result_transfer;
        }

        //获取时间戳
        public static long ConvertDateTimeToInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t;
        }

        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
        }

        //上传购物图片
        protected string UploadShoppingImg()
        {
            string upload_path_id = "";
            FileUpload fu;

            try
            {
                //传入每个g-box里上传图片数量
                string upload_pic_count = Request.Form["upload_pic_count"];
                string[] upload_pic_count_left = upload_pic_count.Split(',');
                int[] old_upload_pic_count_left = new int[30];
                old_upload_pic_count_left = Array.ConvertAll<string, int>(upload_pic_count_left, s => int.Parse(s));

                //传入每个g-box里第一个控件号码
                string each_first_goods_count = Request.Form["each_first_goods_count"];
                string[] each_first_goods_count_left = each_first_goods_count.Split(',');

                for (int i = 0; i < old_upload_pic_count_left.Length; i++)
                {
                    for (int j = 0; j < old_upload_pic_count_left[i]; j++)
                    {
                        //后台添加fileupload
                        fu = new FileUpload();
                        fu.ID = "FileUpload" + (Convert.ToInt32(each_first_goods_count_left[i]) + j);
                        Panel1.Controls.Add(fu);
                        if (fu.PostedFile.FileName != "" && Request.Form["Label_Upload"+(j+1)] != "" && Request.Form["Label_Upload"+(j+1)] != null)
                        {
                            //得到图片数据并创建文件信息
                            string strfilename = fu.PostedFile.FileName;
                            string suffix = strfilename.Substring(strfilename.LastIndexOf("."));
                            //得到byte数组
                            System.IO.Stream fileDataStream = fu.PostedFile.InputStream;
                            int FileUploadLength = fu.PostedFile.ContentLength;
                            byte[] fileData = new byte[FileUploadLength];
                            fileDataStream.Read(fileData, 0, FileUploadLength);
                            //创建文件
                            int result_shopping = (new FileService()).CreateFile(1, userId, "Shopping_Image_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
                            bool result_issave_shopping = (new FileService()).SaveFile(result_shopping, fileData);
                            if (result_shopping > 0 && j==0)
                                upload_path_id += result_shopping;
                            if (result_shopping > 0 && j > 0)
                                upload_path_id += "|" + result_shopping;
                        }
                    }
                    if (i != (old_upload_pic_count_left.Length - 1))
                        upload_path_id += "-";                        
                }
            }
            catch { }
            return upload_path_id;
        }

        //预报入库
        protected void ForcastDelivery(object sender, EventArgs e)
        {
            string upload_path_id = UploadShoppingImg();

            #region 左边包裹的所拥有的商品数量
            //每个包裹的商品的数量
            string calculate_left = Request.Form["left_goods_count"].ToString();
            string[] str_calcus_left = calculate_left.Split(',');
            int[] int_calcus_left = new int[10];
            int_calcus_left = Array.ConvertAll<string, int>(str_calcus_left, s => int.Parse(s));
            int clone_count_left = int_calcus_left.Length;//有多少个包裹

            //多个商品名称
            string good_name = Request.Form["good_name"].ToString();
            string[] old_name_left = good_name.Split(',');

            //多个商品品牌
            string good_brand = Request.Form["good_brand"].ToString();
            string[] old_brand_left = good_brand.Split(',');

            //多个商品价格
            string good_price = Request.Form["good_price"].ToString();
            string[] old_price_left = good_price.Split(',');

            //多个商品数量
            string good_amount = Request.Form["good_amount"].ToString();
            string[] str_counts_left = good_amount.Split(',');
            int[] old_count_left = new int[30];
            old_count_left = Array.ConvertAll<string, int>(str_counts_left, s => int.Parse(s));

            //多个商品URL
            string good_buyurl = Request.Form["good_buyurl"].ToString();
            string[] old_buyurl_left = good_buyurl.Split(',');

            //包裹运单号
            string shippingorderno_left = Request.Form["shippingorder"].ToString();
            string[] old_shippingorderno_left = shippingorderno_left.Split(',');

            //拍照
            string photo_left = Request.Form["photo"].ToString();
            string[] old_photo_left = photo_left.Split(',');
            string photo_remark_left = Request.Form["photo_remark"].ToString();
            string[] old_photo_remark_left = photo_remark_left.Split(',');

            //备注
            string remark_left = Request.Form["package_remark"].ToString();
            string[] old_remark_left = remark_left.Split(',');

            //上传图片
            string upload_img_left = upload_path_id;
            string[] old_upload_img_left = upload_img_left.Split('-');
            #endregion

            try
            {
                #region 生成预报包裹

                //添加包裹信息
                int package_good = 0;
                for (int i = 0; i < clone_count_left; i++)
                {
                    //当已预报的包裹再进行预报，删除原预报包裹
                    DataInfo package_old = (new PackageService()).GetPackageByShippingNo(old_shippingorderno_left[i]);
                    if (package_old != null)
                        (new PackageService()).DeletePackage(package_old["PackageNo"].ToString());

                    DataInfo package = new DataInfo();
                    package["OrderNo"] = "";
                    package["StorageNo"] = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                    package["CreateTime"] = System.DateTime.UtcNow.ToString();
                    package["UserId"] = userId;
                    package["DepotId"] = DropDownList_DepotId.SelectedValue;
                    package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast);
                    package["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Received);
                    package["ShippingName"] = old_upload_img_left[i];
                    package["Remark"] = old_remark_left[i];
                    string result_package = (new PackageService()).CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), old_shippingorderno_left[i], package);
                    
                    
                    //记录添加包裹日志
                    if (result_package != "")
                    {
                        DataInfo packagelog_addpackage = new DataInfo();
                        packagelog_addpackage["UserId"] = userId;
                        packagelog_addpackage["PackageNo"] = result_package;
                        packagelog_addpackage["CreateTime"] = System.DateTime.UtcNow.ToString();
                        packagelog_addpackage["Message"] = "添加包裹成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_package, DataField.PACKAGE_ACTION.Forcast.ToString(), packagelog_addpackage);
                    }

                    //是否添加增值服务
                    if (Convert.ToInt32(old_photo_left[i]) != 0)
                    {
                        IOrderService os = YouExService.GetIOrderService();
                        DataInfo added = new DataInfo();
                        added["UserId"] = userId;
                        added["DepotId"] = DropDownList_DepotId.SelectedValue;
                        added["PackageNo"] = result_package;
                        added["AccessStatus"] = 0;
                        added["PayStatus"] = 0;
                        added["ServiceCode"] = "Photo";
                        added["Request"] = old_photo_left[i];
                        added["CreateTime"] = System.DateTime.UtcNow.ToString();
                        string result_added = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                        //记录添加增值服务日志
                        if (result_package != "")
                        {
                            DataInfo servicelog_addservice = new DataInfo();
                            servicelog_addservice["UserId"] = userId;
                            servicelog_addservice["ServiceNo"] = result_added;
                            servicelog_addservice["CreateTime"] = System.DateTime.UtcNow.ToString();
                            servicelog_addservice["Message"] = "添加拍照服务成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_added, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                        }
                    }

                    //生成包裹商品信息
                    int d = 0;
                    if (i == 0)
                        package_good = 0;
                    else
                        package_good += int_calcus_left[i - 1];

                    for (int n = 0; n < int_calcus_left[i]; n++)
                    {
                        d = n + package_good;
                        DataInfo good = new DataInfo();
                        good["Brand"] = getTransferString(old_brand_left[d]);
                        good["Name"] = getTransferString(old_name_left[d]);
                        good["Price"] = Convert.ToDecimal(getTransferString(old_price_left[d]));
                        good["Count"] = Convert.ToInt32(old_count_left[d]);
                        good["BuyUrl"] = getTransferString(old_buyurl_left[d]);
                        (new PackageService()).CreatePackageGoods(result_package, good);
                    }
                }
                Response.Write("<script>alert('包裹预报成功,入库后可在库存中查看');</script>");
                #endregion
            }
            catch { }

        }

        //提交发货
        protected void SubmitDelivery(object sender, EventArgs e)
        {
            string upload_path_id = UploadShoppingImg();

            #region 左边包裹的所拥有的商品数量
                string calculate_left = Request.Form["left_goods_count"].ToString();
                string[] str_calcus_left = calculate_left.Split(',');
                int[] int_calcus_left = new int[10];
                int_calcus_left = Array.ConvertAll<string, int>(str_calcus_left, s => int.Parse(s));
                int clone_count_left = int_calcus_left.Length;
                
                //多个商品名称
                string good_name = Request.Form["good_name"].ToString();
                string[] old_name_left = good_name.Split(',');
                
                //多个商品品牌
                string good_brand = Request.Form["good_brand"].ToString();
                string[] old_brand_left = good_brand.Split(',');

                //多个商品价格
                string good_price = Request.Form["good_price"].ToString();
                string[] old_price_left = good_price.Split(',');

                //多个商品数量
                string good_amount = Request.Form["good_amount"].ToString();
                string[] str_counts_left = good_amount.Split(',');
                int[] old_count_left = new int[30];
                old_count_left = Array.ConvertAll<string, int>(str_counts_left, s => int.Parse(s));

                //多个商品URL
                string good_buyurl = Request.Form["good_buyurl"].ToString();
                string[] old_buyurl_left = good_buyurl.Split(',');
                
                //包裹运单号
                string shippingorderno_left = Request.Form["shippingorder"].ToString();
                string[] old_shippingorderno_left = shippingorderno_left.Split(',');

                //拍照
                string photo_left = Request.Form["photo"].ToString();
                string[] old_photo_left = photo_left.Split(',');
                string photo_remark_left = Request.Form["photo_remark"].ToString();
                string[] old_photo_remark_left = photo_remark_left.Split(',');

                //备注
                string remark_left = Request.Form["package_remark"].ToString();
                string[] old_remark_left = remark_left.Split(',');
                
                //上传图片
                string upload_img_left = upload_path_id;
                string[] old_upload_img_left = upload_img_left.Split('-');
            #endregion

            #region 右边运单的所拥有的商品数量
                string calculate_right = Request.Form["right_goods_count"].ToString();
                string[] str_calcus_right = calculate_right.Split(',');
                int[] int_calcus_right = new int[10];
                int_calcus_right = Array.ConvertAll<string, int>(str_calcus_right, s => int.Parse(s));
                int clone_count_right = int_calcus_right.Length;

                //多个地址簿
                string addressids = Request.Form["address_delivery"].ToString();
                string[] str_ids = addressids.Split(',');

                //多个路线
                string delivery_line = Request.Form["roadline_explain"].ToString();
                string[] str_lines = delivery_line.Split(',');
                int[] int_lines = new int[10];
                int_lines = Array.ConvertAll<string, int>(str_lines, s => int.Parse(s));

                //多个商品名称
                string delivery_name = Request.Form["delivery_name"].ToString();
                string[] old_name_right = delivery_name.Split(',');
                
                //多个商品品牌
                string delivery_brand = Request.Form["delivery_brand"].ToString();
                string[] old_brand_right = delivery_brand.Split(',');

                //多个商品价格
                string delivery_price = Request.Form["delivery_price"].ToString();
                string[] old_price_right = delivery_price.Split(',');

                //多个商品数量
                string delivery_amount = Request.Form["delivery_amount"].ToString();
                string[] str_counts_right = delivery_amount.Split(',');
                int[] old_count_right = new int[30];
                old_count_right = Array.ConvertAll<string, int>(str_counts_right, s => int.Parse(s));

                //多个商品URL
                string delivery_buyurl = Request.Form["delivery_buyurl"].ToString();
                string[] old_buyurl_right = delivery_buyurl.Split(',');

                //加固
                string reinforce_right = Request.Form["reinforce"].ToString();
                string[] old_reinforce_right = reinforce_right.Split(',');
                string reinforce_remark_right = Request.Form["reinforce_remark"].ToString();
                string[] old_reinforce_remark_right = reinforce_remark_right.Split(',');

                //提醒方式
                string notice_right = Request.Form["notice"].ToString();
                string[] old_notice_right = notice_right.Split(',');
            #endregion
            
            try
            {
                #region 生成订单
                //生成订单信息
                IOrderCenter oc = YouExService.GetIOrderCenter();
                DataInfo order = new DataInfo();
                order["UserId"] = userId;
                order["DepotId"] = DropDownList_DepotId.SelectedValue;
                order["Insurance"] = Convert.ToInt32(Request.Form["insurance_explain"]);
                order["Invoice"] = Convert.ToInt32(Request.Form["invoice_explain"]);
                order["AutoPay"] = Convert.ToInt32(Request.Form["pay_type"]);
                order["StorageNo"] = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                order["CreateTime"] = System.DateTime.UtcNow.ToString();
                order["Type"] = 1;
                order["PayStatus"] = 0;
                order["AccessStatus"] = 0;
                string result_order = oc.CreateOrder(Convert.ToInt32(DropDownList_DepotId.SelectedValue), order);

                //记录添加订单日志
                DataInfo orderlog_create = new DataInfo();
                orderlog_create["UserId"] = userId;
                orderlog_create["Event"] = "预报入库";
                orderlog_create["CreateTime"] = System.DateTime.UtcNow.ToString();
                orderlog_create["Message"] = "订单创建成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Order), result_order, DataField.ORDER_ACTION.WaitPackage.ToString(), orderlog_create);

                //添加包裹信息
                int package_good = 0;
                for (int i = 0; i < clone_count_left; i++)
                {
                    DataInfo IsForcastPackage = (new PackageService()).GetPackageByShippingNo(old_shippingorderno_left[i]);
                    if (IsForcastPackage == null)
                    {
                        IPackageCenter pc = YouExService.GetIPackageCenter();
                        DataInfo package = new DataInfo();
                        package["OrderNo"] = result_order;
                        package["StorageNo"] = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                        package["CreateTime"] = System.DateTime.UtcNow.ToString();
                        package["UserId"] = userId;
                        package["DepotId"] = DropDownList_DepotId.SelectedValue;
                        package["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Forcast);
                        package["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Received);
                        package["ShippingName"] = old_upload_img_left[i];
                        package["Remark"] = old_remark_left[i];
                        string result_package = pc.CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), old_shippingorderno_left[i], package);

                        //记录添加包裹日志
                        if (result_package != "")
                        {
                            DataInfo packagelog_addpackage = new DataInfo();
                            packagelog_addpackage["UserId"] = userId;
                            packagelog_addpackage["PackageNo"] = result_package;
                            packagelog_addpackage["CreateTime"] = System.DateTime.UtcNow.ToString();
                            packagelog_addpackage["Message"] = "添加包裹成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_package, DataField.PACKAGE_ACTION.Forcast.ToString(), packagelog_addpackage);
                        }

                        //是否添加增值服务
                        if (Convert.ToInt32(old_photo_left[i]) != 0)
                        {
                            IOrderService os = YouExService.GetIOrderService();
                            DataInfo added = new DataInfo();
                            added["UserId"] = userId;
                            added["DepotId"] = DropDownList_DepotId.SelectedValue;
                            added["PackageNo"] = result_package;
                            added["AccessStatus"] = 0;
                            added["PayStatus"] = 0;
                            added["ServiceCode"] = "Photo";
                            added["Request"] = old_photo_remark_left[i];
                            added["CreateTime"] = System.DateTime.UtcNow.ToString();
                            string result_added = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                            //记录添加增值服务日志
                            if (result_package != "")
                            {
                                DataInfo servicelog_addservice = new DataInfo();
                                servicelog_addservice["UserId"] = userId;
                                servicelog_addservice["ServiceNo"] = result_added;
                                servicelog_addservice["CreateTime"] = System.DateTime.UtcNow.ToString();
                                servicelog_addservice["Message"] = "添加拍照服务成功";
                                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_added, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                            }
                        }

                        //生成包裹商品信息
                        int d = 0;
                        if (i == 0)
                            package_good = 0;
                        else
                            package_good += int_calcus_left[i - 1];

                        for (int n = 0; n < int_calcus_left[i]; n++)
                        {
                            d = n + package_good;
                            DataInfo good = new DataInfo();
                            good["Brand"] = getTransferString(old_brand_left[d]);
                            good["Name"] = getTransferString(old_name_left[d]);
                            good["Price"] = Convert.ToDecimal(getTransferString(old_price_left[d]));
                            good["Count"] = Convert.ToInt32(old_count_left[d]);
                            good["BuyUrl"] = getTransferString(old_buyurl_left[d]);
                            (new PackageService()).CreatePackageGoods(result_package, good);
                        }
                    }
                    else
                    {
                        IsForcastPackage["OrderNo"] = result_order;
                        (new PackageService()).UpdatePackage(IsForcastPackage["PackageNo"].ToString(), IsForcastPackage);
                    }
                }

                int explain_good = 0;
                for (int i = 0; i < clone_count_right; i++)
                {
                    if (i == 0)
                        explain_good = 0;
                    else
                        explain_good += int_calcus_right[i - 1];

                    //生成运单信息
                    DataInfo muti_delivery = new DataInfo();
                    muti_delivery["UserId"] = userId;
                    muti_delivery["DepotId"] = DropDownList_DepotId.SelectedValue;
                    muti_delivery["Type"] = Convert.ToInt32(DataField.PACKAGE_TYPE.Send);
                    muti_delivery["Status"] = Convert.ToInt32(DataField.PACKAGE_STATUS.Blank);
                    muti_delivery["OrderNo"] = result_order;
                    muti_delivery["CreateTime"] = System.DateTime.UtcNow.ToString();
                    muti_delivery["StorageNo"] = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                    muti_delivery["ShippingId"] = int_lines[i];
                    muti_delivery["NotifyInfo"] = old_notice_right[i];
                    string result_delivery = (new PackageService()).CreatePackage(Convert.ToInt32(DropDownList_DepotId.SelectedValue), "", muti_delivery);

                    //记录添加运单日志
                    if (result_delivery != "")
                    {
                        DataInfo deliverylog_adddelivery = new DataInfo();
                        deliverylog_adddelivery["UserId"] = userId;
                        deliverylog_adddelivery["DeliveryNo"] = result_delivery;
                        deliverylog_adddelivery["CreateTime"] = System.DateTime.UtcNow.ToString();
                        deliverylog_adddelivery["Message"] = "添加运单成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Package), result_delivery, DataField.PACKAGE_ACTION.Blank.ToString(), deliverylog_adddelivery);
                    }

                    //生成运单地址信息
                    IPackageAddress pa = YouExService.GetIPackageAddress();
                    IUserAddress ua = YouExService.GetIUserAddress();
                    DataInfo address = ua.GetUserAddress(userId, str_ids[i]);
                    string addressname = (new AreaService()).GetAddress(Convert.ToInt32(address["Country"]),Convert.ToInt32(address["Province"]),Convert.ToInt32(address["City"]));
                    DataInfo deliveryaddress = new DataInfo();
                    deliveryaddress["UserId"] = userId;
                    deliveryaddress["DepotId"] = DropDownList_DepotId.SelectedValue;
                    deliveryaddress["Name"] = address["Name"];
                    deliveryaddress["Email"] = address["Email"];
                    deliveryaddress["Phone"] = address["Phone"];
                    deliveryaddress["Mobile"] = address["Mobile"];
                    deliveryaddress["Recipients"] = address["Recipients"];
                    deliveryaddress["Country"] = addressname.Split(' ')[0];
                    deliveryaddress["Province"] = addressname.Split(' ')[1];
                    deliveryaddress["City"] = addressname.Split(' ')[2];
                    deliveryaddress["Address"] = address["Address"];
                    deliveryaddress["ZipCode"] = address["ZipCode"];
                    deliveryaddress["IdCard"] = address["IdCard"];
                    deliveryaddress["IdFront"] = address["IdFront"];
                    deliveryaddress["IdBack"] = address["IdBack"];
                    bool result_dead = pa.CreatePackageAddress(result_delivery, deliveryaddress);

                    //是否添加加固服务
                    if (Convert.ToInt32(old_reinforce_right[i]) != 0)
                    {
                        IOrderService os = YouExService.GetIOrderService();
                        DataInfo added = new DataInfo();
                        added["UserId"] = userId;
                        added["DepotId"] = DropDownList_DepotId.SelectedValue;
                        added["PackageNo"] = result_delivery;
                        added["AccessStatus"] = 0;
                        added["PayStatus"] = 0;
                        added["ServiceCode"] = "Fasten";
                        added["Request"] = old_reinforce_remark_right[i];
                        added["CreateTime"] = System.DateTime.UtcNow.ToString();
                        string result_isreinforce = os.CreateService(Convert.ToInt32(DropDownList_DepotId.SelectedValue), added);

                        //记录添加增值服务日志
                        if (result_delivery != "")
                        {
                            DataInfo servicelog_addservice = new DataInfo();
                            servicelog_addservice["UserId"] = userId;
                            servicelog_addservice["ServiceNo"] = result_isreinforce;
                            servicelog_addservice["CreateTime"] = System.DateTime.UtcNow.ToString();
                            servicelog_addservice["Message"] = "添加加固服务成功";
                            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Service), result_isreinforce, DataField.SERVICE_ACTION.CreateNew.ToString(), servicelog_addservice);
                        }
                    }

                    //生成运单商品信息
                    int d = 0;
                    for (int n = 0; n < int_calcus_right[i]; n++)
                    {
                        d = n + explain_good;
                        DataInfo good = new DataInfo();
                        good["Brand"] = getTransferString(old_brand_right[d]);
                        good["Name"] = getTransferString(old_name_right[d]);
                        good["Price"] = Convert.ToDecimal(getTransferString(old_price_right[d]));
                        good["Count"] = Convert.ToInt32(old_count_right[d]);
                        good["BuyUrl"] = getTransferString(old_buyurl_right[d]);
                        (new PackageService()).CreatePackageGoods(result_delivery, good);
                    }
                }
                Response.Write("<script>alert('提交成功！');</script>");
                Response.Redirect("./NewMyStock.aspx?ordertype=delivery_waiting");

                #endregion
            }
            catch { Response.Write("<script>alert('提交数据出错了！');</script>"); }

        }
        

    }
}