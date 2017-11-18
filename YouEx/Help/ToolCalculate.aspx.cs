using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.Help
{
    using DataInfo = Dictionary<string,object>;
    public partial class ToolCalculate : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            IList<DataInfo> currencies = (new CommonService()).GetCurrency(2);
            double rate = 0;
            foreach (DataInfo currency in currencies)
            {
                rate = Convert.ToDouble(currency["ExchangeRate"]);
            }
            Label_Rate.Text = string.Format("{0:F}", rate);
            
        }




        //会员折扣转换率
        protected double getDiscount(int type) {
            double discount = 0;
            switch (type)
            {
                case 1: discount = 1; break;
                case 2: discount = 0.9; break;
                case 3: discount = 0.8; break;
            }
            return discount;
        }


        /// <summary>
        /// 计算运费
        /// </summary>
        /// <param name="totalWeight">商品总重</param>
        /// <param name="weight">首重</param>
        /// <param name="addweight">加重</param>
        /// <param name="price">首重价格</param>
        /// <param name="addprice">加重价格</param>
        /// <param name="discount">折扣</param>
        /// <param name="freeweight">不计首重</param>
        /// <returns></returns>
        public static decimal CalShippingPrice(decimal totalWeight, decimal weight, decimal addweight, decimal price, decimal addprice, double discount, int freeweight)
        {
            decimal freight = price;
            if (totalWeight > 0)
            {
                if (totalWeight -weight> 0) //大于标重
                {
                    double tmp = ((double)totalWeight - (double)weight) / (double)addweight;
                    int i = (int)tmp;
                    if (tmp > (double)i && tmp - (double)i >= 0.1) i++; //四舍五入
                    if ((int)totalWeight > freeweight && freeweight > 0) freight = (i + addweight) * (Convert.ToDecimal(discount) * addprice); //超过首重不算首重价格
                    else freight += 45 + addweight * addprice;                  
                }
                else
                {
                    double tmp = ((double)totalWeight - (double)weight) / (double)addweight;
                    int i = (int)tmp;
                    if (tmp > (double)i && tmp - (double)i >= 0.1) i++; //四舍五入
                    if ((int)totalWeight > freeweight && freeweight > 0) freight = (i + addweight) * (addprice / Convert.ToDecimal(discount)); //超过首重不算首重价格
                    else freight += (totalWeight-1) * (addprice / Convert.ToDecimal(discount));
                }
            }
            return freight;
        }

        /// <summary>
        /// 计算运费
        /// </summary>
        /// <param name="totalWeight">商品总重</param>
        /// <param name="weight">首重</param>
        /// <param name="addweight">加重</param>
        /// <param name="price">首重价格</param>
        /// <param name="addprice">加重价格</param>
        /// <param name="discount">折扣</param>
        /// <param name="freeweight">不计首重</param>
        /// <param name="vol">体积(长*宽*高)</param>
        /// <param name="heavyvol">体积重</param>
        /// <returns></returns>
        public static decimal CalShippingPrice(decimal totalWeight, decimal weight, decimal addweight, decimal price, decimal addprice, decimal discount, int freeweight, decimal vol, int heavyvol)
        {
            decimal freight = price;
            //如果重量小于8磅的话 以重量计算否则取大值
            if (totalWeight > 8 && vol != 0 && heavyvol != 0)
            {
                double volWeight = ((double)vol / (double)heavyvol); //体积重
                int i = (int)volWeight;
                if (volWeight > (double)i && volWeight - (double)i >= 0.1) i++; //四舍五入
                if (totalWeight < i)
                    totalWeight = i;
            }

            if (totalWeight - weight > 0) //大于标重
            {
                double tmp = ((double)totalWeight - (double)weight) / (double)addweight;
                int i = (int)tmp;
                if (tmp > (double)i && tmp - (double)i >= 0.1) i++; //四舍五入
                if ((int)totalWeight > freeweight && freeweight > 0) freight = (i + addweight) * addprice; //超过首重不算首重价格
                else freight += addweight * addprice;
            }
            freight = freight * discount;
            return freight;
        }

        protected void CalculatePrice(object sender, EventArgs e)
        {
            try
            {
                DataInfo user = (new UserService()).GetUserInfo(userId);
                int discount_type = Convert.ToInt32(user["Type"]);
                decimal vol = Convert.ToDecimal(TB_Length.Text) * Convert.ToDecimal(TB_Width.Text) * Convert.ToDecimal(TB_Height.Text);
                double vol_db = Convert.ToDouble(vol);
                decimal totalweight = Convert.ToDecimal(TB_Weight.Text);
                decimal addprice_wgym = 6 - Convert.ToDecimal(0.5 * (discount_type - 1));
                decimal addprice_ph = 5 - Convert.ToDecimal(0.5 * (discount_type - 1));

                double totalprice_wgym = Convert.ToDouble(CalShippingPrice(totalweight, 2, totalweight - 2, 10, addprice_wgym, 1, 0, vol, Convert.ToInt32(vol_db / 166)));
                double totalprice_ph = Convert.ToDouble(CalShippingPrice(totalweight, 2, totalweight - 2, 10, addprice_ph, 1, 0, vol, Convert.ToInt32(vol_db / 166)));
                double totalprice_nf = Convert.ToDouble(CalShippingPrice(totalweight, 2, totalweight - 2, 8, 4, 1, 0, vol, Convert.ToInt32(vol_db / 166)));
                double totalprice_usps = Convert.ToDouble(CalShippingPrice(totalweight, 10, totalweight-10 , 45, 4, 0.8, 0));

                //美元汇率
                IList<DataInfo> currencies = (new CommonService()).GetCurrency(2);
                double rate = 0;
                foreach (DataInfo currency in currencies) {
                    rate = Convert.ToDouble(currency["ExchangeRate"]);
                }

                //万国邮盟
                Label_wgym_1.Text = String.Format("{0:F}", totalprice_wgym);
                Label_wgym_1_cny.Text = String.Format("{0:F}", totalprice_wgym * rate);
                Label_wgym_2.Text = String.Format("{0:F}", totalprice_wgym * 0.9);
                Label_wgym_2_cny.Text = String.Format("{0:F}", totalprice_wgym * rate);
                Label_wgym_3.Text = String.Format("{0:F}", totalprice_wgym * 0.8);
                Label_wgym_3_cny.Text = String.Format("{0:F}", totalprice_wgym * 0.8 * rate);

                //普货线
                Label_ph_1.Text = String.Format("{0:F}", totalprice_ph);
                Label_ph_1_cny.Text = String.Format("{0:F}", totalprice_ph * rate);
                Label_ph_2.Text = String.Format("{0:F}", totalprice_ph * 0.9);
                Label_ph_2_cny.Text = String.Format("{0:F}", totalprice_ph * rate);
                Label_ph_3.Text = String.Format("{0:F}", totalprice_ph * 0.8);
                Label_ph_3_cny.Text = String.Format("{0:F}", totalprice_ph * 0.8 * rate);

                //usps线
                Label_usps_1.Text = String.Format("{0:F}", totalprice_usps);
                Label_usps_1_cny.Text = String.Format("{0:F}", totalprice_usps * rate);
                Label_usps_2.Text = String.Format("{0:F}", totalprice_usps);
                Label_usps_2_cny.Text = String.Format("{0:F}", totalprice_usps * rate);
                Label_usps_3.Text = String.Format("{0:F}", totalprice_usps);
                Label_usps_3_cny.Text = String.Format("{0:F}", totalprice_usps * rate);

                //奶粉保障线
                Label_nf_1.Text = String.Format("{0:F}", totalprice_nf);
                Label_nf_1_cny.Text = String.Format("{0:F}", totalprice_nf * rate);
                Label_nf_2.Text = String.Format("{0:F}", totalprice_nf);
                Label_nf_2_cny.Text = String.Format("{0:F}", totalprice_nf * rate);
                Label_nf_3.Text = String.Format("{0:F}", totalprice_nf);
                Label_nf_3_cny.Text = String.Format("{0:F}", totalprice_nf * rate);

            }
            catch { }
        }
    
    }
}