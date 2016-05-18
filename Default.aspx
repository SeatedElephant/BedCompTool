<%@ Page Title="Bed Complement Manager - Home" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BedComplementManager.Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
         <script type="text/javascript" language="javascript">

             function openWindow(window_src) {
                 window.open(window_src, '_blank', config = 'height=640, width=950, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, directories=no, status=yes');
             }

        </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Bed Complement Reports
    </h2>
    <br />
    <div class="explanatoryParagraph">
        <p>
            Below are a selection of IRIS reports relating to Hywel Dda University Health Board
            sites. The data is sourced from the the IRIS data warehouse and is updated via the
            Bed Complement Manager application. To view one of these reports click on the appropriate
            link below.
        </p>
    </div>
    <br />
    <p>
        <asp:Image ID="Image1" runat="server" ImageUrl="http://7a2blsrvinf0001/commonfiles/images/icon_report.png" />
        <a href="#" onclick="openWindow('http://7a2blsrvinf0003/ReportServer/Pages/ReportViewer.aspx?%2fBed+Complement%2fBed+Complement+-+Location+-+FY&rs:Command=Render');">Trend by Location (for financial year)</a></p>
    <p>
        <asp:Image ID="Image2" runat="server" ImageUrl="http://7a2blsrvinf0001/commonfiles/images/icon_report.png" />
        <a href="#" onclick="openWindow('http://7a2blsrvinf0003/ReportServer/Pages/ReportViewer.aspx?%2fBed+Complement%2fBed+Complement+-+Specialty+-+FY&rs:Command=Render');">Trend by Specialty (for financial year)</a></p>
    <p>
        <asp:Image ID="Image3" runat="server" ImageUrl="http://7a2blsrvinf0001/commonfiles/images/icon_report.png" />
        <a href="#" onclick="openWindow('http://7a2blsrvinf0003/ReportServer/Pages/ReportViewer.aspx?%2fBed+Complement%2fBed+Complement+-+Location+-+Monthly&rs:Command=Render');">Monthly View by Location</a></p>
    <p>
        <asp:Image ID="Image4" runat="server" ImageUrl="http://7a2blsrvinf0001/commonfiles/images/icon_report.png" />
        <a href="#" onclick="openWindow('http://7a2blsrvinf0003/ReportServer/Pages/ReportViewer.aspx?%2fBed+Complement%2fBed+Complement+-+Specialty+-+Monthly&rs:Command=Render');">Monthly View by Specialty</a></p>
    <p>
        <asp:Image ID="Image5" runat="server" ImageUrl="http://7a2blsrvinf0001/commonfiles/images/icon_report.png" />
        <a href="#" onclick="openWindow('http://7a2blsrvinf0003/ReportServer/Pages/ReportViewer.aspx?%2fBed+Complement%2fBed+Complement+-+Side+Rooms&rs:Command=Render');">Breakdown of Side/Single Rooms</a></p>
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
