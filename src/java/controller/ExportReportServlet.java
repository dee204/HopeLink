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

public class ExportReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("reportType");
        String returnPage = request.getParameter("returnPage");

        if (reportType == null || reportType.trim().equals("")) {
            reportType = "REPORT";
        }

        if (returnPage == null || returnPage.trim().equals("")) {
            returnPage = "ManagerDashboard.jsp";
        }

        NotificationDAO.addNotification(
            reportType + " exported successfully by manager.",
            "REPORT_EXPORTED",
            "MANAGER"
        );

        response.sendRedirect(returnPage);
    }
}