using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Lifetime;

namespace demoApp
{
    public partial class main : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvbind();
            }
        }

        protected void gvbind()
        {
      
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from users; select sum(donation) from users", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();

            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        void clear()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            dropLoc.SelectedIndex = 0;
            RadioButton1.Checked = false;
            RadioButton2.Checked = false;
            cal.Text = string.Empty;
            donate.Text = string.Empty;
            CheckBox1.Checked = false;
        }

        protected void reset_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void add_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text) || string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtPhone.Text) || dropLoc.SelectedValue == "0"
                || (!RadioButton1.Checked && !RadioButton2.Checked) || string.IsNullOrEmpty(cal.Text) || !float.TryParse(donate.Text, out float donationAmount))
            {
                // Response.Write("<script>alert('Please fill in all required fields and provide valid data.');</script>");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Oops...', 'Please fill in all required fields and provide valid data.', 'error').then((value) => { window.location ='main.aspx'; });", true);
                return;
                
            }
            if (CheckBox1.Checked)
            {
                con.Open();
                string query = "INSERT INTO users (name, email, phone, location, gendar, dateCal, donation) VALUES (@Name, @Email, @Phone, @Location, @Gender, @DateOfDonation, @DonationAmount)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Location", dropLoc.SelectedValue);
                cmd.Parameters.AddWithValue("@Gender", RadioButton1.Checked ? "Male" : "Female");
                cmd.Parameters.AddWithValue("@DateOfDonation", cal.Text);
                cmd.Parameters.AddWithValue("@DonationAmount", donationAmount.ToString("0.00"));
                int t = cmd.ExecuteNonQuery();
                con.Close();
                clear();
                if (t > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Good job!','Thank you for your donation.','success').then((value) => { window.location ='main.aspx'; });", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Oops...', 'Check me out!', 'warning').then((value) => { window.location ='main.aspx'; });", true);
            }
            gvbind();

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            gvbind();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            gvbind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                GridView gridView = (GridView)sender;
                DataTable dt = gridView.DataSource as DataTable;

                if (dt != null)
                {
                    decimal totalAmt = 0.00m;

                    foreach (DataRow row in dt.Rows)
                    {
                        decimal donationValue;
                        if (decimal.TryParse(row["donation"].ToString(), out donationValue))
                        {
                            totalAmt += donationValue;
                        }
                    }

                    Label lblTotalDonation = new Label();
                    lblTotalDonation.Text = totalAmt.ToString("0.00");
                    e.Row.Cells[7].Controls.Add(lblTotalDonation);
                }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = GridView1.Rows[e.RowIndex].FindControl("id") as Label;
            int iddemo = Convert.ToInt32(id.Text);

            con.Open();
            SqlCommand cmd = new SqlCommand("delete from users where id= '" + iddemo + "' ", con);
            int t = cmd.ExecuteNonQuery();
            con.Close();
            if (t > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Deleted','', 'error').then((value) => { window.location ='main.aspx'; });", true);
                GridView1.EditIndex = -1;
                gvbind();
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Label id = GridView1.Rows[e.RowIndex].FindControl("id") as Label;
            TextBox name = GridView1.Rows[e.RowIndex].FindControl("txtName") as TextBox;
            TextBox email = GridView1.Rows[e.RowIndex].FindControl("txtEmail") as TextBox;
            TextBox phone = GridView1.Rows[e.RowIndex].FindControl("txtPhone") as TextBox;
            DropDownList location = GridView1.Rows[e.RowIndex].FindControl("txtLoc") as DropDownList;
            DropDownList gender = GridView1.Rows[e.RowIndex].FindControl("txtGen") as DropDownList;
            TextBox cal = GridView1.Rows[e.RowIndex].FindControl("txtCal") as TextBox;
            TextBox donation = GridView1.Rows[e.RowIndex].FindControl("txtD") as TextBox;

            int iddemo = Convert.ToInt32(id.Text);
            string named = name.Text;
            string emaild = email.Text;
            string phoned = phone.Text;
            string locd = location.SelectedValue;
            string genderd = gender.SelectedValue;
            string cald = cal.Text;
            float donationd = float.Parse(donation.Text);

            con.Open();
            SqlCommand cmd = new SqlCommand("update users set name=@Name, email=@Email, phone=@Phone, location=@Location, gendar=@Gender, dateCal=@DateOfDonation, donation=@DonationAmount where id=@Id", con);
            cmd.Parameters.AddWithValue("@Name", named);
            cmd.Parameters.AddWithValue("@Email", emaild);
            cmd.Parameters.AddWithValue("@Phone", phoned);
            cmd.Parameters.AddWithValue("@Location", locd);
            cmd.Parameters.AddWithValue("@Gender", genderd);
            cmd.Parameters.AddWithValue("@DateOfDonation", cald);
            cmd.Parameters.AddWithValue("@DonationAmount", donationd.ToString("0.00"));
            cmd.Parameters.AddWithValue("@Id", iddemo);

            int t = cmd.ExecuteNonQuery();
            con.Close();

            if (t > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Done !!!','Details saved successfully','success').then((value) => { window.location ='main.aspx'; });", true);
                GridView1.EditIndex = -1;
                gvbind();
            }
        }
    }
}