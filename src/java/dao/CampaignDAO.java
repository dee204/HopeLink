/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Campaign;
import util.DBConnection;
import java.sql.*;
import java.util.*;
/**
 *
 * @author farajuhaimi
 */
public class CampaignDAO {

    // ================= CREATE =================
    public static boolean insertCampaign(Campaign c) {
        String sql = "INSERT INTO campaign(title, description, org_name, amount_goal, amount_raised, image, status) "
                   + "VALUES(?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getOrgName());
            ps.setDouble(4, c.getAmountGoal());
            ps.setDouble(5, c.getAmountRaised());
            ps.setString(6, c.getImage());
            ps.setString(7, "PENDING");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= READ ALL =================
    public static List<Campaign> getAllCampaigns() {
        List<Campaign> list = new ArrayList<>();

        String sql = "SELECT * FROM campaign ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapCampaign(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= READ APPROVED ONLY =================
    public static List<Campaign> getApprovedCampaigns() {
        List<Campaign> list = new ArrayList<>();

        String sql = "SELECT * FROM campaign WHERE status = 'APPROVED' ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapCampaign(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= READ PENDING ONLY =================
    public static List<Campaign> getPendingCampaigns() {
        List<Campaign> list = new ArrayList<>();

        String sql = "SELECT * FROM campaign WHERE status = 'PENDING' ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapCampaign(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= READ BY ID =================
    public static Campaign getCampaignById(int id) {
        String sql = "SELECT * FROM campaign WHERE campaign_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCampaign(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= UPDATE CAMPAIGN =================
    public static boolean updateCampaign(Campaign c) {
        String sql = "UPDATE campaign SET title=?, description=?, org_name=?, amount_goal=?, amount_raised=?, image=? "
                   + "WHERE campaign_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getTitle());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getOrgName());
            ps.setDouble(4, c.getAmountGoal());
            ps.setDouble(5, c.getAmountRaised());
            ps.setString(6, c.getImage());
            ps.setInt(7, c.getCampaignId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= APPROVE / REJECT =================
    public static boolean updateCampaignStatus(int campaignId, String status) {
        String sql = "UPDATE campaign SET status = ? WHERE campaign_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, campaignId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= DELETE =================
    public static boolean deleteCampaign(int id) {
        String sql = "DELETE FROM campaign WHERE campaign_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= TOTAL FUND ALL CAMPAIGNS =================
    public static double getTotalAmountRaised() {
        String sql = "SELECT COALESCE(SUM(amount_raised), 0) AS total_raised FROM campaign";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total_raised");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================= EACH CAMPAIGN FUND SUMMARY =================
    public static List<Campaign> getCampaignFundSummary() {
        List<Campaign> list = new ArrayList<>();

        String sql = "SELECT * FROM campaign ORDER BY amount_raised DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapCampaign(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= REUSABLE MAPPER =================
    private static Campaign mapCampaign(ResultSet rs) throws SQLException {
        Campaign c = new Campaign();

        c.setCampaignId(rs.getInt("campaign_id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setOrgName(rs.getString("org_name"));
        c.setAmountGoal(rs.getDouble("amount_goal"));
        c.setAmountRaised(rs.getDouble("amount_raised"));
        c.setStatus(rs.getString("status"));
        c.setImage(rs.getString("image"));
        c.setCreatedAt(rs.getString("created_at"));

        return c;
    }
}