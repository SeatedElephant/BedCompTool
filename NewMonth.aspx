<%@ Page Title="New Month" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="NewMonth.aspx.cs" Inherits="BedComplementManager.NewMonth" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.maskedinput-1.2.2-co.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        //Creates an input mask for the dates textboxs with placeholders to show the format that the user should use
        jQuery(function ($) {
            $(".date").mask("99/99/9999", { placeholder: 'dd/mm/yyyy' });
            $(".date2").mask("99/99/9999", { placeholder: 'dd/mm/yyyy' });
        });


        //This js function gets called with the onclick event of cal.png. When the image is clicked the state of the
        //div tags dateField are checked to see if the calendar control is shown or hidden withing it. If it is hidden
        //onclick then it is shown else it is hidden.   
        function popupCalendar() {
            var dateField = document.getElementById("<%=dateField.ClientID%>");

            // toggle the div
            if (dateField.style.display == 'none') {
                dateField.style.display = 'block';
            }
            else {
                dateField.style.display = 'none';
            }
        }

        //This js function gets called with the onclick event of cal.png. When the image is clicked the state of the
        //div tags dateField2 are checked to see if the calendar control is shown or hidden withing it. If it is hidden
        //onclick then it is shown else it is hidden.        
        function popupCalendar2() {
            var dateField2 = document.getElementById("<%=dateField2.ClientID%>");

            // toggle the div
            if (dateField2.style.display == 'none') {
                dateField2.style.display = 'block';
            }
            else {
                dateField2.style.display = 'none';
            }
        }

        //This js function is called from the onchange event of the textbox txtDate. It clears any previous error messages
        //about the previous month selection just made not finding any data
        function ClearValidateTxtDate() {
            document.getElementById("<%=validateTxtDate.ClientID%>").innerText = "";
        }

        //This js function is called from the onchange event of the textbox txtDate. It clears any previous error messages
        //about the previous month selection just made not finding any data
        function ClearValidateTxtDate2() {
            document.getElementById("<%=validateTxtDate2.ClientID%>").innerText = "";
        }

    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Add A New Month
    </h2>
    <br />
    <div class="explanatoryParagraph">
        To enter bed complement values from a previously entered month as a starting point
        for your data input:
        <br />
        <br />
        <ol>
            <li>Select a month from the top calendar control for the previously entered month that
                you want to duplcate. </li>
            <li>Select a month from the bottom calendar control for the month to use for the new
                bed complement figures. </li>
            <li>Click on &quot;Add Records&quot; to insert the new month's bed complement. </li>
            <li>If nescessary navigate to the 'Edit Existing Month' page and edit the figures for
                the newly input month. </li>
        </ol>
    </div>
    <table cellpadding="4" cellspacing="15">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Select a previously entered month to work from:"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div id="dateField" style="display: none;" align="left" runat="server">
                    <asp:Calendar ID="calDate" OnSelectionChanged="calDate_SelectionChanged" runat="server"
                        OnVisibleMonthChanged="calDate_VisibleMonthChanged" />
                </div>
                <asp:TextBox ID="txtDate" class="date" runat="server" onchange="ClearValidateTxtDate()"
                    AutoPostBack="false" MaxLength="10" />
                <img alt="image for calendar" src="Image/cal.png" onclick="popupCalendar()" align="middle" />
                <asp:RequiredFieldValidator ID="rfvTxtDatePrevious" runat="server" ErrorMessage="* Select a month"
                    ControlToValidate="txtDate" EnableClientScript="True" ForeColor="Red" Font-Size="Smaller"
                    Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="validateTxtDate" runat="server" Font-Size="Smaller" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Select the month for the data to be inserted:"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div id="dateField2" style="display: none;" align="left" runat="server">
                    <asp:Calendar ID="calDate2" OnSelectionChanged="calDate_SelectionChanged2" runat="server"
                        OnVisibleMonthChanged="calDate_VisibleMonthChanged2" />
                </div>
                <asp:TextBox ID="txtDate2" class="date2" runat="server" onchange="ClearValidateTxtDate2()"
                    AutoPostBack="false" MaxLength="10" />
                <img alt="image for calendar" src="Image/cal.png" onclick="popupCalendar2()" align="middle" />
                <asp:RequiredFieldValidator ID="rfvTxtDateNew" runat="server" ErrorMessage="* Select a month"
                    ControlToValidate="txtDate2" EnableClientScript="True" ForeColor="Red" Font-Size="Smaller"
                    Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="validateTxtDate2" runat="server" Font-Size="Smaller" ForeColor="Red"
                    Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="bt_AddPrevious" runat="server" Text="Add Records" OnClick="bt_AddPrevious_Click" />
            </td>
        </tr>
    </table>
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
