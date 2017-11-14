package util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created by 小型 on 2017/5/10.
 */
public class Mycon {

    public Connection getConnecton() {
        Connection connection = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("尝试连接");
            String url="jdbc:oracle:"+"thin:@127.0.0.1:1521:orcl";
            String user="c##scott";
            String password="tiger";
            connection= DriverManager.getConnection(url,user,password);
            System.out.println("连接成功");
        } catch (Exception e){
            e.printStackTrace();
        }
        return connection;
    }

}
