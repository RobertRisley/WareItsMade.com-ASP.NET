<%@ Page Title="Edit your profile data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="RWR.Wares.UI.EditProfile" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<hgroup class="title">
		<h2><%: Title %>.</h2>
	</hgroup>
	<br />
	<section id="profileForm">
		<asp:Label ID="username" runat="server" Visible="false" />
		<asp:Button ID="noop" runat="server" Visible="false" />

		<asp:Label ID="Label1" runat="server" AssociatedControlID="Name">Company Name</asp:Label>
		<asp:TextBox runat="server" ID="Name" Width="300" />
		<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Name"
			CssClass="field-validation-error" ErrorMessage="The company name field is required."
			ValidationGroup="ChangePassword" />
		<asp:Label runat="server" AssociatedControlID="_ddlCountrys">Country of your Corporate Headquarters</asp:Label>
		<asp:DropDownList ID="_ddlCountrys" runat="server" Height="28" CssClass="padleft" AutoPostBack="True" DataSourceID="_odsCountrys" DataTextField="CountryTitle" DataValueField="CountryId" Width="300" OnSelectedIndexChanged="_ddlCountrys_SelectedIndexChanged" />
		<asp:ObjectDataSource ID="_odsCountrys" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.CountrysCDTableAdapters.CountrysTableAdapter"></asp:ObjectDataSource>
		<asp:Label ID="Label2" runat="server" AssociatedControlID="Email">Email</asp:Label>
		<asp:TextBox runat="server" ID="Email" TextMode="Email" Width="300" />
		<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Email"
			CssClass="field-validation-error" ErrorMessage="The email address field is required."
			ValidationGroup="ChangePassword" />
		<br />

		<br />
		<asp:Panel runat="server" BorderStyle="Solid" BorderColor="LightGray" BorderWidth="1px">
			<asp:CheckBox ID="_chkOwnership" runat="server" AutoPostBack="True" Text="Show ownership percentages" ToolTip="Click to toggle showing of ownership percentages" OnCheckedChanged="_chkOwnership_CheckedChanged" />
			<asp:Label ID="Label3" runat="server">The Ownership takes on the risk of bringing Capital, Labor, and Land together to produce your wares.</asp:Label>
			<br />
			<div id="ownership" runat="server" visible="true" class="padleft">
				<asp:ListView ID="_lvOwnership" runat="server" DataKeyNames="PercentageId" DataSourceID="_odsPercentagesOwn" OnDataBound="_lvOwnership_DataBound" OnItemDeleted="_lvOwnership_ItemDeleted" OnItemDeleting="_lvOwnership_ItemDeleting" >
					<EmptyDataTemplate>
					</EmptyDataTemplate>
					<ItemTemplate>
							<tr style="">
								<td><asp:Label ID="CountryTitleLabel" runat="server" Text='<%# Eval("CountryTitle") %>' Height="24" Width="303" BorderWidth="1px" BorderColor="DarkGray" CssClass="textvcenter" /></td>
								<td><asp:Label ID="PercentageLabel" runat="server" Text='<%# Eval("Percentage") %>' Height="24" Width="32"  BorderWidth="1px" BorderColor="DarkGray" CssClass="textvcenter" /></td>
								<td>
									<asp:Button runat="server" Height="0" Width="0" /><asp:ImageButton ID="DeleteButton" runat="server" CommandName="Delete" src="Images/x.png" CssClass="imagebutton"  style="position: relative; top: 2px" Height="22" ToolTip="Click here to delete this row" />
									</td>
							</tr>
					</ItemTemplate>
					<LayoutTemplate>
						<table runat="server">
							<tr runat="server">
								<td runat="server">
									<table id="itemPlaceholderContainer" runat="server" border="0" style="">
										<tr runat="server" style="">
											<th runat="server">Country</th>
											<th runat="server">%</th>
										</tr>
										<tr id="itemPlaceholder" runat="server"></tr>
									</table>
								</td>
							</tr>
						</table>
					</LayoutTemplate>
				</asp:ListView>
				<div id="insertown" runat="server" visible="False">
				<asp:Label ID="Label4" runat="server"><br />Please enter the country(s) that <b>your owners</b> are based in.<br />If any are less that 20%, then combine them all into **Other/Unknown**</asp:Label>
					<table>
						<tr>
							<td><asp:DropDownList Height="30" ID="_ddlCountrysOwn" runat="server" AutoPostBack="True" DataSourceID="_odsCountrys" DataTextField="CountryTitle" DataValueField="CountryId" OnDataBound="_ddlCountrysOwn_DataBound" CssClass="textvcenter"></asp:DropDownList></td>
							<td><asp:TextBox ID="_tbPercentOwn" runat="server" Height="19" Width="46"  TextMode="Number" Font-Size="1.0em" CssClass="textvcenter" /></td>
							<td>
								<asp:Panel ID="Panel1" runat="server" DefaultButton="noopown">
									<asp:Button ID="noopown" runat="server" Visible="false" />
									<asp:ImageButton ID="_btnInsertOwn" runat="server" src="Images/ok.png" CssClass="imagebutton" Height="22" style="position: relative; top: 2px" ToolTip="Click here to Add this row" OnClick="_btnInsertOwn_Click" />&nbsp; <asp:Label ID="addmessageown" runat="server"/>
								</asp:Panel>
							</td>
						</tr>
					</table>
				</div>
				<asp:ObjectDataSource ID="_odsPercentagesOwn" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.PercentagesOwnCDTableAdapters.PercentagesTableAdapter">
					<SelectParameters>
						<asp:ControlParameter ControlID="username" DefaultValue="" Name="UserName" PropertyName="Text" Type="String" />
						<asp:Parameter DefaultValue="1" Name="TypeId" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
			</div>
		</asp:Panel>

		<br />
		<asp:Panel runat="server" BorderStyle="Solid" BorderColor="LightGray" BorderWidth="1px" DefaultButton="nooptool">
			<asp:Button ID="nooptool" runat="server" Visible="false" />
			<asp:CheckBox ID="_chkTooling" runat="server" AutoPostBack="True" Text="Show tooling percentages" ToolTip="Click to toggle showing of tooling percentages" OnCheckedChanged="_chkTooling_CheckedChanged" />
			<asp:Label ID="Label5" runat="server">These are the tools, machinery, computer equipment, and other goods used to make the wares.</asp:Label>
			<br />
			<div id="tooling" runat="server" visible="true" class="padleft">
				<asp:ListView ID="_lvTooling" runat="server" DataKeyNames="PercentageId" DataSourceID="_odsPercentagesTool" OnDataBound="_lvTooling_DataBound" OnItemDeleted="_lvTooling_ItemDeleted" OnItemDeleting="_lvTooling_ItemDeleting">
					<EmptyDataTemplate>
					</EmptyDataTemplate>
					<ItemTemplate>
						<tr style="">
							<td><asp:Label ID="CountryTitleLabel" runat="server" Text='<%# Eval("CountryTitle") %>' Height="24" Width="303" BorderWidth="1px" BorderColor="DarkGray" CssClass="textvcenter" /></td>
							<td><asp:Label ID="PercentageLabel" runat="server" Text='<%# Eval("Percentage") %>' Height="24" Width="32"  BorderWidth="1px" BorderColor="DarkGray" CssClass="textvcenter" /></td>
							<td><asp:ImageButton ID="DeleteButton" runat="server" CommandName="Delete" src="Images/x.png" CssClass="imagebutton" style="position: relative; top: 2px" Height="22" ToolTip="Click here to delete this row" /></td>
						</tr>
					</ItemTemplate>
					<LayoutTemplate>
						<table id="Table3" runat="server">
							<tr id="Tr3" runat="server">
								<td id="Td2" runat="server">
									<table id="itemPlaceholderContainer" runat="server" border="0" style="">
										<tr id="Tr4" runat="server" style="">
											<th id="Th3" runat="server">Country</th>
											<th id="Th4" runat="server">%</th>
										</tr>
										<tr id="itemPlaceholder" runat="server"></tr>
									</table>
								</td>
							</tr>
						</table>
					</LayoutTemplate>
				</asp:ListView>
				<div id="inserttool" runat="server" visible="False">
				<asp:Label ID="Label6" runat="server"><br />Please enter the country(s) that <b>your tools and equipment</b> are produced in.<br />If any are less that 20%, then combine them all into **Other/Unknown**</asp:Label>
					<table>
						<tr>
							<td><asp:DropDownList Height="30" ID="_ddlCountrysTool" runat="server" AutoPostBack="True" DataSourceID="_odsCountrys" DataTextField="CountryTitle" DataValueField="CountryId" OnDataBound="_ddlCountrysTool_DataBound" CssClass="textvcenter"></asp:DropDownList></td>
							<td><asp:TextBox ID="_tbPercentTool" runat="server" Height="19" Width="46"  TextMode="Number" Font-Size="1.0em" CssClass="textvcenter" /></td>
							<td><asp:ImageButton ID="_btnInsertTool" runat="server" src="Images/ok.png" CssClass="imagebutton" Height="22" style="position: relative; top: 2px" ToolTip="Click here to Add this row" OnClick="_btnInsertTool_Click" />&nbsp; <asp:Label ID="addmessagetool" runat="server"/></td>
						</tr>
					</table>
				</div>
				<asp:ObjectDataSource ID="_odsPercentagesTool" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.PercentagesOwnCDTableAdapters.PercentagesTableAdapter">
					<SelectParameters>
						<asp:ControlParameter ControlID="username" DefaultValue="" Name="UserName" PropertyName="Text" Type="String" />
						<asp:Parameter DefaultValue="2" Name="TypeId" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
			</div>
		</asp:Panel>

		<br />
		<asp:Panel runat="server" BorderStyle="Solid" BorderColor="LightGray" BorderWidth="1px">
			<p><asp:Literal runat="server" ID="_ltlMessage" /></p>

			<asp:CheckBox ID="_chkAddress" runat="server" AutoPostBack="True" Text="Show address info" ToolTip="Click to toggle showing of address" OnCheckedChanged="_chkAddress_CheckedChanged" />
			<br />
			<div id="address" runat="server" visible="False" class="padleft">


				<br />
				<asp:Label runat="server" AssociatedControlID="Homepage">Home page URL</asp:Label>
				<asp:TextBox runat="server" ID="Homepage" Width="300" TextMode="Url" />

				<asp:Label runat="server" AssociatedControlID="Street1">Address 1</asp:Label>
				<asp:TextBox runat="server" ID="Street1" Width="300" />

				<asp:Label runat="server" AssociatedControlID="Street2">Address 2</asp:Label>
				<asp:TextBox runat="server" ID="Street2" Width="300" />

				<asp:Label runat="server" AssociatedControlID="City">City</asp:Label><asp:TextBox runat="server" ID="City" Width="150" />
				<asp:Label runat="server" AssociatedControlID="Subdivision">State/Province</asp:Label><asp:DropDownList ID="Subdivision" runat="server" Height="28" DataSourceID="_odsSubdivisions" AppendDataBoundItems="true" DataTextField="SubdivisionTitle" DataValueField="SubdivisionId">
					<asp:ListItem Value="-1" Selected="True">-- Select a State/Province --</asp:ListItem>
				</asp:DropDownList>
				<asp:ObjectDataSource ID="_odsSubdivisions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.SubdivisionsCDTableAdapters.SubdivisionsTableAdapter">
					<SelectParameters>
						<asp:ControlParameter ControlID="_ddlCountrys" Name="CountryId" PropertyName="SelectedValue" Type="String" />
					</SelectParameters>
				</asp:ObjectDataSource>
				<br />
				<br />
				<asp:Label runat="server" AssociatedControlID="PostalCode">Postal Code</asp:Label><asp:TextBox runat="server" ID="PostalCode" Width="100" />
			</div>
		</asp:Panel>

		<br />
		<asp:Panel runat="server" BorderStyle="Solid" BorderColor="LightGray" BorderWidth="1px">
			<asp:CheckBox ID="_chkPassword" runat="server" AutoPostBack="True" Text="Show password info" ToolTip="Click to toggle showing of passwords" OnCheckedChanged="_chkPassword_CheckedChanged" />
			<br />
			<div id="password" runat="server" visible="False" class="padleft">
				<asp:Label runat="server" AssociatedControlID="CurrentPassword">Current password</asp:Label>
				<asp:TextBox runat="server" ID="CurrentPassword" CssClass="passwordEntry" TextMode="Password" />
				<asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
					CssClass="field-validation-error" ErrorMessage="The current password field is required."
					ValidationGroup="ChangePassword" />
				<asp:Label runat="server" AssociatedControlID="NewPassword">New password</asp:Label>
				<asp:TextBox runat="server" ID="NewPassword" CssClass="passwordEntry" TextMode="Password" />
				<asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
					CssClass="field-validation-error" ErrorMessage="The new password is required."
					ValidationGroup="ChangePassword" />
				<asp:Label runat="server" AssociatedControlID="ConfirmNewPassword">Confirm new password</asp:Label>
				<asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="passwordEntry" TextMode="Password" />
				<asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
					CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Confirm new password is required."
					ValidationGroup="ChangePassword" />
				<asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
					CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
					ValidationGroup="ChangePassword" />
			</div>
		</asp:Panel>

		<br />
		<asp:Button runat="server" ID="_btnChange" Text="Apply" ValidationGroup="ChangePassword" OnClick="_btnChange_Click" />
	</section>

</asp:Content>
