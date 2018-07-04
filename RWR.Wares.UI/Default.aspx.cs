using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RWR.Wares.UI
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            _chkWeights.Checked = Boolean.Parse(Session["weightVisible"].ToString());
            weight.Visible = Boolean.Parse(Session["weightVisible"].ToString());

            _tbEnt.Attributes.Add("onkeypress", "return numeralsOnly(event)");
            _tbCap.Attributes.Add("onkeypress", "return numeralsOnly(event)");
            _tbLab.Attributes.Add("onkeypress", "return numeralsOnly(event)");
            _tbLan.Attributes.Add("onkeypress", "return numeralsOnly(event)");
        }

        private void _ddlSegments_Init()
        {
            _ddlSegments.Enabled = false;
            _ddlSegments.Items.Clear();
            var listItemS = new ListItem("-- select a Segment --", "-1", true);
            _ddlSegments.Items.Add(listItemS);

            _ddlSegments.DataSourceID = "_odsSegments";
            _ddlSegments.DataBind();
            _ddlSegments.Enabled = true;
        }

        protected void _ddlSegments_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!IsPostBack) return;

            _ddlWares_Init();
            _ddlClasses_Init();
            _ddlFamilys_Init();

            _ddlFamilys.DataSourceID = "_odsFamilys";
            _ddlFamilys.DataBind();
            _ddlFamilys.Enabled = true;
        }

        private void _ddlFamilys_Init()
        {
            _ddlFamilys.Enabled = false;
            _ddlFamilys.Items.Clear();
            var listItemF = new ListItem("-- select a Family --", "-1", true);
            _ddlFamilys.Items.Add(listItemF);
        }

        protected void _ddlFamilys_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!IsPostBack) return;

            _ddlWares_Init();
            _ddlClasses_Init();

            _ddlClasses.DataSourceID = "_odsClasses";
            _ddlClasses.DataBind();
            _ddlClasses.Enabled = true;
        }

        private void _ddlClasses_Init()
        {
            _ddlClasses.Enabled = false;
            _ddlClasses.Items.Clear();
            var listItemC = new ListItem("-- select a Class --", "-1", true);
            _ddlClasses.Items.Add(listItemC);
        }

        protected void _ddlClasses_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!IsPostBack) return;

            _ddlWares_Init();
            _ddlWares.DataSourceID = "_odsWares";
            _ddlWares.DataBind();
            wares.Visible = true;
            Session["waresVisible"] = true;
        }

        private void _ddlWares_Init()
        {
            wares.Visible = false;
            _ddlWares.Items.Clear();
			var listItemW = new ListItem("-- select a Ware to search for --", "-1", true);
            _ddlWares.Items.Add(listItemW);
        }

        protected void _ddlCountrys_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
                _ddlCountrys.Items.FindByValue("US").Selected = true;
        }

        protected void _chkWeights_CheckedChanged(object sender, EventArgs e)
        {
            if (!IsPostBack) return;

            weight.Visible = _chkWeights.Checked;
            Session["weightVisible"] = weight.Visible;
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(_tbWareName.Text)) return;

            _ddlSegments_Init();
            _ddlFamilys_Init();
            _ddlClasses_Init();
            _ddlWares_Init();

            _ddlWares.DataSourceID = "_odsSearch";
            _ddlWares.DataBind();
            wares.Visible = true;
            Session["waresVisible"] = true;
            _ddlWares.SelectedIndexChanged +=_ddlWares_SelectedIndexChanged;
        }

        protected void _ddlWares_SelectedIndexChanged(object sender, EventArgs e)
        {
			if (!IsPostBack || _ddlWares.SelectedItem.Value.Equals("-1")) return;

			Session["countryId"] = _ddlCountrys.SelectedItem.Value;
			Session["OwnWeight"] = _tbEnt.Text;
			Session["CapWeight"] = _tbCap.Text;
			Session["LabWeight"] = _tbLab.Text;
			Session["LanWeight"] = _tbLan.Text;
			Session["searchCommodityId"] = _ddlWares.SelectedItem.Value;

			Response.Redirect("~/SearchResults.aspx");
		}
    }
}