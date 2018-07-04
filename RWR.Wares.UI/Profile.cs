using System.Web.Profile;
using System.Web.Security;

namespace RWR.Wares.UI
{
	public class Profile : ProfileBase
	{
		public static Profile GetProfile(string username)
		{
			return Create(username) as Profile;
		}
		public static Profile GetProfile()
		{
			return Create(Membership.GetUser().UserName) as Profile;
		}

		[SettingsAllowAnonymous(true)]
		public string Name
		{
			get { return base["Name"] as string; }
			set { base["Name"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string CountryId
		{
			get { return base["CountryId"] as string; }
			set { base["CountryId"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string Street1
		{
			get { return base["Street1"] as string; }
			set { base["Street1"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string Street2
		{
			get { return base["Street2"] as string; }
			set { base["Street2"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string City
		{
			get { return base["City"] as string; }
			set { base["City"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string SubdivisionId
		{
			get { return base["SubdivisionId"] as string; }
			set { base["SubdivisionId"] = value; }
		}

		[SettingsAllowAnonymous(true)]
		public string PostalCode
		{
			get { return base["PostalCode"] as string; }
			set { base["PostalCode"] = value; }
		}

	}
}