using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.EnterpriseServices;
using System.Activities.Statements;

public partial class Room : System.Web.UI.Page
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
        if (Convert.ToString(Session["EditId"]) != "")
        {
            lblId.Text = Session["EditId"].ToString();
            GetDetail();
            Session["EditId"] = "";
        }
    }
    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
    }
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='Room.aspx';", true);
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
        string sqltxt = "SELECT dbo.HostelRoom.RoomId, dbo.Hostels.HostelName, dbo.HostelRoom.RoomNo, ";
        sqltxt = sqltxt + "dbo.HostelRoom.Floor, dbo.HostelRoom.RoomType, dbo.HostelRoom.Facilities, ";
        sqltxt = sqltxt + "dbo.HostelRoom.Rent, dbo.HostelRoom.IsDeleted ";
        sqltxt = sqltxt + "FROM dbo.HostelRoom INNER JOIN ";
        sqltxt = sqltxt + "dbo.Hostels ON dbo.HostelRoom.HostelId = dbo.Hostels.HostelId ";
        sqltxt = sqltxt + "WHERE dbo.HostelRoom.IsDeleted = 0";

        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();

        sda.Fill(dt);
        con.Close();
        GridViewStudents.DataSource = dt;
        GridViewStudents.DataBind();
        if (GridViewStudents.Rows.Count > 0)
        {
            GridViewStudents.HeaderRow.TableSection = TableRowSection.TableHeader;
            GridViewStudents.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "";
       
        if (lblId.Text == "0")
        {
            sql = "INSERT INTO HostelRoom ( HostelId, RoomNo, Floor, RoomType, Rent, Facilities,IsDeleted)";
            sql = sql+ " VALUES ('" + ddlWingName.SelectedValue + "', '" + txtroom.Text + "', '" + DDLFloor.SelectedValue + "', '" + ddlRoomtype.SelectedValue + "', ";
            sql = sql + "'" + txtrent.Text + "', '" + ddlfacilities.SelectedValue + "', 0)";



        }
        else
        {
           sql= "UPDATE HostelRoom SET " +
                         "HostelId = '" + ddlWingName.SelectedValue + "', " +
                         "RoomNo = '" + txtroom.Text + "', " +
                         "Floor = '" + DDLFloor.SelectedValue + "', " +
                         "RoomType = '" + ddlRoomtype.SelectedValue + "', " +
                         "Rent = '" + txtrent.Text + "', " +
                         "Facilities = '" + ddlfacilities.SelectedValue + "' " +
                         "WHERE RoomId = '" + lblId.Text + "'";
        }



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='Room.aspx';", true);

    }
    protected void GetDetail()
    {
        string sqltxt = "select * from HostelRoom WHERE RoomId = '" + lblId.Text + "'";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            ddlWingName.SelectedValue = dt.Rows[0]["HostelId"].ToString();
            txtroom.Text = dt.Rows[0]["RoomNo"].ToString();
            DDLFloor.SelectedValue = dt.Rows[0]["Floor"].ToString();
            ddlRoomtype.SelectedValue = dt.Rows[0]["Roomtype"].ToString();
            txtrent.Text = dt.Rows[0]["Rent"].ToString();
            ddlfacilities.SelectedValue = dt.Rows[0]["Facilities"].ToString();

        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;

        string sql = "";
        sql = "UPDATE HostelRoom SET IsDeleted=1 WHERE RoomId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='Room.aspx';", true);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("Room.aspx");
    }
}