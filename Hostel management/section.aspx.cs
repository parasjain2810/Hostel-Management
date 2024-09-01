using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class section : System.Web.UI.Page
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
            TableDatabase();
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
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='section.aspx';", true);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "";
        if (lblId.Text == "0")
        {
            sql = "insert into Sections(ClassId,Section,IsDeleted)values('" + ddlclass.SelectedValue + "','" + txtsection.Text + "', 0)";

        }
        else
        {
            sql = "UPDATE Sections SET ClassId = '" + ddlclass.SelectedValue + "', Section = '" + txtsection.Text + "' WHERE SectionID = '" + lblId.Text + "'";
        }



        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='Section.aspx';", true);

    }

    protected void GetDetail()
    {
        string sqltxt = "select * from Sections where SectionId = '" + lblId.Text + "' ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            ddlclass.Text = dt.Rows[0]["ClassId"].ToString();
            txtsection.Text = dt.Rows[0]["Section"].ToString();
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("Section.aspx");
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        

        string sql = "";
        sql = "UPDATE Sections SET IsDeleted=1 WHERE SectionID = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='Section.aspx';", true);
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

    protected void TableDatabase()
    {
        string sqltxt = "SELECT dbo.Sections.SectionId, dbo.Class.Class, dbo.Sections.Section, dbo.Sections.IsDeleted ";
        sqltxt = sqltxt + "FROM dbo.Class INNER JOIN ";
        sqltxt = sqltxt + "dbo.Sections ON dbo.Class.ClassId = dbo.Sections.ClassId ";
        sqltxt = sqltxt + "WHERE dbo.Sections.IsDeleted = 0";

        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(sqltxt, con);

        if (con.State == ConnectionState.Closed)
            con.Open();

        sda.Fill(dt);
        con.Close();

        GridViewCities.DataSource = dt;
        GridViewCities.DataBind();
        if (GridViewCities.Rows.Count > 0)
        {
            GridViewCities.HeaderRow.TableSection = TableRowSection.TableHeader;
            GridViewCities.FooterRow.TableSection = TableRowSection.TableFooter;
        }
    }
    
}
