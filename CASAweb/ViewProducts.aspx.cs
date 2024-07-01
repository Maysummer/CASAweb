using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CASAweb
{
    public partial class ViewProducts : System.Web.UI.Page
    {
        private SqlConnection CreateConnection()
        {
            var con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Products.mdf;Integrated Security=True");
            con.Open();
            return con;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DispData();
            }
        }

        private void DispData()
        {
            using (var con = CreateConnection())
            {
                using (var cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT * FROM ProductTable";
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridView.DataSource = dt;
                        GridView.DataBind();
                    }
                }
            }
        }
    }
}
