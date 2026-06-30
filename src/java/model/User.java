/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author farajuhaimi
 */
public class User {
 private int userId;
    private String username;
    private String password;
    private String email;
    private String phoneNo;
    private String role;
private String orgName;

public String getOrgName() {
    return orgName;
}

public void setOrgName(String orgName) {
    this.orgName = orgName;
}
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNo() { return phoneNo; }
    public void setPhoneNo(String phoneNo) { this.phoneNo = phoneNo; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}