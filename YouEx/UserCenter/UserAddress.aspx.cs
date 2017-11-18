using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using System.IO;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class UserAddress : System.Web.UI.Page
    {        
        string relative_path_front = "";
        string relative_path_back = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            IUserAddress ua = YouExService.GetIUserAddress();
            IList<DataInfo> addresses = ua.GetAddressList(userId);
            string edit_addressno = Request.QueryString["edit_addressno"];
            IFileCenter fc = YouExService.GetIFileCenter();
            bool isedit_address = false;

            if (!IsPostBack)
            { 
                //显示出所有地区
                IList<DataInfo> countrys = (new AreaService()).GetCountryList();
                foreach (DataInfo country in countrys)
                {
                    DropDownList_country.Items.Add(new ListItem(country["Name"].ToString(), country["Id"].ToString()));
                }
                /*if (addresses.Count == 0)
                    Label_IsFirst.Text = "isfirst";*/
            }

            if (addresses.Count == 0)
            {
                Label_ShowTable.Text = "none";
            }
            string str_address = "";
            foreach (DataInfo address in addresses)
            {
                string str_addressItem = Literal_AllAddress.Text;
                str_addressItem = str_addressItem.Replace("nameHere", address["Name"].ToString());
                str_addressItem = str_addressItem.Replace("recipientsHere", address["Recipients"].ToString());
                str_addressItem = str_addressItem.Replace("countryHere", getAreaByAreaId(Convert.ToInt32(address["Country"])));
                str_addressItem = str_addressItem.Replace("provinceHere", getAreaByAreaId(Convert.ToInt32(address["Province"])));
                str_addressItem = str_addressItem.Replace("cityHere", getAreaByAreaId(Convert.ToInt32(address["City"])));
                str_addressItem = str_addressItem.Replace("addressHere", address["Address"].ToString());
                str_addressItem = str_addressItem.Replace("mobileHere", address["Mobile"].ToString());
                str_addressItem = str_addressItem.Replace("zipcodeHere", address["ZipCode"].ToString());
                str_addressItem = str_addressItem.Replace("idcardHere", address["IdCard"].ToString());
                str_addressItem = str_addressItem.Replace("iseditHere", isedit_address.ToString());
                str_address += str_addressItem;
            }
            Literal_AllAddress.Text = str_address;
            IdCardFront.ImageUrl = "../Images/Pic_User/idcard_front.png";
            IdCardBack.ImageUrl = "../Images/Pic_User/idcard_back.png";

            if (edit_addressno != null) {
                try
                {
                    isedit_address = true;
                    string edit_addressid = edit_addressno;
                    DataInfo address = ua.GetUserAddress(userId, edit_addressid);
                    string str_addressItem = Literal_Address.Text;

                    str_addressItem = str_addressItem.Replace("nameHere", address["Name"].ToString());
                    str_addressItem = str_addressItem.Replace("recipientsHere", address["Recipients"].ToString());
                    str_addressItem = str_addressItem.Replace("countryHere", (address["Country"]).ToString());
                    str_addressItem = str_addressItem.Replace("provinceHere", (address["Province"]).ToString());
                    str_addressItem = str_addressItem.Replace("cityHere", (address["City"]).ToString());
                    str_addressItem = str_addressItem.Replace("addressHere", address["Address"].ToString());
                    str_addressItem = str_addressItem.Replace("mobileHere", address["Mobile"].ToString());
                    str_addressItem = str_addressItem.Replace("zipcodeHere", address["ZipCode"].ToString());
                    str_addressItem = str_addressItem.Replace("idcardHere", address["IdCard"].ToString());
                    str_addressItem = str_addressItem.Replace("iseditHere", isedit_address.ToString());
                    Literal_Address.Text = str_addressItem;

                    //byte[]输出图片img并显示图片
                    //uploadPicFront.PostedFile.ImageUrl = (new FileService()).LoadFile(Convert.ToInt32(address["IdFront"]));
                    IdCardFront.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", address["IdFront"].ToString());
                    IdCardBack.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceBack.aspx?idback=", address["IdBack"].ToString());                    
                    //显示出相关省份
                    IList<DataInfo> provinces = (new AreaService()).GetAreaList(Convert.ToInt32(address["Country"]));
                    foreach (DataInfo province in provinces)
                    {
                        DropDownList_province.Items.Add(new ListItem(province["Name"].ToString(), province["Id"].ToString()));
                    }
                    //显示出相关城市
                    IList<DataInfo> cities = (new AreaService()).GetAreaList(Convert.ToInt32(address["Province"]));
                    foreach (DataInfo city in cities)
                    {
                        DropDownList_city.Items.Add(new ListItem(city["Name"].ToString(), city["Id"].ToString()));
                    }
                }
                catch { Response.Redirect("../Help/ErrorPage.aspx"); }
            }

        }

        //根据areaid获取area
        protected string getAreaByAreaId(int areaid)
        {
            IAreaCenter ac = YouExService.GetIAreaCenter();
            DataInfo address = ac.GetAreaInfo(areaid);
            string name = address["Name"].ToString();
            return name;
        }

        //上传图片
        protected void uploadPic()
        {
            //图片上传
            string strfront = uploadPicFront.PostedFile.FileName;
            string strback = uploadPicBack.PostedFile.FileName;
            string newName = Guid.NewGuid().ToString();
            string absolute_path = Server.MapPath("~\\YouEx_Out_Images\\");
            //身份证正面
            if (strfront != "")
            {
                bool fileOK = false;
                int i_front = strfront.LastIndexOf(".");
                string suffix_front = strfront.Substring(i_front);

                string newFileName_front = absolute_path + newName + "_front" + suffix_front;
                relative_path_front = "../YouEx_Out_Images/" + newName + "_front" + suffix_front;
                if (uploadPicFront.HasFile)
                {
                    String[] allowedExtensions = { ".gif", ".png", ".bmp", ".jpg", ".txt" };
                    for (int j = 0; j < allowedExtensions.Length; j++)
                    {
                        if (suffix_front == allowedExtensions[j])
                        {
                            fileOK = true;
                        }
                    }
                }
                if (fileOK)
                {
                    uploadPicFront.PostedFile.SaveAs(newFileName_front);
                }
            }
            //身份证反面
            if (strback != "")
            {
                bool fileOK = false;
                int i_back = strback.LastIndexOf(".");
                string suffix_back = strback.Substring(i_back);

                string newFileName_back = absolute_path + newName + "_back" + suffix_back;
                relative_path_back = "../YouEx_Out_Images/" + newName + "_back" + suffix_back;
                if (uploadPicBack.HasFile)
                {
                    String[] allowedExtensions = { ".gif", ".png", ".bmp", ".jpg", ".txt" };
                    for (int j = 0; j < allowedExtensions.Length; j++)
                    {
                        if (suffix_back == allowedExtensions[j])
                        {
                            fileOK = true;
                        }
                    }
                }
                if (fileOK)
                {
                    uploadPicBack.PostedFile.SaveAs(newFileName_back);
                }
            }
        }

        //新增地址簿
        protected void addAddress(object sender, EventArgs e)
        {
            int add_result = 0;
            int userId = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            String[] allowedExtensions = { ".jpg", ".png", ".gif", ".bmp" };
                   
            try
            {
                //得到图片数据并创建文件信息
                string strfront = uploadPicFront.PostedFile.FileName;
                string suffix_front = strfront.Substring(strfront.LastIndexOf("."));
                int result_idcard_front = 0;
                //得到证件正面byte数组
                System.IO.Stream fileDataStream_front = uploadPicFront.PostedFile.InputStream;
                int fileLength_Front = uploadPicFront.PostedFile.ContentLength;
                byte[] fileData_Front = new byte[fileLength_Front];
                fileDataStream_front.Read(fileData_Front, 0, fileLength_Front);
                //创建证件正面文件
                result_idcard_front = (new FileService()).CreateFile(1, userId, "IDCard_Front_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_F" + suffix_front, "IdCard");
                bool result_issave_front = (new FileService()).SaveFile(result_idcard_front, fileData_Front);

                string strback = uploadPicBack.PostedFile.FileName;
                string suffix_back = strback.Substring(strback.LastIndexOf("."));
                int result_idcard_back = 0;
                //得到证件反面byte数组
                System.IO.Stream fileDataStream_back = uploadPicBack.PostedFile.InputStream;
                int fileLength_Back = uploadPicBack.PostedFile.ContentLength;
                byte[] fileData_Back = new byte[fileLength_Back];
                fileDataStream_back.Read(fileData_Back, 0, fileLength_Back);
                //创建证件反面文件
                result_idcard_back = (new FileService()).CreateFile(1, userId, "IDCard_Back_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_B" + suffix_back, "IdCard");
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
                Response.Redirect("./UserAddress.aspx");
            }
            catch {  }
            
        }

        //修改指定地址簿信息
        protected void updateAddress(object sender, EventArgs e)
        {
            bool result_update = false;
            string edit_addressno = getTransferString(Request.QueryString["edit_addressno"]);
            int userId = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            try
            {
                IUserAddress ua = YouExService.GetIUserAddress();
                DataInfo address = new DataInfo();
                //地址簿路径                
                string address_name = getTransferString(TB_Address_Name.Text);
                DataInfo old_address = ua.GetUserAddress(userId, edit_addressno);
                
                if (relative_path_front == "")
                    relative_path_front = old_address["IdFront"].ToString();
                if (relative_path_back == "")
                    relative_path_back = old_address["IdBack"].ToString();

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

                String[] allowedExtensions = { ".jpg", ".png", ".gif", ".bmp" };
                string strfront = uploadPicFront.PostedFile.FileName;
                if (strfront != "")
                {
                    string suffix_front = strfront.Substring(strfront.LastIndexOf("."));
                    int result_idcard_front = 0;

                    //得到证件正面byte数组
                    System.IO.Stream fileDataStream_front = uploadPicFront.PostedFile.InputStream;
                    int fileLength_Front = uploadPicFront.PostedFile.ContentLength;
                    byte[] fileData_Front = new byte[fileLength_Front];
                    fileDataStream_front.Read(fileData_Front, 0, fileLength_Front);
                    //创建证件正面文件
                    result_idcard_front = (new FileService()).CreateFile(1, userId, "IDCard_Front_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_F" + suffix_front, "IdCard");
                    bool result_issave_front = (new FileService()).SaveFile(result_idcard_front, fileData_Front);
                    address.Add("IdFront", getTransferString(result_idcard_front.ToString()));
                }
                string strback = uploadPicBack.PostedFile.FileName;
                if (strback != "")
                {
                    string suffix_back = strback.Substring(strback.LastIndexOf("."));
                    int result_idcard_back = 0;

                    System.IO.Stream fileDataStream_back = uploadPicBack.PostedFile.InputStream;
                    int fileLength_Back = uploadPicBack.PostedFile.ContentLength;
                    byte[] fileData_Back = new byte[fileLength_Back];
                    fileDataStream_back.Read(fileData_Back, 0, fileLength_Back);
                    //创建证件反面文件
                    result_idcard_back = (new FileService()).CreateFile(1, userId, "IDCard_Back_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + "_B" + suffix_back, "IdCard");
                    bool result_issave_back = (new FileService()).SaveFile(result_idcard_back, fileData_Back);
                    address.Add("IdBack", getTransferString(result_idcard_back.ToString()));
                }
                result_update = ua.UpdateUserAddress(userId, edit_addressno, address);

                //记录修改地址簿日志
                if (result_update)
                {
                    DataInfo userlog_addaddress = new DataInfo();
                    userlog_addaddress["UserId"] = userId;
                    userlog_addaddress["AddressName"] = edit_addressno;
                    userlog_addaddress["CreateTime"] = System.DateTime.Now.ToString();
                    userlog_addaddress["Message"] = "修改地址成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService().GetStorageNo(userId)), DataField.USER_ACTION.AddAddress.ToString(), userlog_addaddress);
                }
                Response.Redirect("./UserAddress.aspx?edit_addressno=" + getTransferString(TB_Address_Name.Text));
            }
            catch {  }

                       
            
        }

        //获取时间戳
        public static long ConvertDateTimeToInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t;
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //updatepannel ajax 根据地区显示省份
        protected void DropDownList_country_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList_province.Items.Clear();
            DropDownList_province.Items.Add(new ListItem("--请选择省份--", "0"));
            DropDownList_city.Items.Clear();
            DropDownList_city.Items.Add(new ListItem("--请选择城市--", "0"));
            int countryid = Convert.ToInt32(DropDownList_country.SelectedValue);
            IList<DataInfo> provinces = (new AreaService()).GetAreaList(countryid);
            foreach (DataInfo province in provinces)
            {
                DropDownList_province.Items.Add(new ListItem(province["Name"].ToString(), province["Id"].ToString()));
            }
        }

        //updatepannel ajax 根据省份显示城市
        protected void DropDownList_province_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList_city.Items.Clear();
            DropDownList_city.Items.Add(new ListItem("--请选择城市--", "0"));
            int provinceid = Convert.ToInt32(DropDownList_province.SelectedValue);
            IList<DataInfo> cities = (new AreaService()).GetAreaList(provinceid);
            foreach (DataInfo city in cities)
            {
                DropDownList_city.Items.Add(new ListItem(city["Name"].ToString(), city["Id"].ToString()));
            }
        }
    }
}