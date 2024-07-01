using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel.DataAnnotations;
using System.Collections;
using Microsoft.Ajax.Utilities;
using System.Globalization;

namespace CASAweb
{
    public partial class CreateProduct : System.Web.UI.Page
    {
        //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Products.mdf;Integrated Security=True");

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

        private bool IsProductNameUnique(string productName)
        {
            using (var con = CreateConnection())
            {
                using (var cmd = new SqlCommand("SELECT COUNT(*) FROM ProductTable WHERE Name = @Name", con))
                {
                    cmd.Parameters.AddWithValue("@Name", productName);
                    int count = (int)cmd.ExecuteScalar();
                    return count == 0;
                }
            }
        }

        private string GenerateUniqueCode()
        {
            Random random = new Random();
            string code;
            bool isUnique;

            do
            {
                code = random.Next(100, 1000).ToString();
                using (var con = CreateConnection())
                {
                    using (var cmd = new SqlCommand("SELECT COUNT(*) FROM ProductTable WHERE Code = @Code", con))
                    {
                        cmd.Parameters.AddWithValue("@Code", code);
                        int count = (int)cmd.ExecuteScalar();
                        isUnique = count == 0;
                    }
                }
            } while (!isUnique);

            return code;
        }

        private void CreateGLs(int productId)
        {
            bool isInterestPayable = InterestPayable.Checked;
            bool isInterestExpense = InterestExpense.Checked;
            bool isGeneralFeeIncome = GeneralFeeIncome.Checked;
            bool isMaintenanceFee = MaintenanceFee.Checked;

            string[] glNames = { "Interest Payable", "Interest Expense", "General Fee Income", "Maintenance Fee" };
            string[] glClasses = { "Liability", "Expense", "Income", "Income" };
            string[] glCodes = { "GL1", "GL2", "GL3", "GL4" };

            using (var con = CreateConnection())
            {
                for (int i = 0; i < glNames.Length; i++)
                {
                    using (var cmd = new SqlCommand("INSERT INTO GLTable (GLName, GLCode, GLClass, ProductId) VALUES (@GLName, @GLCode, @GLClass, @ProductId)", con))
                    {
                        cmd.Parameters.AddWithValue("@GLName", glNames[i]);
                        cmd.Parameters.AddWithValue("@GLCode", glCodes[i]);
                        cmd.Parameters.AddWithValue("@GLClass", glClasses[i]);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        protected void Create_Click(object sender, EventArgs e)
        {
            try
            {
                string name = Name.Text.Trim();
                string category = Category.SelectedValue;
                string otherCategory = OtherCategory.Text.Trim().ToUpper();
                bool shouldApplyFees = ShouldApplyFees.Checked;
                decimal fees = string.IsNullOrEmpty(Fees.Text) ? 0 : Convert.ToDecimal(Fees.Text);
                bool shouldPayInterest = ShouldPayInterest.Checked;
                decimal interest = string.IsNullOrEmpty(Interest.Text) ? 0 : Convert.ToDecimal(Interest.Text);
                bool shouldApplySMS = ShouldApplySMS.Checked;
                bool shouldAccessChannelServices = ShouldAccessChannelServices.Checked;

                TextInfo prodName = new CultureInfo("en-US", false).TextInfo;
                name = prodName.ToTitleCase(name);

                if (category == "Others" && string.IsNullOrEmpty(otherCategory))
                {
                    HiddenMessage.Value = "Please specify a custom category name";
                    return;
                }

                if (!IsProductNameUnique(name))
                {
                    HiddenMessage.Value = "Product name already exists.";
                    return;
                }

                string code = GenerateUniqueCode();

                //category to save in db
                string catToSave = category == "Others" ? otherCategory : category;

                string query = @"INSERT INTO ProductTable 
        (Name, Code, ShouldApplyFees, Fees, ShouldApplySMS, ShouldAccessChannelServices, Category, ShouldPayInterest, Interest) 
        OUTPUT INSERTED.Id VALUES (@Name, @Code, @ShouldApplyFees, @Fees, @ShouldApplySMS, @ShouldAccessChannelServices, @Category, @ShouldPayInterest, @Interest)";


                using (var con = CreateConnection())
                {
                    using (var cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Code", code);
                        cmd.Parameters.AddWithValue("@ShouldApplyFees", shouldApplyFees);
                        cmd.Parameters.AddWithValue("@Fees", fees);
                        cmd.Parameters.AddWithValue("@ShouldApplySMS", shouldApplySMS);
                        cmd.Parameters.AddWithValue("@ShouldAccessChannelServices", shouldAccessChannelServices);
                        cmd.Parameters.AddWithValue("@Category", catToSave);
                        cmd.Parameters.AddWithValue("@ShouldPayInterest", shouldPayInterest);
                        cmd.Parameters.AddWithValue("@Interest", interest);

                        int productId = (int)cmd.ExecuteScalar();
                        CreateGLs(productId);
                    }
                }

                DispData();
                HiddenMessage.Value = "Product created successfully!";
                ClearForm();
            }
            catch (Exception ex)
            {
                HiddenMessage.Value = "An error occurred: " + ex.Message;
            }
        }

        public void DispData()
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
                    }
                }
            }
        }

        private void ClearForm()
        {
            Name.Text = string.Empty;
            Category.SelectedIndex = 0;
            OtherCategory.Text = string.Empty;
            ShouldApplyFees.Checked = false;
            Fees.Text = string.Empty;
            ShouldPayInterest.Checked = false;
            Interest.Text = string.Empty;
            ShouldApplySMS.Checked = false;
            ShouldAccessChannelServices.Checked = false;
        }
    }
}