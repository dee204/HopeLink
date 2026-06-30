/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author farajuhaimi
 */
public class DBConnection {
   private static final String LOCAL_URL = "jdbc:mysql://localhost:3307/fyp";
private static final String LOCAL_USER = "root";
private static final String LOCAL_PASS = "";

public static Connection getConnection() {
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String databaseUrl = System.getenv("DATABASE_URL");

        if (databaseUrl != null && !databaseUrl.isEmpty()) {
            con = DriverManager.getConnection(convertToJdbcUrl(databaseUrl));
        } else {
            con = DriverManager.getConnection(LOCAL_URL, LOCAL_USER, LOCAL_PASS);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return con;
}

private static String convertToJdbcUrl(String databaseUrl) throws Exception {
    if (databaseUrl.startsWith("jdbc:mysql://")) {
        return databaseUrl;
    }

    java.net.URI uri = new java.net.URI(databaseUrl);

    String userInfo = uri.getUserInfo();
    String user = "";
    String password = "";

    if (userInfo != null && userInfo.contains(":")) {
        String[] parts = userInfo.split(":", 2);
        user = parts[0];
        password = parts[1];
    }

    String host = uri.getHost();
    int port = uri.getPort();
    String database = uri.getPath();

    return "jdbc:mysql://" + host + ":" + port + database
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
            + "&user=" + user
            + "&password=" + password;
}
}