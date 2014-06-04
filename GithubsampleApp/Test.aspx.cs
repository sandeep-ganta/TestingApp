using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization;
using System.Net;
using System.IO; 
using System.Web.Services;
using System.Web.Script.Services;
using System.Configuration;
using System.Xml;
using System.Web.Script.Serialization;

namespace GithubsampleApp
{
    public partial class Test : System.Web.UI.Page
    {
        static string HttpGet(string url)
        {
            HttpWebRequest req = WebRequest.Create(url) as HttpWebRequest;
            string result = null;
            using (HttpWebResponse resp = req.GetResponse() as HttpWebResponse)
            {
                StreamReader reader = new StreamReader(resp.GetResponseStream());
                result = reader.ReadToEnd();
            }
            return result;
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rd_delete.Checked = false;
                rd_modify.Checked = false;
                rd_add.Checked = false;
            }

        }
        public class RadInfoCPT
        {
            public string CPTcode { get; set; }
            public string RadInfoPage { get; set; }
            public string Radinfourl { get; set; }
        }
        [WebMethod]
        [ScriptMethod]
        public static List<string> GetCPTcodeslist()
        {
            var a = "";
            string sl = string.Empty;
            string Serverurl = ConfigurationManager.AppSettings["ServerUrlsss Newchange"] + "/Getcptcodes";
            string Result = string.Empty;
            Result = HttpGet(Serverurl);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(Result);
            XmlNodeList idNodes = doc.GetElementsByTagName("string");

            //ACRserviceref.Service1Client obj = new ACRserviceref.Service1Client();
            //List<string> result = obj.Getcptcodes().ToList();
            var result = new List<string>();
            foreach (XmlNode node in idNodes)
                result.Add(node.InnerText);
            return result;
        }

        /// <summary>
        /// To Get Particular Cpt Code Details
        /// </summary>
        /// <param name="cptcode"></param>
        /// <returns></returns>

        [WebMethod]
        [ScriptMethod]
        public static RadInfoCPT GetCptinfobased(string cptcode)
        {
            string Serverurl = ConfigurationManager.AppSettings["ServerUrl"] + "/GetAllRadinfocpt?Cptcode=" + cptcode + "";
            string Result = string.Empty;
            Result = HttpGet(Serverurl);
            var result = new RadInfoCPT();

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(Result);
            var CPTcode = doc.GetElementsByTagName("CPTcode");
            foreach (XmlNode node in CPTcode)
                result.CPTcode = node.InnerText;

            var RadInfoPage = doc.GetElementsByTagName("RadInfoPage");
            foreach (XmlNode node in RadInfoPage)
                result.RadInfoPage = node.InnerText;

            var Radinfourl = doc.GetElementsByTagName("Radinfourl");
            foreach (XmlNode node in Radinfourl)
                result.Radinfourl = node.InnerText;

            // ACRserviceref.Service1Client obj = new ACRserviceref.Service1Client();
            // ACRserviceref.RadInfoCPT result = obj.GetAllRadinfocpt(cptcode); 
            return result;
        }

        /// <summary>
        /// To Save New Cpt Code Details
        /// </summary>
        /// <param name="radinfo"></param>
        /// <returns></returns>

        [WebMethod]
        [ScriptMethod]
        public static string AddNewCptinfo(RadInfoCPT radinfo)
        {
            var cptinfo = new RadInfoCPT();
            cptinfo.CPTcode = radinfo.CPTcode;
            cptinfo.RadInfoPage = radinfo.RadInfoPage;
            cptinfo.Radinfourl = radinfo.Radinfourl;

            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            string serOut = jsonSerializer.Serialize(radinfo);

            string strUri = ConfigurationManager.AppSettings["ServerUrl"] + "/SaveRadinofo?savecptinfo=" + serOut + "";
            string result = string.Empty; string check = string.Empty;
            check = HttpGet(strUri);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(check);
            var Check = doc.GetElementsByTagName("string");
            foreach (XmlNode node in Check)
                result = node.InnerText;
            // ACRserviceref.Service1Client obj = new ACRserviceref.Service1Client();
            // bool check = obj.SaveRadinofo(radinfo);  
            return result;
        }

        /// <summary>
        /// To Delte Cpt Code with Details
        /// </summary>
        /// <param name="radinfo"></param>
        /// <returns></returns>

        [WebMethod]
        [ScriptMethod]
        public static string Deletecptinfo(RadInfoCPT radinfo)
        {
            var cptinfo = new RadInfoCPT();
            cptinfo.CPTcode = radinfo.CPTcode;
            cptinfo.RadInfoPage = radinfo.RadInfoPage;
            cptinfo.Radinfourl = radinfo.Radinfourl;

            string Serverurl = ConfigurationManager.AppSettings["ServerUrl"] + "/DeleteRadinfo?Cptcodeinfo=" + cptinfo.CPTcode + "";
            string Result, check = string.Empty; string result = string.Empty;
            Result = HttpGet(Serverurl);
            //var result = new RadInfoCPT();

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(Result);
            var Check = doc.GetElementsByTagName("string");
            foreach (XmlNode node in Check)
                result = node.InnerText;

            // ACRserviceref.Service1Client obj = new ACRserviceref.Service1Client();
            // bool check = obj.DeleteRadinfo(radinfo.CPTcode); 
            return result;
        }

        /// <summary>
        /// To Modify/Update Cpt Code Details
        /// </summary>
        /// <param name="radinfo"></param>
        /// <returns></returns>

        [WebMethod]
        [ScriptMethod]
        public static string Updatecptinfo(RadInfoCPT radinfo)
        {
            var cptinfo = new RadInfoCPT();
            cptinfo.CPTcode = radinfo.CPTcode;
            cptinfo.RadInfoPage = radinfo.RadInfoPage;
            cptinfo.Radinfourl = radinfo.Radinfourl;

            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            string serOut = jsonSerializer.Serialize(radinfo);

            string strUri = ConfigurationManager.AppSettings["ServerUrl"] + "/UpdateRadinofo?updatecptinfo=" + serOut + "";
            string check = string.Empty; string result = string.Empty;
            check = HttpGet(strUri);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(check);
            var Check = doc.GetElementsByTagName("string");
            foreach (XmlNode node in Check)
                result = node.InnerText;

            // ACRserviceref.Service1Client obj = new ACRserviceref.Service1Client();
            // bool check = obj.UpdateRadinofo(radinfo); 
            return result;
        }
    }
}