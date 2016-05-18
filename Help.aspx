<%@ Page Title="Help" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Help.aspx.cs" Inherits="BedComplementManager.Help" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Help
    </h2>
    <br />
    <div class="explanatoryParagraph">
        <p>
            For any technical support issues relating to using Bed Complement Manager email:<br /><br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="mailto:hdd.information.development@wales.nhs.uk">hdd.information.development@wales.nhs.uk</asp:HyperLink>
        </p>
    </div>
</asp:Content>
<asp:Content ID="FooterContent" runat="server" ContentPlaceHolderID="FooterContent">
        <div style="margin-left: 2%; width: 98%; overflow: hidden;">
        <div align="left" style="width: 15%; float: left;">
            <asp:HyperLink ID="IRISCorporateSite" runat="server" NavigateUrl="http://7a2blsrvinf0001/iriscorporate/">IRIS Corporate Site</asp:HyperLink>
        </div>
        <div align="center">
            Bed Complement Manager v1.0
        </div>
    </div>
</asp:Content>
