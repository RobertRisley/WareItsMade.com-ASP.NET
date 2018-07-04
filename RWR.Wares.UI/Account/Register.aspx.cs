using Microsoft.AspNet.Membership.OpenAuth;
using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RWR.Wares.UI.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			((LoginView)this.Master.FindControl("loginView")).Visible = false;

			RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
            //RegisterUser.CreatingUser += RegisterUser_CreatingUser;
        }

		//void RegisterUser_CreatingUser(object sender, System.Web.UI.WebControls.LoginCancelEventArgs e)
		//{
		//	RegisterUser.UserName = RegisterUser.Email;
		//}

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);

            string continueUrl = RegisterUser.ContinueDestinationPageUrl;
            if (!OpenAuth.IsLocalUrl(continueUrl))
            {
                continueUrl = "~/";
            }
            Response.Redirect(continueUrl);
        }
    }
}