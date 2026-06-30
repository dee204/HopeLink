/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.NotificationDAO;
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
public class NotificationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int notificationId = Integer.parseInt(request.getParameter("notificationId"));

        String filter = request.getParameter("filter");

        if (filter == null || filter.trim().equals("")) {
            filter = "ALL";
        }

        NotificationDAO.markAsRead(notificationId);

        response.sendRedirect("ViewMessagesDonor.jsp?filter=" + filter);
    }
}