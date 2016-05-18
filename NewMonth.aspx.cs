using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; 


namespace BedComplementManager
{
    public partial class NewMonth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        /// <summary>
        /// Adds all the rows for a previous month (selected by the user) to the database so that these can then be edited for a new month, saving the user time
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        protected void bt_AddPrevious_Click(object sender, EventArgs e)
        {
            // Clear the validation labels in case they still contain text 
            validateTxtDate.Text = "";
            validateTxtDate2.Text = "";
            
            //Test to see if both the months are equal if they are then don't continue
            if (txtDate.Text == txtDate2.Text) {
                validateTxtDate.Text = "* The previous month and new months cannot be the same";
                return;
            }
            
            //Set up the sql connection and the the sql command
            string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Data_Bed_ComplementConnectionString"].ConnectionString;
            SqlConnection conTest = new SqlConnection(cs);
            SqlCommand cmdTest = new SqlCommand("SELECT [TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [Comments] FROM Bed_Complement WHERE [TheMonth] = @oldMonth;", conTest);
            SqlCommand cmdTest2 = new SqlCommand("SELECT [TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [Comments] FROM Bed_Complement WHERE [TheMonth] = @newMonth;", conTest);
            
            //declare variable as output in test of whether the text can be converted to a valid date for previous month value text
            DateTime dateTestPrevious;
            
            //Define the parameter for the previously entered data that is to be used as a starting point and add it to the command object
            SqlParameter oldMonth = new SqlParameter();
            oldMonth.ParameterName = "@oldMonth";
            
            //Test to see if the date input as the previous month value is a valid date 
            if (!DateTime.TryParse(txtDate.Text, out dateTestPrevious)) 
        	{
                validateTxtDate.Text = "* Not a valid date. Select a valid date";
                return;
	        }

            //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
            //are changed to the first day for the month selected 
            oldMonth.Value = DateTime.Parse(txtDate.Text).AddDays(-DateTime.Parse(txtDate.Text).Day + 1);

            //Add the old months value to the approriate command parameter for the SQL command
            cmdTest.Parameters.Add(oldMonth);

            //declare varialbe as output in test of whether the text can be converted to a valid date for new month value text
            DateTime dateTestNew;

            //Define the parameter for the previously entered data that is to be used as a starting point and add it to the command object            
            SqlParameter newMonth = new SqlParameter();
            newMonth.ParameterName = "@newMonth";

            //Test to see if the date input as the new month value is a valid date 
            if (!DateTime.TryParse(txtDate2.Text, out dateTestNew))
            {
                validateTxtDate2.Text = "* Not a valid date. Select a valid date";
                return;
            }

            //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
            //are changed to the first day for the month selected 
            newMonth.Value = DateTime.Parse(txtDate2.Text).AddDays(-DateTime.Parse(txtDate2.Text).Day + 1);
            cmdTest2.Parameters.Add(newMonth);
            
            //Open the sql connection, execute the query
            conTest.Open();
            
        //Test if the data has been previously entered. If yes do not run and inform the user, 
        //if no then call the InsertRecord method to insert the as a new month rows and inform the user of success

        SqlDataReader rdrTest2;
        rdrTest2 = cmdTest.ExecuteReader();


        SqlDataReader rdrTest;
        rdrTest = cmdTest2.ExecuteReader();

        if (rdrTest.HasRows)
        {
            validateTxtDate2.Text = "* Records already exist for the new month. No records entered";
        }
        
        if (!rdrTest2.HasRows)
        {
            validateTxtDate.Text = "* No records exist for the previous month selected. No records entered";
        }

        if (rdrTest2.HasRows)
        {
            validateTxtDate.Text = "";
        }


        if (!rdrTest.HasRows && rdrTest2.HasRows)
        {
            InsertRecords();
        }
        
        //Close the connection
        conTest.Close();
       }


        /// <summary>
        /// Takes the month selected and stores it in a varaible reformating the string so that it always repsresents the month as the first day of the month selected 
        /// </summary>
        /// <param></param>
        /// <returns>The selected month as a string</returns>
        protected void calDate_SelectionChanged(object sender, EventArgs e)
        {
            //Clear the validation text in case a previous selection caused an error message
            validateTxtDate.Text = "";

            string SelectedMonth;
            SelectedMonth = calDate.SelectedDate.ToString("d");
            SelectedMonth = "01" + SelectedMonth.Substring(2, 8);
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
        /// Takes the month selected and stores it in a varaible reformating the string so that it always repsresents the month as the first day of the month selected 
        /// </summary>
        /// <param></param>
        /// <returns>The selected month as a string</returns>
        protected void calDate_SelectionChanged2(object sender, EventArgs e)
        {
            //Clear the validation text in case a previous selection caused an error message
            validateTxtDate2.Text = "";
            
            string SelectedMonth2;
            SelectedMonth2 = calDate2.SelectedDate.ToString("d");
            SelectedMonth2 = "01" + SelectedMonth2.Substring(2, 8);
            txtDate2.Text = SelectedMonth2;
            dateField2.Style.Value = "display:none;";
        }
        
        /// <summary>
        /// Handles the month change event on the calendar control keeping the <DIV> tage used to create the pop up visible
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        protected void calDate_VisibleMonthChanged2(object sender, System.Web.UI.WebControls.MonthChangedEventArgs e)
        {
            dateField2.Style.Value = "display:block;";
        }

        /// <summary>
        ///
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        protected void InsertRecords()
        {
            //Set up the sql connection and the the sql command
            string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Data_Bed_ComplementConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand("INSERT INTO [Bed_Complement] ([TheMonth], [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [Comments]) SELECT @newMonth, [ProviderSiteCode], [WardLocationCode], [SpecialtyCode], [InpatientCount], [DayCaseCount], [TrolleyCount], [Comments] FROM [Bed_Complement] WHERE ([TheMonth] = @oldMonth);", con);

            //Define the parameter for the previously entered data that is to be used as a starting point and add it to the command object
            SqlParameter oldMonth = new SqlParameter();
            oldMonth.ParameterName = "@oldMonth";
            
            //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
            //are changed to the first day for the month selected 
            oldMonth.Value = DateTime.Parse(txtDate.Text).AddDays(-DateTime.Parse(txtDate.Text).Day + 1);
            cmd.Parameters.Add(oldMonth);

            //Define the parameter for the previously entered data that is to be used as a starting point and add it to the command object            
            SqlParameter newMonth = new SqlParameter();
            newMonth.ParameterName = "@newMonth";

            //Populate the parameter value, and ensure that any dates that are entered other than the 1st of the
            //are changed to the first day for the month selected 
            newMonth.Value = DateTime.Parse(txtDate2.Text).AddDays(-DateTime.Parse(txtDate2.Text).Day + 1);
            cmd.Parameters.Add(newMonth);

            //Open the sql connection, execute the query
            con.Open();
            cmd.ExecuteNonQuery();

            //Close connection
            con.Close();

            //Inform the user of success
            validateTxtDate2.Text = "The previous months values were added as a starting point for the new month";
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


