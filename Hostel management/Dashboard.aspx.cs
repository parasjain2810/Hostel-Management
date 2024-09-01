using System;
using System.Activities.Expressions;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Dashboard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hostel"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn())
        {
            Response.Redirect("Default.aspx");
            return;
        }
        nostudent();nohostel();

    }
    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
    }

    protected void nostudent()
    {
        string sqltxt = "SELECT COUNT(StudentId) AS TotalStudent ";
        sqltxt += "FROM dbo.Student ";
        sqltxt += "WHERE IsDeleted = 0";

        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            int totalStudents = Convert.ToInt32(dt.Rows[0]["TotalStudent"]);
            lblTotalStudents.Text = totalStudents.ToString();
        }
    }
    protected void nohostel()
    {
        string sqltxt = "SELECT COUNT(StudentHostelId) AS TotalHostelRegisteredStudent ";
        sqltxt += "FROM dbo.StudentHostelRegister ";
        sqltxt += "WHERE IsDeleted = 0";

        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            int totalStudents = Convert.ToInt32(dt.Rows[0]["TotalHostelRegisteredStudent"]);
            Label1.Text = totalStudents.ToString();
        }
    }



    //================================


}