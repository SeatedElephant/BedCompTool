<%@ Page Title="Add to Existing Month" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="AddToExistingMonth.aspx.cs" Inherits="BedComplementManager.AddToExistingMonth" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.maskedinput-1.2.2-co.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        //Creates an input mask for the dates textboxs with placeholders to show the format that the user should use
        jQuery(function ($) {
            $(".date").mask("99/99/9999", { placeholder: 'dd/mm/yyyy' });
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

        //This js function is called from the onchange event of the textbox txtDate. It clears any previous error messages
        //about the previous month selection just made not finding any data
        function ClearValidateTxtDate() {
            document.getElementById("<%=validateNoDuplicates.ClientID%>").innerText = "";
        }

    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Add To An Existing Month
    </h2>
    <br />
    <div class="explanatoryParagraph">
        <p>
            To add an individual record to an already existing month select
            the hospital, ward, and specialty and enter the figures for inpatients, day cases
            and trolly beds. Any comments about the record can also be added in the Comments
            box.
        </p>
    </div>
    <br />
    <table cellpadding="4" cellspacing="15">
        <tr>
            <td>
                Hospital:
            </td>
            <td>
                <asp:DropDownList ID="ddlHospital" runat="server" Width="220px" DataSourceID="sourceHospital"
                    DataTextField="ProviderSiteName" DataValueField="ProviderSiteCode" AutoPostBack="True"
                    OnSelectedIndexChanged="HospitalDDLIndexChanges">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Reference_TablesConnectionString %>"
                    SelectCommand="SELECT DISTINCT P.ProviderSiteCode, P.ProviderSiteName
                                   FROM Data_Reference_Tables.dbo.Lookup_Bed_Complement_Providers AS P
                                   ORDER BY P.ProviderSiteName" />
            </td>
        </tr>
        <tr>
            <td>
                Ward:
            </td>
            <td>
                <asp:DropDownList ID="ddlWard" runat="server" DataSourceID="sourceWard" DataTextField="WardLocation"
                    DataValueField="WardLocationCode" Width="220px" AutoPostBack="True" OnSelectedIndexChanged="SelectionChanges">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sourceWard" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Reference_TablesConnectionString %>"
                    SelectCommand="SELECT DISTINCT W.WardLocationCode, W.WardLocation
                                   FROM Data_Reference_Tables.dbo.Lookup_Bed_Complement_Wards AS W
                                   WHERE W.ProviderSiteCode = @hospitalFilter
                                   ORDER BY W.WardLocation">
                    <SelectParameters>
                        <asp:Parameter Name="hospitalFilter" Type="String" DefaultValue="7A2FC" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Specialty:
            </td>
            <td>
                <asp:DropDownList ID="ddlSpecialty" runat="server" Width="220px" DataSourceID="sourceSpecialty"
                    DataTextField="DisplayMainSpecialty" DataValueField="SpecialtyCode" AutoPostBack="True"
                    OnSelectedIndexChanged="SelectionChanges">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sourceSpecialty" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Reference_TablesConnectionString %>"
                    SelectCommand="SELECT SpecialtyCode, LEFT(SpecialtyCode,3) + ' - ' + MainSpecialtyName AS DisplayMainSpecialty 
                                   FROM Lookup_Bed_Complement_Specialties
                                   ORDER BY DisplayMainSpecialty" />
            </td>
        </tr>
        <tr>
            <td>
                Month:
            </td>
            <td>
                <div id="dateField" style="display: none;" align="left" runat="server">
                    <asp:Calendar ID="calDate" OnSelectionChanged="calDate_SelectionChanged" runat="server"
                        OnVisibleMonthChanged="calDate_VisibleMonthChanged" />
                </div>
                <asp:TextBox ID="txtDate" Class="date" runat="server" Text="" onchange="ClearValidateTxtDate()" />
                <img alt="image for calendar" src="Image/cal.png" onclick="popupCalendar()" align="middle" />
                <asp:RequiredFieldValidator ID="rfvTxtDate" runat="server" ErrorMessage="* Select a month"
                    ControlToValidate="txtDate" EnableClientScript="True" ForeColor="Red" Font-Size="Smaller"
                    Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="validateTxtDate" runat="server" Text="" Font-Size="Smaller" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Number of Inpatients Beds:
            </td>
            <td>
                <asp:TextBox ID="txtInpatients" runat="server" Width="42px">0</asp:TextBox>
                <asp:CompareValidator ID="cvTxtInpatients" runat="server" ErrorMessage="* Enter an integer"
                    Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtInpatients" Font-Size="Smaller"
                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="rfvTxtInpatients" runat="server" ErrorMessage="* Enter number of IP beds"
                    ControlToValidate="txtInpatients" Font-Size="Smaller" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Number of Day Case Beds:
            </td>
            <td>
                <asp:TextBox ID="txtDayCases" runat="server" Width="42px">0</asp:TextBox>
                <asp:CompareValidator ID="cvTxtDayCases" runat="server" ErrorMessage="* Enter an integer"
                    Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtDayCases" Font-Size="Smaller"
                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="rfvTxtDayCases" runat="server" ErrorMessage="* Enter number of DC beds"
                    ControlToValidate="txtDayCases" Font-Size="Smaller" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Number of Trollies:
            </td>
            <td>
                <asp:TextBox ID="txtTrollies" runat="server" Width="42px">0</asp:TextBox>
                <asp:CompareValidator ID="cvTxtTrollies" runat="server" ErrorMessage="* Enter an integer"
                    Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtTrollies" Font-Size="Smaller"
                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="rfvTxtTrollies" runat="server" ErrorMessage="* Enter number of Trollies"
                    ControlToValidate="txtTrollies" Font-Size="Smaller" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Number of Side Rooms/Single Rooms:
            </td>
            <td>
                <asp:TextBox ID="txtRooms" runat="server" Width="42px">0</asp:TextBox>
                <asp:CompareValidator ID="cvTxtRooms" runat="server" ErrorMessage="* Enter an integer"
                    Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtRooms" Font-Size="Smaller"
                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Enter number of Rooms"
                    ControlToValidate="txtTrollies" Font-Size="Smaller" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Comments:
            </td>
            <td>
                <asp:TextBox ID="txtComments" runat="server" Height="73px" Width="219px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="btSubmit" runat="server" Text="Submit Bed Complement" OnClick="btSubmit_Click" />
                <asp:Label ID="validateNoDuplicates" runat="server" Font-Size="Smaller" ForeColor="Red"></asp:Label>
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
