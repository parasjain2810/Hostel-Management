using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.EnterpriseServices;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class assets_forms : System.Web.UI.Page
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
            BindDdlcities();
            TableStudent();
            if (Convert.ToString(Session["EditId"]) != "")
            {
                lblId.Text = Session["EditId"].ToString();
                GetDetail();
                BindDdlSection();
                Session["EditId"] = "";
            }
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
    protected void BindDdlcities()
    {
        string sqltxt = "select * from Cities where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlcity.DataSource = dt;
        ddlcity.DataBind();
    }
    protected void classselect(object sender, EventArgs e)
    {
        string selectedclass = ddlclass.SelectedValue;
        ddlsection.Items.Clear();
        ddlsection.Items.Add(new ListItem { Value = "", Text = "--Select Student--" });
        string sql = "SELECT dbo.Class.Class,dbo.Sections.SectionId, dbo.Sections.Section, dbo.Class.IsDeleted ";
        sql = sql + "FROM dbo.Class ";
        sql = sql + "INNER JOIN dbo.Sections ON dbo.Class.ClassId = dbo.Sections.ClassId ";
        sql=sql +  "WHERE dbo.Sections.IsDeleted = 0 AND dbo.Class.ClassId = '" + selectedclass + "'";

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

    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.Student.StudentId, dbo.Student.StudentName, dbo.Student.MobileNo, dbo.Student.DOB, dbo.Student.RollNo, dbo.Student.Address, ";
        sqltxt = sqltxt + "dbo.Student.FatherName, dbo.Student.MotherName, dbo.Sections.Section, dbo.Class.Class, dbo.Cities.Cities, ";
        sqltxt = sqltxt + "dbo.Student.StudentImg, dbo.Gender.Gender ";
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
        string sql = "";
        string FilePhotoWithExtensionSP = "";
        string pathPhoto;
        if (FileUpload1.FileContent.Length > 500000)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('Product File Size not be exceeded then 500KB');", true);
            return;
        }

        if (FileUpload1.HasFile)
        {
            pathPhoto = "/Uploads/";
            string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
            FilePhotoWithExtensionSP = Convert.ToDateTime(DateTime.Now).ToString("yyyyMMddHHmmss") + fileExtension;
            pathPhoto = pathPhoto + FilePhotoWithExtensionSP;
            FileUpload1.SaveAs(Server.MapPath(pathPhoto));
        }
        else
        {
            
            FilePhotoWithExtensionSP = lblphoto.Text;
        }



        if (lblId.Text == "0")
        {
            sql = "insert into Student(StudentName,MobileNo,DOB,ClassId,SectionId,CityId,RollNo,Address,FatherName,MotherName,GenderId,StudentImg,CreatedDate,IsDeleted)";
            sql = sql + " values('" + txtStname.Text + "','" + txtmobileno.Text + "','" + Convert.ToDateTime(txtDOB.Text).ToString("dd-MMM-yyyy") + "','" + ddlclass.SelectedValue + "', ";
            sql = sql + " '" + ddlsection.SelectedValue + "','" + ddlcity.SelectedValue + "','" + txtrollno.Text + "', '" + txtaddress.Text + "', '" + txtfname.Text + "',  '" + txtmname.Text + "', '" + RDOGender.SelectedValue + "',  '" + FilePhotoWithExtensionSP + "', getdate(),0)";

        }
        else
        {
            sql = "UPDATE Student SET " +"StudentName = '" + txtStname.Text + "', " +"MobileNo = '" + txtmobileno.Text + "', " + "DOB = '" + Convert.ToDateTime(txtDOB.Text).ToString("dd-MMM-yyyy") + "', " +"ClassId = '" + ddlclass.SelectedValue + "', " +"SectionId = '" + ddlsection.SelectedValue + "', " + "CityId = '" + ddlcity.SelectedValue + "', " +  "RollNo = '" + txtrollno.Text + "', " +"Address = '" + txtaddress.Text + "', " + "FatherName = '" + txtfname.Text + "', " +
      "MotherName = '" + txtmname.Text + "', " +"GenderId = '" + RDOGender.SelectedValue + "', " +"StudentImg = '" + FilePhotoWithExtensionSP + "', " +"UpdatedDate = GETDATE() " +"WHERE StudentId = '" + lblId.Text + "'";
        }



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='studentforms.aspx';", true);

    }
    protected void GetDetail()
    {
        string sqltxt = "select * from Student WHERE StudentId = '" + lblId.Text + "' ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            txtStname.Text = dt.Rows[0]["StudentName"].ToString();
            txtmobileno.Text = dt.Rows[0]["MobileNo"].ToString();
            txtDOB.Text = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd-MM-yyyy");
            ddlclass.SelectedValue = dt.Rows[0]["ClassId"].ToString();
            ddlsection.SelectedValue = dt.Rows[0]["SectionId"].ToString();
            ddlcity.SelectedValue = dt.Rows[0]["CityId"].ToString();
            txtrollno.Text = dt.Rows[0]["RollNo"].ToString();
            txtaddress.Text = dt.Rows[0]["Address"].ToString();
            txtfname.Text = dt.Rows[0]["FatherName"].ToString();
            txtmname.Text = dt.Rows[0]["MotherName"].ToString();
            RDOGender.SelectedValue = dt.Rows[0]["GenderId"].ToString();
            lblphoto.Text = dt.Rows[0]["StudentImg"].ToString();
            rfvfile.Enabled = false;            
        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;

        string sql = "";
        sql = "UPDATE Student SET IsDeleted=1 WHERE StudentId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='studentforms.aspx';", true);
    }

    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='studentforms.aspx';", true);

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("studentforms.aspx");
    }
}