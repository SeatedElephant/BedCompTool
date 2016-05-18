<%@ Page Title="Edit Existing Month" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="True" CodeBehind="EditExistingMonth.aspx.cs" Inherits="BedComplementManager.EditExistingMonth" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">

        //Clear any previous messages on the actionMessage label in 2 seconds to allow further messages to be displayed
        window.onload = function () {
            var seconds = 2;
            setTimeout(function () {
                document.getElementById("<%=actionMessage.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };

    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div>
        <asp:SqlDataSource ID="sourceMainData" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Bed_ComplementConnectionString %>"
            SelectCommand="SELECT A.TheMonth, A.ProviderSiteCode, A.WardLocationCode, A.SpecialtyCode, A.InpatientCount, A.DayCaseCount, A.TrolleyCount, A.RoomCount, A.Comments, P.ProviderSiteName, W.WardLocation, S.MainSpecialtyName, S.SubSpecialtyName
                          FROM [Data_Bed_Complement].[dbo].[Bed_Complement] AS A
                          LEFT OUTER JOIN Data_Reference_Tables.dbo.Lookup_Bed_Complement_Providers AS P
                            ON P.ProviderSiteCode = A.ProviderSiteCode
                          LEFT OUTER JOIN Data_Reference_Tables.dbo.Lookup_Bed_Complement_Wards AS W
                            ON W.WardLocationCode = A.WardLocationCode
                          LEFT OUTER JOIN Data_Reference_Tables.dbo.Lookup_Bed_Complement_Specialties AS S
                            ON S.SpecialtyCode = A.SpecialtyCode WHERE (A.ProviderSiteCode = @ProviderSiteCode AND A.TheMonth = @TheMonth)
                          ORDER BY W.WardLocation, S.MainSpecialtyName"
            DeleteCommand="DELETE FROM [Bed_Complement] WHERE [TheMonth] = @TheMonth AND [ProviderSiteCode] = @ProviderSiteCode AND [WardLocationCode] = @WardLocationCode AND [SpecialtyCode] = @SpecialtyCode"
            InsertCommand="INSERT INTO [Bed_Complement] ([TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [RoomCount], [Comments]) VALUES (@TheMonth, @ProviderSiteCode, @WardLocationCode, @SpecialtyCode, @InpatientCount, @DayCaseCount, @TrolleyCount, @RoomCount, @Comments)"
            UpdateCommand="UPDATE [Bed_Complement] SET [TheMonth] = @TheMonth , [ProviderSiteCode] = @ProviderSiteCode, [WardLocationCode] = @WardLocationCode, [SpecialtyCode] = @SpecialtyCode, [InpatientCount] = @InpatientCount, [DayCaseCount] = @DayCaseCount, [TrolleyCount] = @TrolleyCount, [RoomCount] = @RoomCount, [Comments] = @Comments WHERE [TheMonth] = @TheMonth AND [ProviderSiteCode] = @ProviderSiteCode AND [WardLocationCode] = @WardLocationCode AND [SpecialtyCode] = @SpecialtyCode">
            <SelectParameters>
                <asp:Parameter Name="ProviderSiteCode" Type="String" />
                <asp:Parameter Name="TheMonth" Type="DateTime" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="TheMonth" Type="DateTime" />
                <asp:Parameter Name="ProviderSiteCode" Type="String" />
                <asp:Parameter Name="WardLocationCode" Type="String" />
                <asp:Parameter Name="SpecialtyCode" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TheMonth" Type="DateTime" />
                <asp:Parameter Name="ProviderSiteCode" Type="String" />
                <asp:Parameter Name="WardLocationCode" Type="String" />
                <asp:Parameter Name="SpecialtyCode" Type="String" />
                <asp:Parameter Name="InpatientCount" Type="Int32" />
                <asp:Parameter Name="DayCaseCount" Type="Int32" />
                <asp:Parameter Name="TrolleyCount" Type="Int32" />
                <asp:Parameter Name="RoomCount" Type="Int32" />
                <asp:Parameter Name="Comments" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TheMonth" Type="DateTime" />
                <asp:Parameter Name="ProviderSiteCode" Type="String" />
                <asp:Parameter Name="WardLocationCode" Type="String" />
                <asp:Parameter Name="SpecialtyCode" Type="String" />
                <asp:Parameter Name="InpatientCount" Type="Int32" />
                <asp:Parameter Name="DayCaseCount" Type="Int32" />
                <asp:Parameter Name="TrolleyCount" Type="Int32" />
                <asp:Parameter Name="RoomCount" Type="Int32" />
                <asp:Parameter Name="Comments" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sourceMonth" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Bed_ComplementConnectionString %>"
            SelectCommand="SELECT DISTINCT [TheMonth],
                               CASE WHEN DATEPART(MONTH, [TheMonth]) = 1 THEN 'Jan-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 2 THEN 'Feb-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 3 THEN 'Mar-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 4 THEN 'Apr-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 5 THEN 'May-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 6 THEN 'Jun-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 7 THEN 'Jul-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 8 THEN 'Aug-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 9 THEN 'Sep-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 10 THEN 'Oct-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 11 THEN 'Nov-'
                                    WHEN DATEPART(MONTH, [TheMonth]) = 12 THEN 'Dec-'
                                  END + CAST(DATEPART(YEAR, [TheMonth]) AS CHAR(4)) AS [TheMonthText]    
                           FROM [Bed_Complement]
                           WHERE ProviderSiteCode = @hospitalFilter
                           ORDER BY TheMonth">
            <SelectParameters>
                <asp:Parameter Name="hospitalFilter" Type="String" DefaultValue="7A2AG" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sourceProviderSiteName" runat="server" ConnectionString="<%$ ConnectionStrings:Data_Reference_TablesConnectionString %>"
            SelectCommand="SELECT DISTINCT A.ProviderSiteCode, P.ProviderSiteName
                            FROM [Data_Bed_Complement].[dbo].[Bed_Complement] AS A 
                            LEFT OUTER JOIN Data_Reference_Tables.dbo.Lookup_Bed_Complement_Providers AS P
                            ON P.ProviderSiteCode = A.ProviderSiteCode
                            ORDER BY P.ProviderSiteName">
        </asp:SqlDataSource>
        <h2>
            Edit An Existing Month
        </h2>
        <br />
        <div class="explanatoryParagraph">
            <p>
                To edit an existing month's bed complement figures select the provider site and
                the month that you want to edit on the drop down menus and click the "Go!" button.
                If data for the month exists it will be displayed in the table below. Each record
                for the month can be updated by clicking "edit" (to the left of the row), or deleted
                by clicking "delete" (to left of the row).
            </p>
        </div>
        <br />
        <asp:Label ID="actionMessage" runat="server" Font-Size="Smaller" ForeColor="Red"></asp:Label>
        <table>
            <tr>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr align="left" valign="bottom">
                <td>
                    Select hospital:
                </td>
                <td width="20">
                </td>
                <td>
                    Select month:
                </td>
                <td>
                </td>
            </tr>
            <tr align="center" valign="top">
                <td>
                    <asp:DropDownList ID="ddlHospitals" runat="server" DataSourceID="sourceProviderSiteName"
                        DataTextField="ProviderSiteName" DataValueField="ProviderSiteCode" Width="220px"
                        AutoPostBack="True" OnSelectedIndexChanged="HospitalDDLIndexChanged">
                    </asp:DropDownList>
                </td>
                <td width="20">
                </td>
                <td>
                    <asp:DropDownList ID="ddlEndOfMonthDate" runat="server" DataSourceID="sourceMonth"
                        DataTextField="TheMonthText" DataValueField="TheMonth" Width="100px" AutoPostBack="False">
                    </asp:DropDownList>
                </td>
                <td width="20">
                </td>
                <td>
                    <asp:Button ID="btQueryRefresh" runat="server" Text="Go!" OnClick="btQueryRefresh_QueryRefreshed" />
                </td>
                <td width="20">
                </td>
                <td>
                    Selected Month:
                    <asp:Label ID="selectedMonth" Class="selectedMonth" runat="server" Text="________"></asp:Label>
                </td>
                <td width="20">
                </td>
                <td>
                    Selected Hospital:
                    <asp:Label ID="selectedHospital" Class="selectedHospital" runat="server" Text="________"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="sourceMainData" CellPadding="4"
            EmptyDataText="No rows match the specified site and month." Width="1200px" Font-Names="Arial"
            Font-Size="8pt" ForeColor="#333333" GridLines="Vertical" AutoGenerateColumns="False"
            DataKeyNames="TheMonth, ProviderSiteCode, WardLocationCode, SpecialtyCode" AllowSorting="True"
            OnSorting="GridView1_Sorting" CaptionAlign="Left" HorizontalAlign="Left" ShowHeaderWhenEmpty="False"
            OnRowEditing="GridView1_Editing" OnRowUpdated="GridView1_Updating" OnRowCancelingEdit="Gridview1_CancelEdit"
            OnRowDeleted="Gridview1_Deleted">
            <EditRowStyle BackColor="#FCF805" />
            <EmptyDataRowStyle BackColor="WhiteSmoke" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Left" VerticalAlign="Middle" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#96AFE6" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" HorizontalAlign="Left" VerticalAlign="Middle" />
            <Columns>
                <asp:TemplateField HeaderText="">
                    <ItemStyle HorizontalAlign="Center" Width="60" />
                    <ItemTemplate>
                        <asp:Button ID="deleteButton" runat="server" Font-Size="Smaller" Width="55" Height="25"
                            CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this row?');" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <ItemStyle HorizontalAlign="Center" Width="60" />
                    <ItemTemplate>
                        <asp:Button runat="server" Width="55" Height="25" Font-Size="Smaller" Text="Edit"
                            CommandName="Edit" ID="Edit" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="Update" Text="Update" Font-Size="Smaller" Width="55" Height="25"
                            CommandName="Update" runat="server" OnClientClick="return confirm('Are you sure you want to update this row?');" />
                        <br />
                        <br />
                        <asp:Button ID="Cancel" Text="Cancel" Font-Size="Smaller" Width="55" Height="25"
                            CommandName="Cancel" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TheMonth" HeaderText="Month" InsertVisible="False" SortExpression="TheMonth"
                    ReadOnly="True" Visible="False"></asp:BoundField>
                <asp:BoundField DataField="ProviderSiteName" HeaderText="Hospital" SortExpression="ProviderSiteName"
                    ReadOnly="True" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Middle"
                    HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="WardLocation" HeaderText="Ward" SortExpression="WardLocation"
                    ReadOnly="True" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Middle"
                    HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="MainSpecialtyName" HeaderText="Main Specialty" SortExpression="MainSpecialtyName"
                    ReadOnly="True" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Middle"
                    HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="InpatientCount" HeaderText="Inpatients" SortExpression="InpatientCount"
                    ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="DayCaseCount" HeaderText="Day Cases" SortExpression="DayCaseCount"
                    ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="TrolleyCount" HeaderText="Trollies" SortExpression="TrolleyCount"
                    ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="RoomCount" HeaderText="Side/Single Rooms" SortExpression="RoomCount"
                    ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments"
                    ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center"
                    ApplyFormatInEditMode="False" ControlStyle-Width="320">
                    <ControlStyle Width="320px"></ControlStyle>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
            </Columns>
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
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
