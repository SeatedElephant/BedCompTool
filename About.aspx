<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="BedComplementManager.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        About
    </h2>
    <br />
    <div class="explanatoryParagraph">
        <p>
            Bed Complement Manager<br />
            Version 1.0<br />
            Information Services / Gwasanaethau Gwybodaeth<br />
            Hywel Dda University Health Board / Bwrdd Iechyd Prifysgol Hywel Dda<br />
        </p>
        <p>
            Bed Complement Manager 1.0 allows users to view and update the end of month bed
            complement figures for Hywel Dda University Health Board. The figures are updated
            and edited by Corporate Information and are consolidated from bed management data
            provided to Informatics by indviduals responsible for reporting on bed complement
            within the health board. All figures show an end of month position with a breakdown
            to hospital, ward and specialty level.
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
