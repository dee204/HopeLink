/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author farajuhaimi
 */
public class LoginServlet extends HttpServlet {
protected void doPost(HttpServletRequest req,HttpServletResponse res)
            throws ServletException,IOException{

        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String role=req.getParameter("role");

        User u=UserDAO.login(username,password,role);

        if(u!=null){
            HttpSession session=req.getSession();
            session.setAttribute("user",u);

            // ROLE REDIRECT
            if(role.equals("Fundraiser"))
                res.sendRedirect("FundraiserDashboard.jsp");
            else if(role.equals("Donor"))
                res.sendRedirect("DonorDashboard.jsp");
            else
                res.sendRedirect("ManagerDashboard.jsp");
        }
        else{
            res.sendRedirect("Login.jsp?error=true");
        }
    }
}