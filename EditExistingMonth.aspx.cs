using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

namespace BedComplementManager
{
    public partial class EditExistingMonth : System.Web.UI.Page
    {
        /// <summary>
        /// This is the main class for view and editing the records in the Bed Complement Management database.
        /// Allow selection of the records by hospital and the month
        /// D.Morris 04-03-2015
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static DateTime TheMonth;

        public void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            MainQueryRefresh();
        }

        protected void btQueryRefresh_QueryRefreshed(object sender, EventArgs e)
        {
            actionMessage.Text = "";
            MainQueryRefresh();

            //Display the presently selected month so that the user is aware of what month is being displayed in the gridview
            selectedMonth.Text = ddlEndOfMonthDate.SelectedItem.Text;

            //Display the presently selected hospital so that the user is aware of what hospital is being displayed in the gridview
            selectedHospital.Text = ddlHospitals.SelectedItem.Text;
        }


        protected void GridView1_Editing(object sender, EventArgs e)
        {
            // The GridView control is entering edit mode. Clear the message label.
            actionMessage.Text = "";
            MainQueryRefresh();
        }

        protected void GridView1_Updating(Object sender, GridViewUpdatedEventArgs e)
        {
            // Indicate whether the update operation succeeded.
            if (e.Exception == null)
            {
                actionMessage.Text = "Row updated successfully.";
                PublishChanges();
                
            }
            else
            {
                e.ExceptionHandled = true;
                actionMessage.Text = "An error occurred while attempting to update the row.";
            }
            MainQueryRefresh();
        }


        protected void MainQueryRefresh()
        {

            TheMonth = Convert.ToDateTime(ddlEndOfMonthDate.SelectedValue);

            //Clear the parameter/variable @Hospital so that @Hospital can be declared again     
            sourceMainData.SelectParameters.Clear();

            //Declare the parameter @Hospital for the SQL query and assign the value from the drop down
            sourceMainData.SelectParameters.Add("ProviderSiteCode", ddlHospitals.SelectedValue);
            sourceMainData.SelectParameters.Add("TheMonth", Convert.ToString(TheMonth));

            //Pass the query string to the SelecCommand property with @Hospital assigned as it's value
            //sourceMainData.SelectCommand = "SELECT * FROM Bed_Complement WHERE (ProviderSiteCode = @ProviderSiteCode AND TheMonth = @TheMonth)";
        }

        protected void Gridview1_CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            MainQueryRefresh();
        }

        protected void HospitalDDLIndexChanged(object sender, EventArgs e)
        {
            actionMessage.Text = "";
            sourceMonth.SelectParameters.Clear();
            sourceMonth.SelectParameters.Add("hospitalFilter", ddlHospitals.SelectedValue);
        }

        protected void Gridview1_Deleted(Object sender, GridViewDeletedEventArgs e)
        {
            // Indicate whether the update operation succeeded.
            if (e.Exception == null)
            {
                actionMessage.Text = "Row deleted.";
                PublishChanges();
            }
            else
            {
                e.ExceptionHandled = true;
                actionMessage.Text = "An error occurred while attempting to delete the row.";
            }
            MainQueryRefresh();
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


