/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Donation;
import util.DBConnection;
import java.sql.*;
import java.util.*;
/**
 *
 * @author farajuhaimi
 */
public class DonationDAO {

    public static boolean addDonation(Donation d) {
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String insertSql = "INSERT INTO donation (campaign_id, donor_name, amount) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertSql);

            ps.setInt(1, d.getCampaignId());
            ps.setString(2, d.getDonorName());
            ps.setDouble(3, d.getAmount());
            ps.executeUpdate();

            String updateSql = "UPDATE campaign SET amount_raised = amount_raised + ? WHERE campaign_id = ?";
            PreparedStatement ps2 = con.prepareStatement(updateSql);

            ps2.setDouble(1, d.getAmount());
            ps2.setInt(2, d.getCampaignId());
            ps2.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            e.printStackTrace();
            return false;

        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static List<Donation> getAllDonations() {
        List<Donation> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT d.donation_id, d.campaign_id, d.donor_name, d.amount, " +
                         "d.donation_date, c.title AS campaign_title " +
                         "FROM donation d " +
                         "JOIN campaign c ON d.campaign_id = c.campaign_id " +
                         "ORDER BY d.donation_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Donation d = new Donation();

                d.setDonationId(rs.getInt("donation_id"));
                d.setCampaignId(rs.getInt("campaign_id"));
                d.setDonorName(rs.getString("donor_name"));
                d.setAmount(rs.getDouble("amount"));
                d.setCampaignTitle(rs.getString("campaign_title"));
                d.setDonationDate(rs.getString("donation_date"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Donation> getDonationsByDonorName(String donorName) {
        List<Donation> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT d.donation_id, d.campaign_id, d.donor_name, d.amount, " +
                         "d.donation_date, c.title AS campaign_title " +
                         "FROM donation d " +
                         "JOIN campaign c ON d.campaign_id = c.campaign_id " +
                         "WHERE d.donor_name = ? " +
                         "ORDER BY d.donation_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, donorName);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Donation d = new Donation();

                d.setDonationId(rs.getInt("donation_id"));
                d.setCampaignId(rs.getInt("campaign_id"));
                d.setDonorName(rs.getString("donor_name"));
                d.setAmount(rs.getDouble("amount"));
                d.setCampaignTitle(rs.getString("campaign_title"));
                d.setDonationDate(rs.getString("donation_date"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static boolean deleteDonation(int donationId) {
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            String getSql = "SELECT campaign_id, amount FROM donation WHERE donation_id = ?";
            PreparedStatement getPs = con.prepareStatement(getSql);
            getPs.setInt(1, donationId);

            ResultSet rs = getPs.executeQuery();

            if (!rs.next()) {
                con.rollback();
                return false;
            }

            int campaignId = rs.getInt("campaign_id");
            double amount = rs.getDouble("amount");

            String deleteSql = "DELETE FROM donation WHERE donation_id = ?";
            PreparedStatement deletePs = con.prepareStatement(deleteSql);
            deletePs.setInt(1, donationId);
            deletePs.executeUpdate();

            String updateSql = "UPDATE campaign SET amount_raised = amount_raised - ? WHERE campaign_id = ?";
            PreparedStatement updatePs = con.prepareStatement(updateSql);
            updatePs.setDouble(1, amount);
            updatePs.setInt(2, campaignId);
            updatePs.executeUpdate();

            con.commit();
            return true;

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

            e.printStackTrace();
            return false;

        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public static Donation getDonationById(int donationId) {
    Donation d = null;

    try {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT d.donation_id, d.campaign_id, d.donor_name, d.amount, " +
                     "d.donation_date, c.title AS campaign_title " +
                     "FROM donation d " +
                     "JOIN campaign c ON d.campaign_id = c.campaign_id " +
                     "WHERE d.donation_id = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, donationId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            d = new Donation();

            d.setDonationId(rs.getInt("donation_id"));
            d.setCampaignId(rs.getInt("campaign_id"));
            d.setDonorName(rs.getString("donor_name"));
            d.setAmount(rs.getDouble("amount"));
            d.setDonationDate(rs.getString("donation_date"));
            d.setCampaignTitle(rs.getString("campaign_title"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return d;
}
}