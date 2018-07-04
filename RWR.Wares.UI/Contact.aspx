<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="RWR.Wares.UI.Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h2><%: Title %>.</h2>
    </hgroup>

    <section class="contact">
        <header>
            <h3>Phone:</h3>
        </header>
        <p>
            <span class="label">Main:</span>
            <span>818.620.5850</span>
        </p>
        <p>
            <span class="label">After Hours:</span>
            <span>818.620.5850</span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Email:</h3>
        </header>
        <p>
            <span class="label">Support:</span>
            <span><a href="mailto:Support@waresitmade.com">Support@waresitmade.com</a></span>
        </p>
        <p>
            <span class="label">Marketing:</span>
            <span><a href="mailto:Marketing@waresitmade.com">Marketing@waresitmade.com</a></span>
        </p>
        <p>
            <span class="label">General:</span>
            <span><a href="mailto:General@waresitmade.com">General@waresitmade.com</a></span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Address:</h3>
        </header>
        <p>
            243 Green Heath Place<br />
            Thousand Oaks, CA 91361
        </p>
    </section>
</asp:Content>