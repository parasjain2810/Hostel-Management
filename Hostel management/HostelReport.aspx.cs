using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HostelReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hostel"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn())
        {
            Response.Redirect("Default.aspx");
            return;
        }
        if (!IsPostBack)
        {
            BindDdlWings();
            TableStudent();
        }
    }
    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
    }
    protected void BindDdlWings()
    {
        string sqltxt = "select * from Hostels where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlWingName.DataSource = dt;
        ddlWingName.DataBind();
    }
    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.HostelRoom.RoomNo, dbo.Student.StudentName, dbo.Student.MobileNo, dbo.Fee.TotalAmount, dbo.Fee.Advance, dbo.Fee.Pending, dbo.Fee.IsDeleted, dbo.HostelRoom.Floor, dbo.HostelRoom.RoomType, ";
        sqltxt = sqltxt + "dbo.HostelRoom.Facilities, dbo.Hostels.HostelName ";
        sqltxt = sqltxt + "FROM dbo.Fee INNER JOIN ";
        sqltxt = sqltxt + "dbo.HostelRoom ON dbo.Fee.RoomNoId = dbo.HostelRoom.RoomId INNER JOIN ";
        sqltxt = sqltxt + "dbo.Student ON dbo.Fee.StudentId = dbo.Student.StudentId INNER JOIN ";
        sqltxt = sqltxt + "dbo.Hostels ON dbo.HostelRoom.HostelId = dbo.Hostels.HostelId ";
        sqltxt = sqltxt + "WHERE dbo.Fee.IsDeleted = 0  ";


        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();

        sda.Fill(dt);
        con.Close();
        GridViewStudents.DataSource = dt;
        GridViewStudents.DataBind(); if (GridViewStudents.Rows.Count > 0)
        {
            GridViewStudents.HeaderRow.TableSection = TableRowSection.TableHeader;
            GridViewStudents.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }
    protected void search(object sender, EventArgs e)
    {

        if (ddlWingName.SelectedValue == "all")
        {

            TableStudent();
        }
        else
        {
            string sqltxt = "SELECT dbo.HostelRoom.RoomNo, dbo.Student.StudentName, dbo.Student.MobileNo, dbo.Fee.TotalAmount, dbo.Fee.Advance, dbo.Fee.Pending, dbo.Fee.IsDeleted, dbo.HostelRoom.Floor, dbo.HostelRoom.RoomType, ";
            sqltxt = sqltxt + "dbo.HostelRoom.Facilities, dbo.Hostels.HostelName ";
            sqltxt = sqltxt + "FROM dbo.Fee INNER JOIN ";
            sqltxt = sqltxt + "dbo.HostelRoom ON dbo.Fee.RoomNoId = dbo.HostelRoom.RoomId INNER JOIN ";
            sqltxt = sqltxt + "dbo.Student ON dbo.Fee.StudentId = dbo.Student.StudentId INNER JOIN ";
            sqltxt = sqltxt + "dbo.Hostels ON dbo.HostelRoom.HostelId = dbo.Hostels.HostelId ";
            sqltxt = sqltxt + "WHERE dbo.Fee.IsDeleted = 0 AND dbo.Hostels.HostelId = '" + ddlWingName.SelectedValue + "'";


            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);
            if (con.State == ConnectionState.Closed)
                con.Open();

            sda.Fill(dt);
            con.Close();
            GridViewStudents.DataSource = dt;
            GridViewStudents.DataBind(); if (GridViewStudents.Rows.Count > 0)
            {
                GridViewStudents.HeaderRow.TableSection = TableRowSection.TableHeader;
                GridViewStudents.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }
    }
    
}