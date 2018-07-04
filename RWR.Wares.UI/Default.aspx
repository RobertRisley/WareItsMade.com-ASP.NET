<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RWR.Wares.UI._Default" EnableSessionState="True" EnableViewState="True" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<hgroup class="title">
		<h2 title="Wares: articles of manufacture or services regarded as a commercial or salable commodity">Connect with wares from any country:&nbsp;</h2>
		</hgroup>
		<asp:DropDownList Height="30" ID="_ddlCountrys" runat="server" AutoPostBack="True" DataSourceID="_odsCountrys" DataTextField="CountryTitle" DataValueField="CountryId" OnDataBound="_ddlCountrys_DataBound"></asp:DropDownList>
		<asp:ObjectDataSource ID="_odsCountrys" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.CountrysCDTableAdapters.CountrysTableAdapter"></asp:ObjectDataSource>
	<hgroup>
	</hgroup>
	<br />
	<asp:Panel runat="server" DefaultButton="_btnSearch">
		<asp:TextBox ID="_tbWareName" runat="server" onfocus="waterMark(this, event, false, 'Search for a Ware')" onblur="waterMark(this, event, false, 'Search for a Ware')" Text="Search for a Ware" CssClass="watermark" Height="15" Width="175" Font-Size="9" ToolTip="Enter the name of a commodity or service and click Search"></asp:TextBox>
		<asp:Button ID="_btnSearch" runat="server" Text="Search" OnClick="_btnSearch_Click" ToolTip="Click here after entering a value in Search for a Ware" />
		<asp:Label ID="Label1" runat="server" Text="Label">OR Select using &copy;UNSPSC classifications</asp:Label><br />
	</asp:Panel>

	<asp:DropDownList ID="_ddlSegments" runat="server" DataTextField="SegmentTitle" DataValueField="SegmentId" AutoPostBack="True" DataSourceID="_odsSegments" AppendDataBoundItems="True" OnSelectedIndexChanged="_ddlSegments_SelectedIndexChanged">
		<asp:ListItem Value="-1" Selected="True">-- select a Segment --</asp:ListItem>
	</asp:DropDownList>
	<asp:ObjectDataSource ID="_odsSegments" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.SegmentsCDTableAdapters.SegmentsTableAdapter"></asp:ObjectDataSource>
	<br />
	<asp:DropDownList ID="_ddlFamilys" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="_odsFamilys" DataTextField="FamilyTitle" DataValueField="FamilyId" Enabled="False" OnSelectedIndexChanged="_ddlFamilys_SelectedIndexChanged">
		<asp:ListItem Selected="True" Value="-1">-- select a Family --</asp:ListItem>
	</asp:DropDownList>
	<asp:ObjectDataSource ID="_odsFamilys" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.FamilysCDTableAdapters.FamilysTableAdapter">
		<SelectParameters>
			<asp:ControlParameter ControlID="_ddlSegments" Name="SegmentId" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<br />
	<asp:DropDownList ID="_ddlClasses" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="_odsClasses" DataTextField="ClassTitle" DataValueField="ClassId" Enabled="False" OnSelectedIndexChanged="_ddlClasses_SelectedIndexChanged">
		<asp:ListItem Selected="True" Value="-1">-- select a Class --</asp:ListItem>
	</asp:DropDownList>
	<asp:ObjectDataSource ID="_odsClasses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.ClassesCDTableAdapters.ClassesTableAdapter">
		<SelectParameters>
			<asp:ControlParameter ControlID="_ddlFamilys" Name="FamilyId" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:ObjectDataSource>

	<br />
	<div runat="server" id="wares" visible="false">
		<br />
		<asp:DropDownList ID="_ddlWares" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="_odsWares" DataTextField="CommodityTitle" DataValueField="CommodityId" Font-Size="Large" OnSelectedIndexChanged="_ddlWares_SelectedIndexChanged">
			<asp:ListItem Selected="True" Value="-1">-- select a Ware to search for --</asp:ListItem>
		</asp:DropDownList>
		<asp:ObjectDataSource ID="_odsWares" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.WaresCDTableAdapters.WaresTableAdapter">
			<SelectParameters>
				<asp:ControlParameter ControlID="_ddlClasses" Name="ClassId" PropertyName="SelectedValue" Type="String" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="_odsSearch" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.SearchCDTableAdapters.SearchTableAdapter">
			<SelectParameters>
				<asp:ControlParameter ControlID="_tbWareName" Name="SearchString" PropertyName="Text" Type="String" />
			</SelectParameters>
		</asp:ObjectDataSource>
	</div>

	<br />
	<asp:Panel runat="server" BorderStyle="Solid" BorderColor="LightGray" BorderWidth="1px">
		<asp:CheckBox ID="_chkWeights" runat="server" AutoPostBack="True" Text="Show Factors of Production weighting" ToolTip="Click to toggle showing of weighting" OnCheckedChanged="_chkWeights_CheckedChanged" Checked="True" />
		<asp:Label runat="server">Estimated values indicating the relative importance of each item in a group as compared to other items in the group.</asp:Label>
		<div id="weight" runat="server" visible="False" class="padleft">
			<ol class="round">
				<li class="one">
					<h5>Entrepreneurship
						<asp:TextBox ID="_tbEnt" runat="server" Height="9" Width="34" Text="100" Font-Size="7" Font-Bold="True" TextMode="Number"></asp:TextBox></h5>
					Ownership takes on the risk of bringing Capital, Labor, and Land together to produce wares.
				</li>
				<li class="two">
					<h5>Capital
						<asp:TextBox ID="_tbCap" runat="server" Height="9" Width="34" Text="50" Font-Size="7" Font-Bold="True" TextMode="Number"></asp:TextBox></h5>
					Parts, sub-assemblies, and services. Plus tools, machinery, equipment, and vehicles.
				</li>
				<li class="three">
					<h5>Labor
						<asp:TextBox ID="_tbLab" runat="server" Height="9" Width="34" Text="25" Font-Size="7" Font-Bold="True" TextMode="Number"></asp:TextBox></h5>
					Human effort used in production, which also includes technical, marketing, and management.
				</li>
				<li class="four">
					<h5>Land
						<asp:TextBox ID="_tbLan" runat="server" Height="9" Width="34" Text="5" Font-Size="7" Font-Bold="True" TextMode="Number"></asp:TextBox></h5>
					Natural resources; organic (plants, animals, fossil fuels) and non-organic (air, water, minerals, metals, light, heat).
				</li>
			</ol>
		</div>
	</asp:Panel>
	<%--<br />--%>
	<%--<h4>Wares: articles of manufacture or services regarded as a commercial or salable commodity</h4>--%>
</asp:Content>
