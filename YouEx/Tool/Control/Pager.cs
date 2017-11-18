using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.ComponentModel;

namespace WebSite.Tool.Control
{
    [ToolboxData("<{0}:Pager runat=\"server\"></{0}:Pager>")]
    public class Pager : System.Web.UI.WebControls.WebControl
    {
        public Pager()
            : base(HtmlTextWriterTag.Ul)
        {
        }
        /// <summary>
        /// 当前页索引
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(0)]
        public int PageIndex
        {
            get
            {
                object o = ViewState["PageIndex"];
                if (o != null) return (int)o;
                else return 0;
            }
            set
            {
                ViewState["PageIndex"] = value;
            }
        }
        /// <summary>
        /// 每页（分页）内容数
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(0)]
        public int PageSize
        {
            get
            {
                object o = ViewState["PageSize"];
                if (o != null) return (int)o;
                else return 0;
            }
            set
            {
                ViewState["PageSize"] = value;
            }
        }
        /// <summary>
        /// 记录总数
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(0)]
        public int RecoardCount
        {
            get
            {
                object o = ViewState["RecoardCount"];
                if (o != null) return (int)o;
                else return 0;
            }
            set
            {
                ViewState["RecoardCount"] = value;
            }
        }
        /// <summary>
        /// 初始页编号，即默认第一页的编号
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(0)]
        public int InitialPagerNo
        {
            get
            {
                object o = ViewState["InitialPagerNo"];
                if (o != null) return (int)o;
                else return 0;
            }
            set
            {
                ViewState["InitialPagerNo"] = value;
            }
        }
        /// <summary>
        /// 默认页（即无页索引值或页索引值不合法时的默认页）
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue("")]
        public string DefaultPage
        {
            get
            {
                object o = ViewState["DefaultPage"];
                if (o != null) return (string)o;
                else return string.Empty;
            }
            set
            {
                ViewState["DefaultPage"] = value;
            }
        }
        /// <summary>
        /// 页面跳转地址格式化字符串
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue("")]
        public string UrlPattern
        {
            get
            {
                object o = ViewState["UrlPattern"];
                if (o != null) return (string)o;
                else return string.Empty;
            }
            set
            {
                ViewState["UrlPattern"] = value;
            }
        }
        /// <summary>
        /// 是否智能显示上下页
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(true)]
        public bool AutoPrevNext
        {
            get
            {
                object o = ViewState["AutoPrevNext"];
                if (o != null) return (bool)o;
                else return true;
            }
            set
            {
                ViewState["AutoPrevNext"] = value;
            }
        }
        /// <summary>
        /// 上一页的显示文本
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue("上一页")]
        public string PrevText
        {
            get
            {
                object o = ViewState["PrevText"];
                if (o != null) return (string)o;
                else return string.Empty;
            }
            set
            {
                ViewState["PrevText"] = value;
            }
        }
        /// <summary>
        /// 下一页的显示文本
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue("下一页")]
        public string NextText
        {
            get
            {
                object o = ViewState["NextText"];
                if (o != null) return (string)o;
                else return string.Empty;
            }
            set
            {
                ViewState["NextText"] = value;
            }
        }
        /// <summary>
        /// 是否允许显示跳转输入框和跳转按钮
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(true)]
        public bool AllowGo
        {
            get
            {
                object o = ViewState["AllowGo"];
                if (o != null) return (bool)o;
                else return true;
            }
            set
            {
                ViewState["AllowGo"] = value;
            }
        }
        /// <summary>
        /// 是否允许显示分页链接
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue(true)]
        public bool AllowPageIndex
        {
            get
            {
                object o = ViewState["AllowPageIndex"];
                if (o != null) return (bool)o;
                else return true;
            }
            set
            {
                ViewState["AllowPageIndex"] = value;
            }
        }
        /// <summary>
        /// 页面统计（{0}-当前页，{1}-页总数，{2}-记录总数），为空不显示
        /// </summary>
        [Bindable(false), Category("Appearance"), DefaultValue("")]
        public string PageStatistics
        {
            get
            {
                object o = ViewState["PageStatistics"];
                if (o != null) return (string)o;
                else return string.Empty;
            }
            set
            {
                ViewState["PageStatistics"] = value;
            }
        }
        /*public override ControlCollection Controls
        {
            get
            {
                EnsureChildControls();
                return base.Controls;
            }
        }
        override protected void CreateChildControls()
        {
            System.Web.UI.HtmlControls.HtmlInputText textbox = new System.Web.UI.HtmlControls.HtmlInputText();
            Controls.Add(textbox);
            System.Web.UI.HtmlControls.HtmlInputButton button = new System.Web.UI.HtmlControls.HtmlInputButton();
            Controls.Add(button);
            button.Value = "GO";
        }
        private void PrepareControlHierarchy()
        {
            //初始化控件
        }*/
        override protected void Render(HtmlTextWriter writer)
        {
            //PrepareControlHierarchy();
            RenderBeginTag(writer);

            if (RecoardCount > PageSize)
            {
                //分页数
                int pageNum = RecoardCount / PageSize;
                if (RecoardCount % PageSize > 0) pageNum++;
                if (PageIndex < InitialPagerNo) PageIndex = InitialPagerNo;
                //RenderChildren(writer);
                //======================页数统计=========================
                if (PageStatistics != string.Empty)
                {
                    writer.WriteBeginTag("li");
                    writer.WriteAttribute("class", "static");
                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Write(string.Format(PageStatistics, PageIndex, pageNum, RecoardCount)); //页面统计格式化
                    writer.WriteEndTag("li");
                }
                //===========================上一页================================
                if (AutoPrevNext)
                {
                    if (PageIndex > 1)
                    {
                        writer.WriteBeginTag("li");
                        writer.Write(HtmlTextWriter.TagRightChar);

                        writer.WriteBeginTag("a");
                        if ((PageIndex - 1) == InitialPagerNo && DefaultPage != string.Empty) writer.WriteAttribute("href", DefaultPage);
                        else writer.WriteAttribute("href", string.Format(UrlPattern, PageIndex - 1));
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write(PrevText);
                        writer.WriteEndTag("a");
                        writer.WriteEndTag("li");
                    }
                }
                else
                {
                    writer.WriteBeginTag("li");
                    if (PageIndex <= InitialPagerNo) writer.WriteAttribute("class", "off");
                    writer.Write(HtmlTextWriter.TagRightChar);
                    if (PageIndex <= InitialPagerNo) writer.Write(PrevText);
                    else
                    {
                        writer.WriteBeginTag("a");
                        if ((PageIndex - 1) == InitialPagerNo && DefaultPage != string.Empty) writer.WriteAttribute("href", DefaultPage);
                        else writer.WriteAttribute("href", string.Format(UrlPattern, PageIndex - 1));
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write(PrevText);
                        writer.WriteEndTag("a");
                    }
                    writer.WriteEndTag("li");
                }
                //==========================分页=====================================
                if (AllowPageIndex)
                {
                    #region [分页处理]
                    int i = PageIndex / 5;
                    if (i > 0)
                    {
                        int tmp = InitialPagerNo;
                        //if ((i * 5 - 5) > 0) tmp = i * 5 - 5;
                        writer.WriteBeginTag("li");
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.WriteBeginTag("a");
                        writer.WriteAttribute("href", string.Format(UrlPattern, tmp));
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write(tmp);
                        writer.WriteEndTag("a");
                        writer.WriteEndTag("li");
                        //=============省略号================
                        writer.WriteBeginTag("li");
                        writer.WriteAttribute("class", "off");
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write("...");
                        writer.WriteEndTag("li");
                    }
                    //找出共7条记录
                    for (int s = i * 5; s < i * 5 + 7; s++)
                    {
                        if (s != PageIndex && s != 0 && s <= pageNum)
                        {
                            writer.WriteBeginTag("li");
                            writer.Write(HtmlTextWriter.TagRightChar);
                            writer.WriteBeginTag("a");
                            writer.WriteAttribute("href", string.Format(UrlPattern, s));
                            writer.Write(HtmlTextWriter.TagRightChar);
                            writer.Write(s);
                            writer.WriteEndTag("a");
                            writer.WriteEndTag("li");
                        }
                        if (s == PageIndex)
                        {
                            writer.WriteBeginTag("li");
                            writer.WriteAttribute("class", "off");
                            writer.Write(HtmlTextWriter.TagRightChar);
                            writer.Write(PageIndex);
                            writer.WriteEndTag("li");
                        }
                    }
                    if ((i * 5 + 7) < pageNum)
                    {
                        //=============省略号================
                        writer.WriteBeginTag("li");
                        writer.WriteAttribute("class", "off");
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write("...");
                        writer.WriteEndTag("li");

                        writer.WriteBeginTag("li");
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.WriteBeginTag("a");
                        writer.WriteAttribute("href", string.Format(UrlPattern, pageNum));
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write(pageNum);
                        writer.WriteEndTag("a");
                        writer.WriteEndTag("li");
                    }
                    #endregion
                }
                //=============================下一页=================================
                if (AutoPrevNext)
                {
                    if (PageIndex < pageNum)
                    {
                        writer.WriteBeginTag("li");
                        writer.Write(HtmlTextWriter.TagRightChar);
                        writer.Write("<a href=\"" + string.Format(UrlPattern, PageIndex + 1) + "\">" + NextText + "</a>");
                        writer.WriteEndTag("li");
                    }
                }
                else
                {
                    writer.WriteBeginTag("li");
                    if (PageIndex >= pageNum) writer.WriteAttribute("class", "off");
                    writer.Write(HtmlTextWriter.TagRightChar);
                    if (PageIndex >= pageNum) writer.Write(NextText);
                    else writer.Write("<a href=\"" + string.Format(UrlPattern, PageIndex + 1) + "\">" + NextText + "</a>");
                    writer.WriteEndTag("li");
                }
                //=============================跳转===================================
                if (AllowGo)
                {
                    writer.WriteBeginTag("li");
                    writer.WriteAttribute("class", "page_input");
                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Write("<input type=\"text\" id=\"" + this.ClientID + "$ctInput\" size=\"2\" value=\"" + (PageIndex + 1 > pageNum ? 1 : PageIndex + 1) + "\" />");
                    writer.WriteEndTag("li");

                    writer.WriteBeginTag("li");
                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.WriteBeginTag("a");
                    writer.WriteAttribute("class", "page_go");
                    writer.WriteAttribute("href", "javascript:window.location.href='" + string.Format(UrlPattern, "'+document.getElementById('" + this.ClientID + "$ctInput').value;"));
                    writer.Write(HtmlTextWriter.TagRightChar);
                    writer.Write("GO");
                    writer.WriteEndTag("a");
                    writer.WriteEndTag("li");
                }
            }
            RenderEndTag(writer);
        }
    }
}
