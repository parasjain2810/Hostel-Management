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

public partial class HostelRegistration : System.Web.UI.Page
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
            BindDdlClass();
            TableStudent();
            
            if (Convert.ToString(Session["EditId"]) != "")
            {
                lblId.Text = Session["EditId"].ToString();
                GetDetail();
                BindDdlRoom();
                Session["EditId"] = "";
            }
        }
    }
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='HostelRegistration.aspx';", true);
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
    protected void BindDdlstudent()
    {
        string sqltxt = "select * from Stundents where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlStudentName.DataSource = dt;
        ddlStudentName.DataBind();
    }

        protected void BindDdlClass()
    {
        string sqltxt = "select * from Class where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlClass.DataSource = dt;
        ddlClass.DataBind();
    }
    protected void BindDdlRoom()
    {
        string sqltxt = "select * from HostelRoom where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlroomno.DataSource = dt;
        ddlroomno.DataBind();
    }
    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.StudentHostelRegister.StudentHostelId, dbo.Student.StudentName, dbo.Class.Class, dbo.HostelRoom.RoomNo, dbo.HostelRoom.Floor, dbo.HostelRoom.Rent, dbo.HostelRoom.Facilities, dbo.HostelRoom.RoomType, ";
        sqltxt += "dbo.StudentHostelRegister.IsDeleted, dbo.Hostels.HostelName ";
        sqltxt += "FROM dbo.StudentHostelRegister INNER JOIN ";
        sqltxt += "dbo.HostelRoom ON dbo.StudentHostelRegister.RoomId = dbo.HostelRoom.RoomId INNER JOIN ";
        sqltxt += "dbo.Class ON dbo.StudentHostelRegister.ClassId = dbo.Class.ClassId INNER JOIN ";
        sqltxt += "dbo.Student ON dbo.StudentHostelRegister.StudentId = dbo.Student.StudentId INNER JOIN ";
        sqltxt += "dbo.Hostels ON dbo.StudentHostelRegister.HostelId = dbo.Hostels.HostelId ";
        sqltxt += "WHERE dbo.StudentHostelRegister.IsDeleted = 0";

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
    protected void classselect(object sender, EventArgs e)
    {
        string selectedclass = ddlClass.SelectedValue;
        ddlStudentName.Items.Clear();
        ddlStudentName.Items.Add(new ListItem { Value = "", Text = "--Select Student--" });
        string sql = "SELECT dbo.Class.ClassId, dbo.Class.Class, dbo.Student.StudentName, dbo.Student.StudentId ";
        sql += "FROM dbo.Student ";
        sql += "INNER JOIN dbo.Class ON dbo.Student.ClassId = dbo.Class.ClassId ";
        sql += "WHERE dbo.Class.IsDeleted = 0 AND dbo.Student.ClassId='" + selectedclass + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }
        SqlDataReader reader = cmd.ExecuteReader();
        while (reader.Read())
        {

            ddlStudentName.Items.Add(new ListItem
            {
                Value = reader["StudentId"].ToString(),
                Text = reader["StudentName"].ToString()
            });
        }

    }
    protected void roomno(object sender, EventArgs e)
    {
        string selectedwingsname = ddlWingName.SelectedValue;
        ddlroomno.Items.Clear();
        ddlroomno.Items.Add(new ListItem { Value = "", Text = "--Select Room NO.--" });
        string sql = "SELECT dbo.HostelRoom.RoomNo, dbo.Hostels.HostelName, dbo.HostelRoom.IsDeleted , dbo.HostelRoom.HostelId, dbo.HostelRoom.RoomId ";
        sql += "FROM dbo.HostelRoom ";
        sql += "INNER JOIN dbo.Hostels ON dbo.HostelRoom.HostelId = dbo.Hostels.HostelId ";
        sql += "WHERE dbo.HostelRoom.IsDeleted = 0 AND dbo.HostelRoom.HostelId='" + selectedwingsname + "'";



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }
        SqlDataReader reader = cmd.ExecuteReader();
        while (reader.Read())
        {

            ddlroomno.Items.Add(new ListItem
            {
                Value = reader["RoomId"].ToString(),
                Text = reader["RoomNo"].ToString()
            });
        }
    }

        protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "";

        if (lblId.Text == "0")
        {
            sql = "INSERT INTO StudentHostelRegister ( ClassId, StudentId, HostelId, RoomId,IsDeleted)";
            sql = sql + " VALUES ('" + ddlClass.SelectedValue + "', '" + ddlStudentName.SelectedValue + "', '" + ddlWingName.SelectedValue + "', '" + ddlroomno.SelectedValue + "',0) ";
        }
        else
        {
            sql = "UPDATE StudentHostelRegister SET " +
                "ClassId = '" + ddlClass.SelectedValue + "', " +
                "StudentId = '" + ddlStudentName.SelectedValue + "', " +
                "HostelId = '" + ddlWingName.SelectedValue + "', " +
                "RoomId = '" + ddlroomno.SelectedValue + "' " +
                "WHERE StudentHostelId = '" + lblId.Text + "'";
        }



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='HostelRegistration.aspx';", true);

    }
    protected void GetDetail()
    {
        string sqltxt = "select * from StudentHostelRegister WHERE StudentHostelId = '" + lblId.Text + "'";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            ddlClass.SelectedValue = dt.Rows[0]["ClassId"].ToString();
            ddlStudentName.SelectedValue = dt.Rows[0]["StudentId"].ToString();
            ddlWingName.Text = dt.Rows[0]["HostelId"].ToString();
            ddlroomno.Text = dt.Rows[0]["RoomId"].ToString();

        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;

        string sql = "";
        sql = "UPDATE StudentHostelRegister SET IsDeleted=1 WHERE StudentHostelId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='HostelRegistration.aspx';", true);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("HostelRegistration.aspx");
    }
}