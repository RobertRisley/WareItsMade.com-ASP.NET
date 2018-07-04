using System.Web.UI;

namespace RWR.Wares.UI
{
	public class Utils
	{
		public static void SetDefaultSessionValues(Page page)
		{
			if (page.Session["weightVisible"] == null)
				page.Session["weightVisible"] = true;

			if (page.Session["waresVisible"] == null)
				page.Session["waresVisible"] = false;

			if (page.Session["addressVisible"] == null)
				page.Session["addressVisible"] = false;

			if (page.Session["passwordVisible"] == null)
				page.Session["passwordVisible"] = false;

			if (page.Session["ownershipVisible"] == null)
				page.Session["ownershipVisible"] = true;

			if (page.Session["toolingVisible"] == null)
				page.Session["toolingVisible"] = true;

			if (page.Session["defaultOwn"] == null)
				page.Session["defaultOwn"] = "US";

			if (page.Session["defaultTool"] == null)
				page.Session["defaultTool"] = "US";

			if (page.Session["commodityId"] == null)
				page.Session["commodityId"] = "43232309";  // Information retrieval or search software
		}
	}
}