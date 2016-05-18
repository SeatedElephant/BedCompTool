using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace BedComplementManager
{
    public partial class AddToExistingMonth : System.Web.UI.Page
    {
        //Intialize class level variables
        //static DateTime presentMonth = new DateTime();
        //string County;
        //string hospitalNEW;

        /// <summary>
        /// Loads page data to the web form on initially launching the app and when page data is updated
        /// </summary>
        /// <returns>items to the ddlCounty and ddlSpecialty</returns>
        protected void Page_Load(object sender, EventArgs e)
        {
            //Set the value to today so that we always have the present month and bakc in the dropdown list
            //presentMonth = DateTime.Today;
            //if (!Page.IsPostBack)
            //{

            //}
        }

        /// <summary>
        /// Takes the month selected and stores it in a varaible reformting the string so that it always repsresents the month as the first day of the month selected 
        /// </summary>
        /// <param></param>
        /// <returns>The selected month as a string</returns>
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            string SelectedMonth;
            SelectedMonth = calDate.SelectedDate.ToString("d");
            SelectedMonth = "01" + SelectedMonth.Substring(2,8);
            txtDate.Text = SelectedMonth;
            dateField.Style.Value = "display:none;";
        }

        /// <summary>
        /// Handles the month change event on the calendar control keeping the <DIV> tage used to create the pop up visible
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        protected void calDate_VisibleMonthChanged(object sender, System.Web.UI.WebControls.MonthChangedEventArgs e)
        {
            dateField.Style.Value = "display:block;";
        }

        /// <summary>
        /// Handles a change in the selection in the hospital drop down. If the selection changes then the parameter for the wards
        /// drop down list query is cleared and the new hospital value selected added as the new parameter for the wards to be displayed
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        protected void HospitalDDLIndexChanges(object sender, EventArgs e)
        {
            //Clear the message that reports duplicate records or succcess and rows added
            validateNoDuplicates.Text = "";

            sourceWard.SelectParameters.Clear();
            sourceWard.SelectParameters.Add("hospitalFilter", ddlHospital.SelectedValue);
        }

        protected void SelectionChanges(object sender, EventArgs e)
        {
            //Clear the message that reports duplicate records or succcess and rows added
            validateNoDuplicates.Text = "";
        }

                
        /// <summary>
        /// Test to see if the month in the web form already exists in the database, if it does then don't allow the 
        /// individual row described in the web form to be entered and inform  the user
        /// </summary>
        /// <param></param>
        /// <returns>A row of data to be inserted into the database</returns>
        protected void btSubmit_Click(object sender, EventArgs e)
        {
            // Code to check whether any rows exist for the month, if no don't allow inputting the individual record
            string csTest = System.Configuration.ConfigurationManager.ConnectionStrings["Data_Bed_ComplementConnectionString"].ConnectionString;
            SqlConnection conTest = new SqlConnection(csTest);

            //initialize the command object and and define the parameterized SQL      
            SqlCommand cmdTest = new SqlCommand("SELECT [TheMonth] FROM [Bed_Complement] WHERE [TheMonth] = @dateValueTest", conTest);

            //Declare variable for use in the testing whether txtDate.Text can be converted to a valid date
            DateTime txtDateTest;

            //Define the @dateValue parameter 
            SqlParameter dateValueTest = new SqlParameter();
            dateValueTest.ParameterName = "@dateValueTest";

            if (!DateTime.TryParse(txtDate.Text, out txtDateTest))
            {
                validateTxtDate.Text = "* Not a valid date. Select a valid date using the calendar";
                return;
            }

            //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
            //are changed to the first day for the month selected 
            dateValueTest.Value = DateTime.Parse(txtDate.Text).AddDays(-DateTime.Parse(txtDate.Text).Day + 1);

            cmdTest.Parameters.Add(dateValueTest);

            //Open the connection, execute the query and close the connection
            conTest.Open();

            //test if the data has been previously entered. if yes do not run inform the user. 
            //if no then run the call the InsertRecord method to insert the values and inform the user of success
            SqlDataReader rdrTest;
            rdrTest = cmdTest.ExecuteReader();

            if (!rdrTest.HasRows)
            {
                validateNoDuplicates.Text = "* The month entered does not exist. Add new month records before adding an inidividual record. No record entered";
            }
            else
            {
                TestIfTheRowExistsAlready();
            }
            conTest.Close();
        
        }


        /// <summary>
        /// Test to see of the values in the web form are already in the database, to avoid duplicate records
        /// The primary key constraint would throw an error anyway but this handles the situation before any errror occurs
        /// </summary>
        /// <param></param>
        /// <returns>A row of data to be inserted into the database</returns>
        protected void TestIfTheRowExistsAlready()
        {
            validateNoDuplicates.Text = "";

        string csTest = System.Configuration.ConfigurationManager.ConnectionStrings["Data_Bed_ComplementConnectionString"].ConnectionString;
        SqlConnection conTest = new SqlConnection(csTest);
            
        //initialize the command object and and define the parameterized SQL      
        SqlCommand cmdTest = new SqlCommand("SELECT [TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [RoomCount], [Comments] FROM [Bed_Complement] WHERE [TheMonth] = @dateValueTest AND [ProviderSiteCode] = @hospitalTest AND [WardLocationCode] = @wardTest AND [SpecialtyCode] = @specialtyTest", conTest);

        //Define the @hospital parameter 
        SqlParameter hospitalTest = new SqlParameter();
        hospitalTest.ParameterName = "@hospitalTest";
        hospitalTest.Value = ddlHospital.SelectedValue;

        //Define the @ward parameter 
        SqlParameter wardTest = new SqlParameter();
        wardTest.ParameterName = "@wardTest";
        wardTest.Value = ddlWard.SelectedValue;

        //Define the @specialty parameter 
        SqlParameter specialtyTest = new SqlParameter();
        specialtyTest.ParameterName = "@specialtyTest";
        specialtyTest.Value = ddlSpecialty.SelectedValue;


        //Declare variable for use in the testing whether txtDate.Text can be converted to a valid date
        DateTime txtDateTest;

        //Define the @dateValue parameter 
        SqlParameter dateValueTest = new SqlParameter();
        dateValueTest.ParameterName = "@dateValueTest";

        if (!DateTime.TryParse(txtDate.Text, out txtDateTest))
        {
            validateTxtDate.Text = "* Not a valid date. Select a valid date using the calendar";
            return;
        }
        
        //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
        //are changed to the first day for the month selected 
        dateValueTest.Value = DateTime.Parse(txtDate.Text).AddDays(-DateTime.Parse(txtDate.Text).Day + 1);
        
        //Define the @inpatient parameter 
        SqlParameter inpatientsTest = new SqlParameter();
        inpatientsTest.ParameterName = "@inpatientsTest";
        inpatientsTest.Value = int.Parse(txtInpatients.Text);

        //Define the @dayCases parameter 
        SqlParameter dayCasesTest = new SqlParameter();
        dayCasesTest.ParameterName = "@dayCasesTest";
        dayCasesTest.Value = int.Parse(txtDayCases.Text);

        //Define the @trollies parameter 
        SqlParameter trolliesTest = new SqlParameter();
        trolliesTest.ParameterName = "@trolliesTest";
        trolliesTest.Value = int.Parse(txtTrollies.Text);

        //Define the @rooms parameter 
        SqlParameter roomsTest = new SqlParameter();
        roomsTest.ParameterName = "@roomsTest";
        roomsTest.Value = int.Parse(txtRooms.Text);

        //Define the @comments parameter    
        SqlParameter commentTest = new SqlParameter();
        commentTest.ParameterName = "@commentsTest";
        commentTest.Value = txtComments.Text;

        //Add new parameters to the command object
        cmdTest.Parameters.Add(hospitalTest);
        cmdTest.Parameters.Add(wardTest);
        cmdTest.Parameters.Add(specialtyTest);
        cmdTest.Parameters.Add(dateValueTest);
        cmdTest.Parameters.Add(inpatientsTest);
        cmdTest.Parameters.Add(dayCasesTest);
        cmdTest.Parameters.Add(trolliesTest);
        cmdTest.Parameters.Add(roomsTest);
        cmdTest.Parameters.Add(commentTest);

        //test if the data has been previously entered. if yes do not run the insert + wanrd the user. 
        //if no then run the insert and inform the iser of success



        //Open the connection, execute the query and close the connection
        conTest.Open();

        //test if the data has been previously entered. if yes do not run inform the user. 
        //if no then run the call the InsertRecord method to insert the values and inform the user of success
        SqlDataReader rdrTest;
        rdrTest = cmdTest.ExecuteReader();

        if (rdrTest.HasRows)
        {
            validateNoDuplicates.Text = "* Duplicate record exists. No record entered";
        }
        else
        {
            InsertRecord();
        }
        conTest.Close();
        }


        /// <summary>
        /// Submit the data entered in the web form to the database as a new row of data 
        /// </summary>
        /// <param></param>
        /// <returns>A row of data to be inserted into the database</returns>
        protected void InsertRecord()
        {

        string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Data_Bed_ComplementConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);


        //initialize the command object and and define the parameterized SQL      
        SqlCommand cmd = new SqlCommand("INSERT INTO [Bed_Complement] ([TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [RoomCount], [Comments]) VALUES (@dateValue, @hospital, @ward, @specialty, @inpatients, @dayCases, @trollies, @rooms, @comments)", con);
        
        //Define the @hospital parameter 
        SqlParameter hospital = new SqlParameter();
        hospital.ParameterName = "@hospital";
        hospital.Value = ddlHospital.SelectedValue;
        
        //Define the @ward parameter 
        SqlParameter ward = new SqlParameter();
        ward.ParameterName = "@ward";
        ward.Value = ddlWard.SelectedValue;

        //Define the @specialty parameter 
        SqlParameter specialty = new SqlParameter();
        specialty.ParameterName = "@specialty";
        specialty.Value = ddlSpecialty.SelectedValue;
            
        //Define the @dateValue parameter 
        SqlParameter dateValue = new SqlParameter();
        dateValue.ParameterName = "@dateValue";
        
        //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
        //are changed to the first day for the month selected 
        dateValue.Value = DateTime.Parse(txtDate.Text).AddDays(-DateTime.Parse(txtDate.Text).Day + 1);
                               
        //Define the @inpatient parameter 
        SqlParameter inpatients = new SqlParameter();
        inpatients.ParameterName = "@inpatients";
        inpatients.Value = int.Parse(txtInpatients.Text);
        
        //Define the @dayCases parameter 
        SqlParameter dayCases = new SqlParameter();
        dayCases.ParameterName = "@dayCases";
        dayCases.Value = int.Parse(txtDayCases.Text);

        //Define the @trollies parameter 
        SqlParameter trollies = new SqlParameter();
        trollies.ParameterName = "@trollies";
        trollies.Value = int.Parse(txtTrollies.Text);

        //Define the @rooms parameter 
        SqlParameter rooms = new SqlParameter();
        rooms.ParameterName = "@rooms";
        rooms.Value = int.Parse(txtRooms.Text);
        
        //Define the @comments parameter    
        SqlParameter comment = new SqlParameter();
        comment.ParameterName = "@comments";
        comment.Value = txtComments.Text;
            
        //Add new parameters to the command object
        cmd.Parameters.Add(hospital);
        cmd.Parameters.Add(ward);
        cmd.Parameters.Add(specialty);
        cmd.Parameters.Add(dateValue);
        cmd.Parameters.Add(inpatients);
        cmd.Parameters.Add(dayCases);
        cmd.Parameters.Add(trollies);
        cmd.Parameters.Add(rooms);
        cmd.Parameters.Add(comment);

        //Open the connection, execute the query and close the connection
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        validateNoDuplicates.Text = "1 row was added to the database";
        PublishChanges();
        }
        
        /// <summary>
        /// Publish the new changes inserted into the main database and table (Bed_Complement) to the 
        /// Publish_IRIS.dbo.IRIS_063_Bed_Complement and the IRIS_Reporting on 7A2BLSRVINF0003 by running
        /// the stored procedure.
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        protected void PublishChanges()
        {
        string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Published_IRISConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);


        //initialize the command object and and define the parameterized SQL      
        SqlCommand cmd = new SqlCommand("EXEC usp_IRIS_063_Bed_Complement", con);

        //Open the connection, execute the query and close the connection
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        }






    }
}

