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

public partial class StudentReportsaspx : System.Web.UI.Page
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
    }
    private bool IsUserLoggedIn()
{
    return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
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
    protected void classselect(object sender, EventArgs e)
    {
        if (ddlclass.SelectedValue == "all") 
        {
            ddlsection.Items.Clear();
        }
        else
        {
            string selectedclass = ddlclass.SelectedValue;
            ddlsection.Items.Clear();
            ddlsection.Items.Add(new ListItem { Value = "", Text = "--Select Student--" });
            string sql = "SELECT dbo.Class.Class,dbo.Sections.SectionId, dbo.Sections.Section, dbo.Class.IsDeleted ";
            sql = sql + "FROM dbo.Class ";
            sql = sql + "INNER JOIN dbo.Sections ON dbo.Class.ClassId = dbo.Sections.ClassId ";
            sql = sql + "WHERE dbo.Sections.IsDeleted = 0 AND dbo.Class.ClassId = '" + selectedclass + "'";

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
        if (GridViewStudents.Rows.Count > 0)
        {
            GridViewStudents.HeaderRow.TableSection = TableRowSection.TableHeader;
            GridViewStudents.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }
    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.Student.StudentId, dbo.Student.StudentName, dbo.Student.MobileNo, dbo.Student.DOB, dbo.Student.RollNo, dbo.Student.Address, ";
        sqltxt = sqltxt + "dbo.Student.FatherName, dbo.Student.MotherName, dbo.Sections.Section, dbo.Class.Class, dbo.Cities.Cities, ";
        sqltxt = sqltxt + "dbo.Gender.Gender ";
        sqltxt = sqltxt + "FROM dbo.Class ";
        sqltxt = sqltxt + "INNER JOIN dbo.Student ON dbo.Class.ClassId = dbo.Student.ClassId ";
        sqltxt = sqltxt + "INNER JOIN dbo.Sections ON dbo.Student.SectionId = dbo.Sections.SectionId ";
        sqltxt = sqltxt + "INNER JOIN dbo.Cities ON dbo.Student.CityId = dbo.Cities.CityId ";
        sqltxt = sqltxt + "INNER JOIN dbo.Gender ON dbo.Student.GenderId = dbo.Gender.GenderId ";
        sqltxt = sqltxt + "WHERE dbo.Student.IsDeleted = 0";

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
        String classId = ddlclass.SelectedValue;

        int sectionId;

        
        if (classId == "all")
        {
            
            TableStudent();
        }
        else
        {
            if (!int.TryParse(ddlsection.SelectedValue, out sectionId) || sectionId == 0)
            {
                lblError.Text = "Please select a section.";
                lblError.Visible = true;
                lblError.ForeColor = Color.Red;
                return;
            }
            lblError.Visible = false;
            string sqltxt = "SELECT dbo.Student.StudentId, dbo.Student.StudentName, dbo.Student.MobileNo, dbo.Student.DOB, dbo.Student.RollNo, dbo.Student.Address, ";
            sqltxt = sqltxt + "dbo.Student.FatherName, dbo.Student.MotherName, dbo.Sections.Section, dbo.Class.Class, dbo.Cities.Cities, ";
            sqltxt = sqltxt + "dbo.Gender.Gender ";
            sqltxt = sqltxt + "FROM dbo.Class ";
            sqltxt = sqltxt + "INNER JOIN dbo.Student ON dbo.Class.ClassId = dbo.Student.ClassId ";
            sqltxt = sqltxt + "INNER JOIN dbo.Sections ON dbo.Student.SectionId = dbo.Sections.SectionId ";
            sqltxt = sqltxt + "INNER JOIN dbo.Cities ON dbo.Student.CityId = dbo.Cities.CityId ";
            sqltxt = sqltxt + "INNER JOIN dbo.Gender ON dbo.Student.GenderId = dbo.Gender.GenderId ";
            sqltxt = sqltxt + "WHERE dbo.Student.IsDeleted = 0  AND dbo.Student.ClassId = '" + classId + "' AND dbo.Student.SectionId = '" + sectionId + "'";

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
    }
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='StudentReportsaspx.aspx';", true);

    }
}