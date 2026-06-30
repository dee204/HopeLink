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

/**
 *
 * @author farajuhaimi
 */
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,HttpServletResponse res)
            throws ServletException,IOException{

        User u=new User();
        u.setUsername(req.getParameter("username"));
        u.setPassword(req.getParameter("password"));
        u.setEmail(req.getParameter("email"));
        u.setPhoneNo(req.getParameter("phoneNo"));
        u.setRole(req.getParameter("role"));

        if(UserDAO.register(u)){
            res.sendRedirect("Login.jsp?reg=success");
        }else{
            res.sendRedirect("Register.jsp?reg=fail");
        }
    }
}
