/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import util.DBConnection;
import java.sql.*;
import java.util.*;
/**
 *
 * @author farajuhaimi
 */
public class NotificationDAO {

 public static boolean addNotification(String message, String type, String targetRole) {
    String sql = "INSERT INTO notification(message, type, status, target_role) VALUES (?, ?, 'UNREAD', ?)";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, message);
        ps.setString(2, type);
        ps.setString(3, targetRole);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}

    public static List<Map<String, String>> getAllNotifications() {
        List<Map<String, String>> list = new ArrayList<>();

        String sql = "SELECT * FROM notification ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapNotification(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Map<String, String>> getNotificationsByStatus(String status) {
        List<Map<String, String>> list = new ArrayList<>();

        String sql = "SELECT * FROM notification WHERE status = ? ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapNotification(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean markAsRead(int notificationId) {
        String sql = "UPDATE notification SET status = 'READ' WHERE notification_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, notificationId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private static Map<String, String> mapNotification(ResultSet rs) throws SQLException {
        Map<String, String> n = new HashMap<>();

        n.put("id", String.valueOf(rs.getInt("notification_id")));
        n.put("message", rs.getString("message"));
        n.put("type", rs.getString("type"));
        n.put("status", rs.getString("status"));
        n.put("createdAt", rs.getString("created_at"));
        n.put("targetRole", rs.getString("target_role"));

        return n;
    }
    public static List<Map<String, String>> getNotificationsByRole(String targetRole) {
    List<Map<String, String>> list = new ArrayList<>();

    String sql = "SELECT * FROM notification WHERE target_role = ? ORDER BY created_at DESC";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, targetRole);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(mapNotification(rs));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

public static List<Map<String, String>> getNotificationsByRoleAndStatus(String targetRole, String status) {
    List<Map<String, String>> list = new ArrayList<>();

    String sql = "SELECT * FROM notification WHERE target_role = ? AND status = ? ORDER BY created_at DESC";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, targetRole);
        ps.setString(2, status);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(mapNotification(rs));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
   
}