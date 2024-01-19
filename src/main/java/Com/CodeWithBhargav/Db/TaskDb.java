package Com.CodeWithBhargav.Db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TaskDb {
    public final static String connectionUrl = "jdbc:mysql://localhost:3306/jsptask";
    private static final String username = "root";
    private static final String password = "root";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(connectionUrl, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;

    }
}

