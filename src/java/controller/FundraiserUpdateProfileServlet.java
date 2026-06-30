/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.NotificationDAO;
import dao.UserDAO;
import model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author farajuhaimi
 */
public class FundraiserUpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            res.sendRedirect("Login.jsp");
            return;
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phoneNo");

        User u = new User();
        u.setUserId(sessionUser.getUserId());
        u.setUsername(username);
        u.setPassword(password);
        u.setEmail(email);
        u.setPhoneNo(phone);
        u.setRole(sessionUser.getRole());

        boolean success = UserDAO.updateProfile(u);

        if (success) {
            session.setAttribute("user", u);

            NotificationDAO.addNotification(
                "Profile updated successfully for " + username + ".",
                "PROFILE",
                "FUNDRAISER"
            );

            res.sendRedirect("FundraiserDashboard.jsp?update=success");
        } else {
            res.sendRedirect("FundraiserProfile.jsp?update=fail");
        }
    }
}