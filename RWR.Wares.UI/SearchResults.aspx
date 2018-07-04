<%@ Page Title="Your Search Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="RWR.Wares.UI.SearchResults" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<hgroup class="title">
		<h2><%: Title %>.</h2>
	</hgroup>
	<br />
	<section id="searchForm">
		<asp:Label ID="username" runat="server" Visible="false" />
		<asp:Button ID="noop" runat="server" Visible="false" />

		<asp:ObjectDataSource ID="_odsResults" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.WeightedWaresCDTableAdapters.GetWeightedCommoditiesTableAdapter">
			<SelectParameters>
				<asp:SessionParameter Name="CommodityId" SessionField="searchCommodityId" Type="String" />
				<asp:SessionParameter Name="CountryId" SessionField="CountryId" Type="String" />
				<asp:SessionParameter Name="OwnershipWeight" SessionField="OwnWeight" Type="Int32" />
				<asp:SessionParameter Name="CapitalWeight" SessionField="CapWeight" Type="Int32" />
				<asp:SessionParameter Name="LaborWeight" SessionField="LabWeight" Type="Int32" />
				<asp:SessionParameter Name="LandWeight" SessionField="LanWeight" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="_odsResults" EmptyDataText="No results :(" CellSpacing="2" DataKeyNames="UserName,CommodityId,ObjectId" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
			<AlternatingRowStyle BackColor="#DCDCDC" />
			<Columns>
				<asp:BoundField DataField="CountryId" HeaderText="Country" ReadOnly="True" SortExpression="CountryId" />
				<asp:BoundField DataField="CommodityTitle" HeaderText="Ware" ReadOnly="True" SortExpression="CommodityTitle" />
				<asp:BoundField DataField="ObjectId" HeaderText="ItemId" ReadOnly="True" SortExpression="ObjectId" />
				<asp:BoundField DataField="NameName" HeaderText="Who Has It" ReadOnly="True" SortExpression="NameName" />
				<asp:BoundField DataField="WeightedPercentage" HeaderText="Score" ReadOnly="True" SortExpression="WeightedPercentage"></asp:BoundField>
				<asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName" Visible="False" />
				<asp:BoundField DataField="CommodityId" HeaderText="CommodityId" ReadOnly="True" SortExpression="CommodityId" Visible="False" />
				<asp:CommandField SelectText="Show Me" ShowSelectButton="True" />
			</Columns>
			<FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
			<HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
			<PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
			<RowStyle BackColor="#EEEEEE" ForeColor="Black" />
			<SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
			<SortedAscendingCellStyle BackColor="#F1F1F1" />
			<SortedAscendingHeaderStyle BackColor="#0000A9" />
			<SortedDescendingCellStyle BackColor="#CAC9C9" />
			<SortedDescendingHeaderStyle BackColor="#000065" />
		</asp:GridView>
		<br />
		<asp:ObjectDataSource ID="_odsUsersWares" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RWR.Wares.DSBO.UsersWaresTDTableAdapters.UsersWaresTableAdapter" UpdateMethod="Update">
			<SelectParameters>
				<asp:ControlParameter ControlID="GridView1" DefaultValue="rwr" Name="UserName" PropertyName="SelectedValue" Type="String" />
				<asp:ControlParameter ControlID="GridView1" DefaultValue="43232309" Name="CommodityId" PropertyName="SelectedValue" Type="String" />
				<asp:ControlParameter ControlID="GridView1" DefaultValue="UPCID1" Name="ObjectId" PropertyName="SelectedValue" Type="String" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<br />
		<asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="WareId" ForeColor="Black" DataSourceID="SqlDataSource1" OnDataBinding="DetailsView1_DataBinding">
			<EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
			<Fields>
				<asp:BoundField DataField="WareId" HeaderText="WareId" InsertVisible="False" ReadOnly="True" SortExpression="WareId" />
				<asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
				<asp:BoundField DataField="CommodityId" HeaderText="CommodityId" SortExpression="CommodityId" />
				<asp:BoundField DataField="ObjectId" HeaderText="ObjectId" SortExpression="ObjectId" />
				<asp:BoundField DataField="ObjectName" HeaderText="ObjectName" SortExpression="ObjectName" />
				<asp:BoundField DataField="ObjectDescription" HeaderText="ObjectDescription" SortExpression="ObjectDescription" />
				<asp:BoundField DataField="ObjectUri" HeaderText="ObjectUri" SortExpression="ObjectUri" />
			</Fields>
			<FooterStyle BackColor="#CCCCCC" />
			<HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
			<PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
			<RowStyle BackColor="White" />
		</asp:DetailsView>
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RWR.Wares.DSBO.Properties.Settings.WaresConnectionString %>" SelectCommand="SELECT * FROM [UsersWares] WHERE (([UserName] = @UserName) AND ([CommodityId] = @CommodityId) AND ([ObjectId] = @ObjectId))">
			<SelectParameters>
				<asp:ControlParameter ControlID="GridView1" Name="UserName" PropertyName="SelectedValue" Type="String" />
				<asp:ControlParameter ControlID="GridView1" Name="CommodityId" PropertyName="SelectedValue" Type="String" />
				<asp:ControlParameter ControlID="GridView1" Name="ObjectId" PropertyName="SelectedValue" Type="String" />
			</SelectParameters>
		</asp:SqlDataSource>
	</section>

</asp:Content>
