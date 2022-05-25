using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WpfApp1.SalonClass
{
    internal class salonClass
    {
        public int ID { get; set; }
        public string imie { get; set; }
        public string nazwisko { get; set; }
        public string Pesel { get; set; }
        public string email { get; set; }
        public string telefon { get; set; }




        static string myconnstrng = ConfigurationManager.ConnectionStrings["connstrng"].ConnectionString;

        public DataTable Select()
        {

            SqlConnection conn = new SqlConnection(myconnstrng);
            DataTable dt = new DataTable();
            try
            {

                string sql = "SELECT * FROM Klienci";

                SqlCommand cmd = new SqlCommand(sql, conn);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                conn.Open();
                adapter.Fill(dt);
            }
            catch (Exception ex)
            {

            }
            finally
            {
                conn.Close();
            }
            return dt;

        }
        public bool Insert(salonClass c)
        {

            bool isSuccess = false;


            SqlConnection conn = new SqlConnection(myconnstrng);
            try
            {
                string sql = "INSERT INTO klienci (Imie, Nazwisko, Pesel, Email, Telefon) VALUES (@imie, @nazwisko, @pesel, @email, @telefon)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Imie", c.imie);
                cmd.Parameters.AddWithValue("@Nazwisko", c.nazwisko);
                cmd.Parameters.AddWithValue("@Pesel", c.Pesel);
                cmd.Parameters.AddWithValue("@Email", c.email);
                cmd.Parameters.AddWithValue("@Telefon", c.telefon);


                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                conn.Close();
            }
            return isSuccess;
        }
        public bool Update(salonClass c)
        {
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstrng);
            try
            {
                string sql = "UPDATE klienci SET Imie=@imie, Nazwisko=@nazwisko, Pesel=@pesel, Email=@email, Telefon=@telefon WHERE ID=@ID";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Imie", c.imie);
                cmd.Parameters.AddWithValue("@Nazwisko", c.nazwisko);
                cmd.Parameters.AddWithValue("@Pesel", c.Pesel);
                cmd.Parameters.AddWithValue("@Email", c.email);
                cmd.Parameters.AddWithValue("@Telefon", c.telefon);
                cmd.Parameters.AddWithValue("@ID", c.ID);

                conn.Open();

                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                conn.Close();
            }
            return isSuccess;
        }
        public bool Delete(salonClass c)
        {
            bool isSuccess = false;
            SqlConnection conn = new SqlConnection(myconnstrng);
            try
            {

                string sql = "DELETE FROM klienci WHERE ID=@ID";


                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ID", c.ID);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    isSuccess = true;
                }
                else
                {
                    isSuccess = false;
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {

                conn.Close();
            }
            return isSuccess;
        }
    }
}
