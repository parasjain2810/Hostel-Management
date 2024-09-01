using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Warden : System.Web.UI.Page
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
            BindDdlwarden();
            TableHostel();
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
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='Warden.aspx';", true);
    }
    protected void BindDdlwarden()
    {
        string sqltxt = "select * from Hostels where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlHostelName.DataSource = dt;
        ddlHostelName.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "";
        if (lblId.Text == "0")
        {
            sql = "INSERT INTO Warden(WardenName, Mobile, HostelId, IsDeleted) VALUES('" + txtWardenName.Text + "', '" + txtMobileNumber.Text + "', " + ddlHostelName.SelectedValue + ", 0)";        }
        else
        {
            sql = "UPDATE Warden SET HostelId = '" + ddlHostelName.SelectedValue + "', WardenName = '" + txtWardenName.Text + "', Mobile = '" + txtMobileNumber.Text + "' WHERE WardenId = '" + lblId.Text + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='Warden.aspx';", true);
    }
    


    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("Warden.aspx");
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;


        string sql = "";
        sql = "UPDATE Warden SET IsDeleted=1 WHERE WardenId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='Warden.aspx';", true);
    }
    protected void TableHostel()
    {
        string sqltxt = "SELECT dbo.Warden.WardenName, dbo.Warden.Mobile, dbo.Hostels.HostelName, dbo.Warden.WardenId ";
        sqltxt = sqltxt + "FROM dbo.Warden INNER JOIN ";
        sqltxt = sqltxt + "dbo.Hostels ON dbo.Warden.HostelId = dbo.Hostels.HostelId ";
        sqltxt = sqltxt + "WHERE dbo.Warden.IsDeleted = 0";


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
    protected void GetDetail()
    {
        string sqltxt = "select * from Warden where WardenId = '" + lblId.Text + "' ";
        DataTable dt = new DataTable();
        SqlDataAdapter adp = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adp.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {
            ddlHostelName.SelectedValue = dt.Rows[0]["HostelId"].ToString();
            txtWardenName.Text = dt.Rows[0]["WardenName"].ToString();
            txtMobileNumber.Text = dt.Rows[0]["Mobile"].ToString();
          
        }
    }
}