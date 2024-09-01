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
using System.Activities.Expressions;
using System.Activities.Statements;

public partial class StudentHostelFees : System.Web.UI.Page
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
            BindDdlRoomno();
            BindDdlClass();
            TableStudent();
        }
        if (Convert.ToString(Session["EditId"]) != "")
        {
            lblId.Text = Session["EditId"].ToString();
            GetDetail();
            BindDdlStudent();
            Session["EditId"] = "";
        }
    }
    private bool IsUserLoggedIn()
    {
        return Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"];
    }
    protected void cancel(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "window.location='StudentHostelFees.aspx';", true);
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
        ddlClass.DataSource = dt;
        ddlClass.DataBind();
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

    protected void BindDdlRoomno()
    {
        string sqltxt = "select * from HostelRoom where IsDeleted = 0 ";
        DataTable dt = new DataTable();
        SqlDataAdapter adpw = new SqlDataAdapter(sqltxt, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        adpw.Fill(dt);
        con.Close();
        ddlRoomNumber.DataSource = dt;
        ddlRoomNumber.DataBind();
    }
    protected void TableStudent()
    {
        string sqltxt = "SELECT dbo.Fee.FeeId, dbo.Class.Class, dbo.Student.StudentName, dbo.HostelRoom.RoomNo, dbo.Fee.TotalAmount, dbo.Fee.Advance, dbo.Fee.Pending, dbo.Fee.IsDeleted ";
        sqltxt = sqltxt + "FROM dbo.Class INNER JOIN ";
        sqltxt = sqltxt + "dbo.Fee ON dbo.Class.ClassId = dbo.Fee.ClassId INNER JOIN ";
        sqltxt = sqltxt + "dbo.Student ON dbo.Fee.StudentId = dbo.Student.StudentId INNER JOIN ";
        sqltxt = sqltxt + "dbo.HostelRoom ON dbo.Fee.RoomNoId = dbo.HostelRoom.RoomId ";
        sqltxt = sqltxt + "WHERE dbo.Fee.IsDeleted = 0";
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

    protected void BindBalanceFees_SelectedIndexChanged(string selectedClass, string roomNumber, string studentName)
    {
        
        if (!string.IsNullOrEmpty(selectedClass) && !string.IsNullOrEmpty(roomNumber) && !string.IsNullOrEmpty(studentName))
        {
            string sqltxt = "SELECT Pending FROM Fee " + "WHERE ClassId = '" + selectedClass + "' " + "AND RoomNoId = '" + roomNumber + "' "+"AND StudentId = '" + studentName + "' " + "AND IsDeleted = 0";
            SqlCommand cmdCheck = new SqlCommand(sqltxt, con);
            if (con.State == ConnectionState.Closed)
                con.Open();
            object pendingFeesObj = cmdCheck.ExecuteScalar();
            if (pendingFeesObj != null)
            {
                decimal pendingFees = Convert.ToDecimal(pendingFeesObj);
                txtBalanceFees.Text = pendingFees.ToString("0.00");
            }
            else
            {

                string sqlRent = "SELECT rent FROM HostelRoom WHERE RoomId = " + roomNumber + " AND IsDeleted = 0";
                SqlCommand cmdRent = new SqlCommand(sqlRent, con);
                object rentObj = cmdRent.ExecuteScalar();
                if (rentObj != null)
                {
                    decimal rent = Convert.ToDecimal(rentObj);
                    txtBalanceFees.Text = rent.ToString("0.00");
                }
            }
        }
        con.Close();
    }

    protected void selectroomnumber(object sender, EventArgs e)
    {
        string classId = ddlClass.SelectedValue;
        string studentId = ddlStudentName.SelectedValue;
        
        ddlRoomNumber.Items.Clear();

        string sql = "SELECT dbo.HostelRoom.RoomNo,dbo.HostelRoom.RoomId, dbo.HostelRoom.IsDeleted, dbo.StudentHostelRegister.StudentId ";
        sql = sql + "FROM dbo.StudentHostelRegister ";
        sql = sql + "INNER JOIN dbo.HostelRoom ON dbo.StudentHostelRegister.RoomId = dbo.HostelRoom.RoomId ";
        sql = sql + "WHERE dbo.HostelRoom.IsDeleted = 0 AND StudentId = '" + studentId + "'";

        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }
        SqlDataReader reader = cmd.ExecuteReader();

        
        while (reader.Read())
        {
            string roomNo = reader["RoomNo"].ToString();
            string roomId = reader["RoomId"].ToString();
            ddlRoomNumber.Items.Add(new ListItem(roomNo, roomId));
        }
        reader.Close();
        
        string roomnoid = ddlRoomNumber.SelectedValue;

        BindBalanceFees_SelectedIndexChanged(classId, roomnoid, studentId);
        }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal receivedFees = decimal.Parse(txtReceivedFees.Text.Trim());
        decimal totalFees = decimal.Parse(txtBalanceFees.Text.Trim());
        decimal pendingFees = totalFees - receivedFees;
        txtPendingFees.Text = pendingFees.ToString("0.00");
        string sql = "";
        

        if (lblId.Text == "0")
        {
            sql = "INSERT INTO Fee ( ClassId, StudentId, RoomNoId, TotalAmount, Advance, Pending,IsDeleted)";
            sql = sql + " VALUES ('" + ddlClass.SelectedValue + "', '" + ddlStudentName.SelectedValue + "', '" + ddlRoomNumber.SelectedValue + "', '" + txtBalanceFees.Text + "', ";
            sql = sql + "'" + txtReceivedFees.Text + "', '" + txtPendingFees.Text + "', 0)";
        }
        else
        {
            sql = "UPDATE Fee SET ClassId = '" + ddlClass.SelectedValue + "', StudentId = '" + ddlStudentName.SelectedValue + "', " + " RoomNoId = '" + ddlRoomNumber.SelectedValue + "', " +
                          "TotalAmount = '" + txtBalanceFees.Text + "', " + "Advance = '" + txtReceivedFees.Text + "', " + "Pending = '" + txtPendingFees.Text + "'" +
                          "WHERE FeeId = '" + lblId.Text + "'";
        }
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record submitted successfully');window.location='StudentHostelFees.aspx';", true);
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
    protected void GetDetail()
    {
        string sqltxt = "select * from Fee WHERE FeeId = '" + lblId.Text + "'";
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
            ddlRoomNumber.Text = dt.Rows[0]["RoomNoId"].ToString();
            txtBalanceFees.Text = dt.Rows[0]["TotalAmount"].ToString();
            txtReceivedFees.Text = dt.Rows[0]["Advance"].ToString();
            txtPendingFees.Text = dt.Rows[0]["Pending"].ToString();
        }
    }
    protected void btndeleted_click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        string sql = "";
        sql = "UPDATE Fee SET IsDeleted=1 WHERE FeeId = '" + btn.CommandArgument + "'";
        SqlCommand cmd = new SqlCommand(sql, con);
        if (con.State == ConnectionState.Closed)
            con.Open();
        cmd.ExecuteNonQuery();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "alert('record Deleted successfully');window.location='StudentHostelFees.aspx';", true);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Session["EditId"] = btn.CommandArgument;
        Response.Redirect("StudentHostelFees.aspx");
    }
}