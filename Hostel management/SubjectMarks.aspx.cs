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


public partial class SubjectMarks : System.Web.UI.Page
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
            if (Convert.ToString(Session["EditId"]) != "")
            {
                lblId.Text = Session["EditId"].ToString();
                GetDetail();
                BindDdlSection();
                BindDdlStudent();
                Session["EditId"] = "";
            }
        }
    }
    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
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
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='SubjectMarks.aspx';", true);
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

    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.StudentAcademic.AcademicId, dbo.StudentAcademic.Semester, dbo.Class.Class, dbo.Sections.Section, dbo.Student.StudentName, dbo.StudentAcademic.Science, dbo.StudentAcademic.Math, dbo.StudentAcademic.English, ";
        sqltxt += "dbo.StudentAcademic.Hindi, dbo.StudentAcademic.TotalMarks, dbo.StudentAcademic.Percentage, dbo.StudentAcademic.Grade, dbo.StudentAcademic.IsDeleted ";
        sqltxt += "FROM dbo.StudentAcademic INNER JOIN ";
        sqltxt += "dbo.Class ON dbo.StudentAcademic.ClassId = dbo.Class.ClassId INNER JOIN ";
        sqltxt += "dbo.Sections ON dbo.StudentAcademic.SectionId = dbo.Sections.SectionId INNER JOIN ";
        sqltxt += "dbo.Student ON dbo.StudentAcademic.StudentId = dbo.Student.StudentId ";
        sqltxt += "WHERE dbo.StudentAcademic.IsDeleted = 0";
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
        int science, math, english, hindi, totalMarks;
        if (!int.TryParse(txtScience.Text, out science)) science = 0;
        if (!int.TryParse(txtMath.Text, out math)) math = 0;
        if (!int.TryParse(txtEnglish.Text, out english)) english = 0;
        if (!int.TryParse(txtHindi.Text, out hindi)) hindi = 0;

        totalMarks = science + math + english + hindi;
        txtTotalMarks.Text = totalMarks.ToString();

        decimal percentage = (totalMarks / 400M) * 100;
        txtPercentage.Text = percentage.ToString("F0") + '%';

        string grade = "";
        if (percentage >= 90) grade = "A";
        else if (percentage >= 80) grade = "B";
        else if (percentage >= 60) grade = "C";
        else if (percentage >= 40) grade = "D";
        else grade = "F";
        txtGrade.Text = grade;

        string sql = "";

        if (lblId.Text == "0")
        {
            sql = "INSERT INTO StudentAcademic ( Semester,ClassId, SectionId, StudentId, Science, Math, English,Hindi,TotalMarks,Percentage,Grade,IsDeleted)";
            sql = sql + " VALUES ('" + txtSemester.Text + "','" + ddlclass.SelectedValue + "', '" + ddlsection.SelectedValue + "', '" + ddlStudentName.SelectedValue + "', '" + txtScience.Text + "', ";
            sql = sql + "'" + txtMath.Text + "', '" + txtEnglish.Text + "', '" + txtHindi.Text + "', '" + txtTotalMarks.Text + "', '" + txtPercentage.Text + "', '" + txtGrade.Text + "', 0)";  
        }
        else
        {
            sql = "UPDATE StudentAcademic SET " +"ClassId = '" + ddlclass.SelectedValue + "', " +"Semester = '" + txtSemester.Text + "', " +"SectionId = '" + ddlsection.SelectedValue + "', " +
                          "StudentId = '" + ddlStudentName.SelectedValue + "', " +"Science = '" + txtScience.Text + "', " +"Math = '" + txtMath.Text + "', " +
                          "English = '" + txtEnglish.Text + "', " +"Hindi = '" + txtHindi.Text + "'," +"TotalMarks = '" + txtTotalMarks.Text + "'," +"Percentage = '" + txtPercentage.Text + "'," +
                          "Grade = '" + txtGrade.Text + "'" +"WHERE AcademicId = '" + lblId.Text + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='SubjectMarks.aspx';", true);
    }
    protected void GetDetail()
    {
        string sqltxt = "select * from StudentAcademic WHERE AcademicId = '" + lblId.Text + "'";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            ddlclass.SelectedValue = dt.Rows[0]["ClassId"].ToString();
            txtSemester.Text = dt.Rows[0]["Semester"].ToString();
            ddlsection.SelectedValue = dt.Rows[0]["SectionId"].ToString();
            ddlStudentName.SelectedValue = dt.Rows[0]["StudentId"].ToString();
            txtScience.Text = dt.Rows[0]["Science"].ToString();
            txtMath.Text = dt.Rows[0]["Math"].ToString();
            txtEnglish.Text = dt.Rows[0]["English"].ToString();
            txtHindi.Text = dt.Rows[0]["Hindi"].ToString();
            txtTotalMarks.Text = dt.Rows[0]["TotalMarks"].ToString();
            txtPercentage.Text = dt.Rows[0]["Percentage"].ToString();
            txtGrade.Text = dt.Rows[0]["Grade"].ToString();
           
        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;

        string sql = "";
        sql = "UPDATE StudentAcademic SET IsDeleted=1 WHERE AcademicId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='SubjectMarks.aspx';", true);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("SubjectMarks.aspx");
    }
}