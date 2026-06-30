/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.User;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author farajuhaimi
 */
public class UserDAO {
     // ================= REGISTER =================
    public static boolean register(User u){
        boolean status=false;
        try{
            Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(
            "INSERT INTO registration(username,password,email,phone_no,role) VALUES(?,?,?,?,?)");

            ps.setString(1,u.getUsername());
            ps.setString(2,u.getPassword());
            ps.setString(3,u.getEmail());
            ps.setString(4,u.getPhoneNo());
            ps.setString(5,u.getRole());

            status=ps.executeUpdate()>0;
        }catch(Exception e){e.printStackTrace();}
        return status;
    }

    // ================= LOGIN =================
    public static User login(String username,String password,String role){
        User u=null;
        try{
            Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(
            "SELECT * FROM registration WHERE username=? AND password=? AND role=?");

            ps.setString(1,username);
            ps.setString(2,password);
            ps.setString(3,role);

            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                u=new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password")); // important
                u.setEmail(rs.getString("email"));
                u.setPhoneNo(rs.getString("phone_no"));
                u.setRole(rs.getString("role"));
                u.setOrgName(rs.getString("org_name"));
            }
        }catch(Exception e){e.printStackTrace();}
        return u;
    }

    // ================= GET USER BY ID =================
    public static User getUserById(int id){
        User u=null;
        try{
            Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(
            "SELECT * FROM registration WHERE user_id=?");

            ps.setInt(1,id);
            ResultSet rs=ps.executeQuery();

            if(rs.next()){
                u=new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNo(rs.getString("phone_no"));
                u.setRole(rs.getString("role"));
                u.setOrgName(rs.getString("org_name"));
            }
        }catch(Exception e){e.printStackTrace();}
        return u;
    }

    // ================= UPDATE PROFILE =================
    public static boolean updateProfile(User u){
        boolean status=false;
        try{
            Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(
            "UPDATE registration SET username=?,password=?,email=?,phone_no=? WHERE user_id=?");

            ps.setString(1,u.getUsername());
            ps.setString(2,u.getPassword());
            ps.setString(3,u.getEmail());
            ps.setString(4,u.getPhoneNo());
            ps.setInt(5,u.getUserId());

            status=ps.executeUpdate()>0;
        }catch(Exception e){e.printStackTrace();}
        return status;
    }
    // ================= GET ALL USERS =================
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM registration");
             ResultSet rs = ps.executeQuery()) {

            while(rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNo(rs.getString("phone_no"));
                u.setRole(rs.getString("role"));
                users.add(u);
            }

        } catch(Exception e){
            e.printStackTrace();
        }
        return users;
    }
}