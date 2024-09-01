using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hostel"].ConnectionString);


    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (CheckCredentials(username, password))
        {
            Session["Username"] = username;
            //Session["Password"] = password;
            Session["IsLoggedIn"] = true; 
            Response.Redirect("Dashboard.aspx");
        }
        else
        {

            lblError.Text = "Invalid username or password.";
        }
    }

    private bool CheckCredentials(string username, string password)
    {
        bool isValid = false;

        string query = "SELECT COUNT(*) FROM Login WHERE Username COLLATE Latin1_General_CS_AS = @Username AND Password COLLATE Latin1_General_CS_AS = @Password";

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["hostel"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    isValid = true;
                }
            }
        }

        return isValid;
    }

}