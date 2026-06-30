/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.CampaignDAO;
import javax.servlet.RequestDispatcher;
import model.Campaign;
/**
 *
 * @author farajuhaimi
 */
public class CampaignDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Campaign c = CampaignDAO.getCampaignById(id);

        request.setAttribute("campaign", c);
        RequestDispatcher rd = request.getRequestDispatcher("CampaignDetails.jsp");
        rd.forward(request, response);
    }
}