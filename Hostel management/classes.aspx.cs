using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.EnterpriseServices;

public partial class classes : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hostel"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsUserLoggedIn())
        {
            Response.Redirect("Default.aspx");
            return;
        }
        Tableclass();

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
    protected void Tableclass()
    {
        string sqltxt = "select * from Class where IsDeleted = 0 ";
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "";
        if (lblId.Text == "0")
        {
            sql = " insert into Class(Class,IsDeleted)values('" + txtnewclass.Text + "', 0)";

        }
        else
        {
            sql = " Update Class Set Class = '" + txtnewclass.Text + "' where classid = '" + lblId.Text + "' ";
        }
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='classes.aspx';", true);

    }
    protected void GetDetail()
    {
        string sqltxt = "select * from Class where classid = '" + lblId.Text + "' ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {

            txtnewclass.Text = dt.Rows[0]["Class"].ToString();
        }
    }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("classes.aspx");
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        
        
        string sql = "";
        sql = " Update Class Set IsDeleted = 1  where classid = '" + btn.CommandArgument + "' ";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='classes.aspx';", true);
    }   
}