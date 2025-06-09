using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace WEB_API.Shared
{
    public class DbConn
    {
        public SqlConnection conn;
        public DbConn()
        {
            conn = new SqlConnection("Data Source=DESKTOP-1623\\MSSQLSERVER1;Initial Catalog=VV_WEB_API;Integrated Security=true;");
            conn.StateChange += Conn_StateChange;
        }

        private void Conn_StateChange(object sender, System.Data.StateChangeEventArgs e)
        {
            if (e.CurrentState == System.Data.ConnectionState.Closed)
            {
                ((SqlConnection)sender).Open();
            }
        }
    }
}