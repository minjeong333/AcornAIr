package acornAir.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/*
 //다른 dao에서 쓸 때  붙여서 쓸 코드
 
 DBUtil db = new DBUtil();
 Connection con = db.dbcon();
 
 */

public class DBUtil {
    private String driver = "oracle.jdbc.driver.OracleDriver";
    private String url = "jdbc:oracle:thin:@localhost:1521:testdb";
    private String user = "scott";
    private String password = "tiger";

    public Connection dbcon() {
        Connection con = null;
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
            if (con != null) System.out.println("db ok");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return con;
    }
}
