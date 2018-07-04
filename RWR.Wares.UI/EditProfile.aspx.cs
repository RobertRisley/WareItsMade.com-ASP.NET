using RWR.Wares.DSBO.PercentagesTDTableAdapters;
using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RWR.Wares.UI
{
    public partial class EditProfile : Page
    {
		protected void Page_Load(object sender, EventArgs e)
		{
			if (IsPostBack) return;

			_ddlCountrys.DataBind();
			_ddlCountrys.Items.FindByValue("US").Selected = true;
			Subdivision_Init();

			_chkOwnership.Checked = Boolean.Parse(Session["ownershipVisible"].ToString());
			ownership.Visible = Boolean.Parse(Session["ownershipVisible"].ToString());
			_tbPercentOwn.Attributes.Add("onkeypress", "return numeralsOnly(event)");
			_ddlCountrysOwn.DataBind();

			_chkTooling.Checked = Boolean.Parse(Session["toolingVisible"].ToString());
			tooling.Visible = Boolean.Parse(Session["toolingVisible"].ToString());
			_tbPercentTool.Attributes.Add("onkeypress", "return numeralsOnly(event)");
			_ddlCountrysTool.DataBind();

			_chkAddress.Checked = Boolean.Parse(Session["addressVisible"].ToString());
			address.Visible = Boolean.Parse(Session["addressVisible"].ToString());

			_chkPassword.Checked = Boolean.Parse(Session["passwordVisible"].ToString());
			password.Visible = Boolean.Parse(Session["passwordVisible"].ToString());

			var user = Membership.GetUser();
			if (user != null)
			{
				username.Text = user.UserName;
				String pwd = user.GetPassword();
				CurrentPassword.Attributes.Add("value", pwd);
				NewPassword.Attributes.Add("value", pwd);
				ConfirmNewPassword.Attributes.Add("value", pwd);
				Email.Text = user.Email;
				var profile = Profile.GetProfile();
				Name.Text = profile.Name;
				if (!String.IsNullOrWhiteSpace(profile.CountryId))
				{
					_ddlCountrys.ClearSelection();
					_ddlCountrys.Items.FindByValue(profile.CountryId).Selected = true;
					Session["defaultOwn"] = _ddlCountrys.SelectedValue;
					Session["defaultTool"] = _ddlCountrys.SelectedValue;
					Subdivision_Init();
				}
				Street1.Text = profile.Street1;
				Street2.Text = profile.Street2;
				City.Text = profile.City;
				if (!String.IsNullOrWhiteSpace(profile.SubdivisionId))
				{
					Subdivision.Items.FindByValue(profile.SubdivisionId).Selected = true;
				}
				PostalCode.Text = profile.PostalCode;

				if (String.IsNullOrWhiteSpace(Street1.Text) &&
					String.IsNullOrWhiteSpace(Street2.Text) &&
					String.IsNullOrWhiteSpace(City.Text) &&
					String.IsNullOrWhiteSpace(profile.SubdivisionId) &&
					String.IsNullOrWhiteSpace(PostalCode.Text))
				{
					address.Visible = true;
					_chkAddress.Checked = true;
				}
			}
			else
			{
				Response.Redirect("~/");
			}
		}

		protected void _btnChange_Click(object sender, EventArgs e)
		{
			var user = Membership.GetUser();
			if (user != null)
			{
				if (!CurrentPassword.Text.Equals(NewPassword.Text))
				{
					Membership.Provider.ChangePassword(user.UserName, CurrentPassword.Text, NewPassword.Text);
				}

				user.Email = Email.Text;
				Membership.Provider.UpdateUser(user);
				Profile profile = Profile.GetProfile(user.UserName);
				profile.Name = Name.Text;
				profile.CountryId = _ddlCountrys.SelectedItem.Value;
				profile.Street1 = Street1.Text;
				profile.Street2 = Street2.Text;
				profile.City = City.Text;
				profile.SubdivisionId = Subdivision.SelectedItem.Value;
				profile.PostalCode = PostalCode.Text;
				profile.Save();
			}
			Response.Redirect("~/");
			//FailureText.Text = "Change successful!";
        }

		protected void _chkAddress_CheckedChanged(object sender, EventArgs e)
		{
			if (!IsPostBack) return;

			address.Visible = _chkAddress.Checked;
			Session["addressVisible"] = address.Visible;
		}

		protected void _chkPassword_CheckedChanged(object sender, EventArgs e)
		{
			if (!IsPostBack) return;

			password.Visible = _chkPassword.Checked;
			Session["passwordVisible"] = password.Visible;
		}

		protected void _chkOwnership_CheckedChanged(object sender, EventArgs e)
		{
			if (!IsPostBack) return;

			var isChecked = _chkOwnership.Checked;
			_lvOwnership.DataBind();
			_chkOwnership.Checked = isChecked;
			ownership.Visible = _chkOwnership.Checked;
			Session["ownershipVisible"] = ownership.Visible;
		}

		protected void _chkTooling_CheckedChanged(object sender, EventArgs e)
		{
			if (!IsPostBack) return;

			var isChecked = _chkTooling.Checked;
			_lvTooling.DataBind();
			_chkTooling.Checked = isChecked;
			tooling.Visible = _chkTooling.Checked;
			Session["toolingpVisible"] = tooling.Visible;
		}

		protected void _ddlCountrys_SelectedIndexChanged(object sender, EventArgs e)
		{
			Subdivision_Init();
		}

		private void Subdivision_Init()
		{
			Subdivision.Items.Clear();
			var listItem = new ListItem("-- Select a State/Province --", "-1", true);
			Subdivision.Items.Add(listItem);

			Subdivision.DataSourceID = "_odsSubdivisions";
			Subdivision.DataBind();
		}

		protected void _ddlCountrysOwn_DataBound(object sender, EventArgs e)
		{
			_ddlCountrysOwn.ClearSelection();
			_ddlCountrysOwn.Items.FindByValue(Session["defaultOwn"].ToString()).Selected = true;
		}

		protected void _ddlCountrysTool_DataBound(object sender, EventArgs e)
		{
			_ddlCountrysTool.ClearSelection();
			_ddlCountrysTool.Items.FindByValue(Session["defaultTool"].ToString()).Selected = true;
		}

		protected void _lvOwnership_DataBound(object sender, EventArgs e)
		{
			var remainingPercentage = 100;
			if (_lvOwnership.Items != null && _lvOwnership.Items.Count > 0)
			{
				foreach (var item in _lvOwnership.Items)
				{
					Label l = (Label)item.FindControl("PercentageLabel");
					remainingPercentage -= int.Parse(l.Text);
				}
			}

			if (remainingPercentage <= 0)
			{
				insertown.Visible = false;
				_chkOwnership.Checked = false;
			}
			else
			{
				_tbPercentOwn.Text = remainingPercentage.ToString();
				_ddlCountrysOwn.ClearSelection();
				if (remainingPercentage <= 20 && _ddlCountrysOwn.Items.Count > 0)
				{
					Session["defaultOwn"] = "XX";
					_ddlCountrysOwn.Items.FindByValue("XX").Selected = true;
				}
				else
				{
					Session["defaultOwn"] = _ddlCountrys.SelectedValue;
					_ddlCountrysOwn.Items.FindByValue(_ddlCountrys.SelectedValue).Selected = true;
					_ddlCountrysOwn_DataBound(null, null);
				}
				insertown.Visible = true;
				_chkOwnership.Checked = true;
			}
			ownership.Visible = _chkOwnership.Checked;
			Session["ownershipVisible"] = ownership.Visible;
		}

		protected void _lvOwnership_ItemDeleting(object sender, ListViewDeleteEventArgs e)
		{
			RWR.Wares.DSBO.PercentagesTDTableAdapters.PercentagesTableAdapter ta = new PercentagesTableAdapter();
			ta.Delete(int.Parse(e.Keys[0].ToString()));
		}

		protected void _lvOwnership_ItemDeleted(object sender, ListViewDeletedEventArgs e)
		{
			e.ExceptionHandled = true;
		}

		protected void _btnInsertOwn_Click(object sender, ImageClickEventArgs e)
		{
			var countryTitle = _ddlCountrysOwn.SelectedItem.Text;
			var isDuplicate = false;
			var currentPercentage = 0;

			if (_lvOwnership.Items != null && _lvOwnership.Items.Count > 0)
			{
				foreach (var item in _lvOwnership.Items)
				{
					Label l = (Label)item.FindControl("CountryTitleLabel");
					if (countryTitle == l.Text)
					{
						isDuplicate = true;
						addmessageown.Text = "Please add a row with a unique Country";
						break;
					}
					l = (Label)item.FindControl("PercentageLabel");
					currentPercentage += int.Parse(l.Text);
				}
			}

			var isOver100percent = false;
			if (!isDuplicate)
			{
				var percentToAdd = int.Parse(_tbPercentOwn.Text);
				var total = currentPercentage + percentToAdd;
				if (total > 100)
				{
					isOver100percent = true;
					var remaining = 100 - currentPercentage;
					addmessageown.Text = "Please add a row with a percentage <= " + remaining;
				}
			}

			if (!isDuplicate && !isOver100percent)
			{
				RWR.Wares.DSBO.PercentagesTDTableAdapters.PercentagesTableAdapter ta = new PercentagesTableAdapter();
				ta.Insert(username.Text, 1, null, _ddlCountrysOwn.SelectedItem.Value, int.Parse(_tbPercentOwn.Text), null);

				var isChecked = _chkOwnership.Checked;
				_lvOwnership.DataBind();
				if (isChecked)
				{
					_chkOwnership.Checked = true;
				}
				else
				{
					_chkOwnership.Checked = false;
				}
				ownership.Visible = _chkOwnership.Checked;
				Session["ownershipVisible"] = ownership.Visible;

				_ddlCountrysOwn_DataBound(null, null);
				addmessageown.Text = "";
			}
		}

		protected void _lvTooling_DataBound(object sender, EventArgs e)
		{
			var remainingPercentage = 100;
			if (_lvTooling.Items != null && _lvTooling.Items.Count > 0)
			{
				foreach (var item in _lvTooling.Items)
				{
					Label l = (Label)item.FindControl("PercentageLabel");
					remainingPercentage -= int.Parse(l.Text);
				}
			}

			if (remainingPercentage <= 0)
			{
				inserttool.Visible = false;
				_chkTooling.Checked = false;
			}
			else
			{
				_tbPercentTool.Text = remainingPercentage.ToString();
				_ddlCountrysTool.ClearSelection();
				if (remainingPercentage <= 20 && _ddlCountrysTool.Items.Count > 0)
				{
					Session["defaultTool"] = "XX";
					_ddlCountrysTool.Items.FindByValue("XX").Selected = true;
				}
				else
				{
					Session["defaultTool"] = _ddlCountrys.SelectedValue;
					_ddlCountrysTool.Items.FindByValue(_ddlCountrys.SelectedValue).Selected = true;
					_ddlCountrysTool_DataBound(null, null);
				}
				inserttool.Visible = true;
				_chkTooling.Checked = true;
			}
			tooling.Visible = _chkTooling.Checked;
			Session["toolingVisible"] = tooling.Visible;
		}

		protected void _lvTooling_ItemDeleting(object sender, ListViewDeleteEventArgs e)
		{
			RWR.Wares.DSBO.PercentagesTDTableAdapters.PercentagesTableAdapter ta = new PercentagesTableAdapter();
			ta.Delete(int.Parse(e.Keys[0].ToString()));
		}

		protected void _lvTooling_ItemDeleted(object sender, ListViewDeletedEventArgs e)
		{
			e.ExceptionHandled = true;
		}

		protected void _btnInsertTool_Click(object sender, ImageClickEventArgs e)
		{
			var countryTitle = _ddlCountrysTool.SelectedItem.Text;
			var isDuplicate = false;
			var currentPercentage = 0;

			if (_lvTooling.Items != null && _lvTooling.Items.Count > 0)
			{
				foreach (var item in _lvTooling.Items)
				{
					Label l = (Label)item.FindControl("CountryTitleLabel");
					if (countryTitle == l.Text)
					{
						isDuplicate = true;
						addmessagetool.Text = "Please add a row with a unique Country";
						break;
					}
					l = (Label)item.FindControl("PercentageLabel");
					currentPercentage += int.Parse(l.Text);
				}
			}

			var isOver100percent = false;
			var total = 0;
			if (!isDuplicate)
			{
				var percentToAdd = int.Parse(_tbPercentTool.Text);
				total = currentPercentage + percentToAdd;
				if (total > 100)
				{
					isOver100percent = true;
					var remaining = 100 - currentPercentage;
					addmessagetool.Text = "Please add a row with a percentage <= " + remaining;
				}
			}

			if (!isDuplicate && !isOver100percent)
			{
				RWR.Wares.DSBO.PercentagesTDTableAdapters.PercentagesTableAdapter ta = new PercentagesTableAdapter();
				ta.Insert(username.Text, 2, null, _ddlCountrysTool.SelectedItem.Value, int.Parse(_tbPercentTool.Text), null);

				var isChecked = _chkTooling.Checked;
				_lvTooling.DataBind();
				if (isChecked)
				{
					_chkTooling.Checked = true;
				}
				else
				{
					_chkTooling.Checked = false;
				}
				tooling.Visible = _chkTooling.Checked;
				Session["toolingVisible"] = tooling.Visible;

				_ddlCountrysTool_DataBound(null, null);
				addmessagetool.Text = "";
			}
		}

    }
}