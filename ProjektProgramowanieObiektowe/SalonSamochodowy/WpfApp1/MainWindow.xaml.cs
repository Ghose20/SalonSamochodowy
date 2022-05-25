using System;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using WpfApp1.SalonClass;
using System.Configuration;
using System.Data.SqlClient;






namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>

    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        salonClass c = new salonClass();
        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {

            c.imie = txtboxFirstName.Text;
            c.nazwisko = txtboxLastName.Text;
            c.Pesel = txtboxPesel.Text;
            c.email = txtboxemail.Text;
            c.telefon = txtboxContactNumber.Text;

            
            bool success = c.Insert(c);
            if (success == true)
            {

                System.Windows.MessageBox.Show("Pomyslnie dodano nowego klienta");

                 Clear();
            }
            else
            {

                System.Windows.MessageBox.Show("Nie udalo sie dodac klienta");
            }

            DataTable dt = c.Select();
            dgvklienci.ItemsSource = dt.DefaultView;
        }

        public void Clear()
        {
            txtboxID.Text = "";
            txtboxFirstName.Text = "";
            txtboxLastName.Text = "";
            txtboxPesel.Text = "";
            txtboxemail.Text = "";
            txtboxContactNumber.Text = "";
            
        }


        private void dgvklienci_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            System.Windows.Controls.DataGrid gd =(System.Windows.Controls.DataGrid)sender;
            DataRowView row_selected = gd.SelectedItem as DataRowView;
            if(row_selected != null)
            {
                txtboxID.Text = row_selected["ID"].ToString();
                txtboxFirstName.Text=row_selected["Imie"].ToString();
                txtboxLastName.Text = row_selected["Nazwisko"].ToString();
                txtboxPesel.Text = row_selected["Pesel"].ToString();
                txtboxemail.Text = row_selected["Email"].ToString();
                txtboxContactNumber.Text = row_selected["Telefon"].ToString();
            }
        }
        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
            
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {

            c.ID = Convert.ToInt32(txtboxID.Text);
            bool success = c.Delete(c);

            if (success == true)
            {
                System.Windows.MessageBox.Show("Pomyślnie usunieto klienta");
                DataTable dt = c.Select();
                dgvklienci.ItemsSource = dt.DefaultView;
                Clear();
            }


            else
            {
                System.Windows.MessageBox.Show("Nie udało sie usunąć klienta");
            }
        }
        static string myconnstr = ConfigurationManager.ConnectionStrings["connstrng"].ConnectionString;

        private void txtboxSearch_TextChanged_1(object sender, TextChangedEventArgs e)
        {
            string keyword = txtboxSearch.Text;

            SqlConnection conn = new SqlConnection(myconnstr);
            SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Klienci WHERE imie LIKE '%" + keyword + "%' OR Nazwisko LIKE '%" + keyword + "%' OR Pesel LIKE '%" + keyword + "%'", conn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dgvklienci.ItemsSource = dt.DefaultView;
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            c.ID = int.Parse(txtboxID.Text);
            c.imie = txtboxFirstName.Text;
            c.nazwisko = txtboxLastName.Text;
            c.Pesel = txtboxPesel.Text;
            c.email = txtboxemail.Text;
            c.telefon = txtboxContactNumber.Text;
            

            bool success = c.Update(c);
            if (success == true)
            {
                System.Windows.MessageBox.Show("Dane klienta zostaly zaakutalizowane pomyślnie");
                DataTable dt = c.Select();
                dgvklienci.ItemsSource = dt.DefaultView;
                Clear();
            }
            else
            {
                System.Windows.MessageBox.Show("Nie udało sie zaaktualizować danych klienta");
            }

        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            DataTable dt = c.Select();
            dgvklienci.ItemsSource = dt.DefaultView;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            okno1 win2 = new okno1();
            win2.Show();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}




