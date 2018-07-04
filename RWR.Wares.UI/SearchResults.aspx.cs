using RWR.Wares.DSBO.PercentagesTDTableAdapters;
using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RWR.Wares.UI
{
    public partial class SearchResults : Page
    {
		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack) return;

			//_lvTooling.DataBind();
		}

		protected void _lvTooling_DataBound(object sender, EventArgs e)
		{
		}

		protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
		{
			//_odsUsersWares.DataBind();
			//DetailsView1.DataSourceID = "_odsUsersWares";
			//DetailsView1.DataBind();
		}

		protected void DetailsView1_DataBinding(object sender, EventArgs e)
		{
			string s = "s";
		}
    }
}