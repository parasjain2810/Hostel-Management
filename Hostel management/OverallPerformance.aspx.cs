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

public partial class OverallPerformance : System.Web.UI.Page
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
            BindDdlClass();

            TableStudent();
        }
        if (Convert.ToString(Session["EditId"]) != "")
        {
            lblId.Text = Session["EditId"].ToString();
            GetDetail();
            BindDdlStudent();
            BindDdlSection();
            Session["EditId"] = "";
        }
    }

    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
    }
    protected void BindDdlSection()
    {
        string sqltxt = "select * from Sections where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        ddlsection.DataSource = dt;
        ddlsection.DataBind();

    }
    protected void BindDdlStudent()
    {
        string sqltxt = "select * from Student where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlStudentName.DataSource = dt;
        ddlStudentName.DataBind();
    }
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='OverallPerformance.aspx';", true);
    }
    protected void BindDdlClass()
    {
        string sqltxt = "select * from Class where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        ddlclass.DataSource = dt;
        ddlclass.DataBind();

    }
 
    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.OverallResult.OverallResultId, dbo.Student.StudentName, dbo.Class.Class, dbo.Sections.Section, dbo.OverallResult.Per1, dbo.OverallResult.Per2, dbo.OverallResult.OverallPer, dbo.OverallResult.IsDeleted ";
        sqltxt = sqltxt + "FROM dbo.OverallResult INNER JOIN ";
        sqltxt = sqltxt + "dbo.Student ON dbo.OverallResult.StudentId = dbo.Student.StudentId INNER JOIN ";
        sqltxt = sqltxt + "dbo.Class ON dbo.OverallResult.ClassId = dbo.Class.ClassId INNER JOIN ";
        sqltxt = sqltxt + "dbo.Sections ON dbo.OverallResult.SectionId = dbo.Sections.SectionId ";
        sqltxt = sqltxt + "WHERE (dbo.OverallResult.IsDeleted = 0)";
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
        decimal sem1, sem2, overall;
        if (!decimal.TryParse(txtSem1Percent.Text, out sem1)) sem1 = 0;
        if (!decimal.TryParse(txtSem2Percent.Text, out sem2)) sem2 = 0;
        overall = (sem1 + sem2) / 2;
        txtOverallPercent.Text = overall.ToString("F2");

        string sql = "";

        if (lblId.Text == "0")
        {
            sql = "INSERT INTO OverallResult ( ClassId, SectionId, StudentId, per1, Per2, Overallper,IsDeleted)";
            sql = sql + " VALUES ('" + ddlclass.SelectedValue + "', '" + ddlsection.Text + "', '" + ddlStudentName.SelectedValue + "', '" + txtSem1Percent.Text + "', ";
            sql = sql + "'" + txtSem2Percent.Text + "', '" + txtOverallPercent.Text + "', 0)";



        }
        else
        {
            sql = "UPDATE OverallResult SET " +
                          "ClassId = '" + ddlclass.SelectedValue + "', " +
                          "SectionId = '" + ddlsection.SelectedValue + "', " +
                          "StudentId = '" + ddlStudentName.SelectedValue + "', " +
                          "per1 = '" + txtSem1Percent.Text + "', " +
                          "Per2 = '" + txtSem2Percent.Text + "', " +
                          "Overallper = '" + txtOverallPercent.Text + "' " +
                          "WHERE OverallResultId = '" + lblId.Text + "'";
        }



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='OverallPerFormance.aspx';", true);

    }
    protected void GetDetail()
    {
        string sqltxt = "select * from OverallResult WHERE OverallResultId = '" + lblId.Text + "'";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            ddlclass.SelectedValue = dt.Rows[0]["ClassId"].ToString();
            ddlsection.SelectedValue = dt.Rows[0]["SectionId"].ToString();
            ddlStudentName.SelectedValue = dt.Rows[0]["StudentId"].ToString();
            txtSem1Percent.Text = dt.Rows[0]["Per1"].ToString();
            txtSem2Percent.Text = dt.Rows[0]["Per2"].ToString();
            txtOverallPercent.Text = dt.Rows[0]["Overallper"].ToString();

        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;

        string sql = "";
        sql = "UPDATE OverallResult SET IsDeleted=1 WHERE OverallResultId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='OverallPerFormance.aspx';", true);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("OverallPerFormance.aspx");
    }

    protected void classselect(object sender, EventArgs e)
    {
        string selectedclass = ddlclass.SelectedValue;
        ddlsection.Items.Clear();
        ddlsection.Items.Add(new ListItem { Value = "", Text = "--Select Student--" });
        string sql = "SELECT dbo.Class.Class,dbo.Sections.SectionId, dbo.Sections.Section, dbo.Class.IsDeleted " +
              "FROM dbo.Class " +
              "INNER JOIN dbo.Sections ON dbo.Class.ClassId = dbo.Sections.ClassId " +
              "WHERE dbo.Sections.IsDeleted = 0 AND dbo.Class.ClassId = '" + selectedclass + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }
        SqlDataReader reader = cmd.ExecuteReader();
        while (reader.Read())
        {

            ddlsection.Items.Add(new ListItem
            {
                Value = reader["SectionId"].ToString(),
                Text = reader["Section"].ToString()
            });
        }

    }
    protected void StudentnameSelect(object sender, EventArgs e)
    {
        string selectedclass = ddlclass.SelectedValue;
        string selectedSection = ddlsection.SelectedValue;
        ddlStudentName.Items.Clear();
        ddlStudentName.Items.Add(new ListItem { Value = "", Text = "--Select Student--" });
        String sql = "SELECT dbo.Student.StudentId, dbo.Student.StudentName " +
             "FROM dbo.Class " +
             "INNER JOIN dbo.Student ON dbo.Class.ClassId = dbo.Student.ClassId " +
             "INNER JOIN dbo.Sections ON dbo.Student.SectionId = dbo.Sections.SectionId " +
             "WHERE dbo.Class.IsDeleted = 0 " +
             "AND dbo.Student.ClassId = '" + selectedclass + "' " +
             "AND dbo.Student.SectionId = '" + selectedSection + "'";


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
}