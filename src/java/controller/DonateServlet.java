/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.NotificationDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DonationDAO;
import model.Donation;
/**
 *
 * @author farajuhaimi
 */
public class DonateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String campaignIdParam = request.getParameter("campaignId");
            String donorName = request.getParameter("donorName");
            String amountParam = request.getParameter("amount");

            if (campaignIdParam == null || campaignIdParam.trim().equals("") ||
                donorName == null || donorName.trim().equals("") ||
                amountParam == null || amountParam.trim().equals("")) {

                response.sendRedirect("Payments.jsp?payment=invalid_input");
                return;
            }

            int campaignId = Integer.parseInt(campaignIdParam);
            double amount = Double.parseDouble(amountParam);

            if (amount <= 0) {
                response.sendRedirect("Payments.jsp?payment=invalid_input");
                return;
            }

            Donation d = new Donation();
            d.setCampaignId(campaignId);
            d.setDonorName(donorName);
            d.setAmount(amount);

            boolean success = DonationDAO.addDonation(d);

            if (success) {
                NotificationDAO.addNotification(
                    "Successful donation of RM " + String.format("%.2f", amount) +
                    " made by " + donorName + ".",
                    "DONATION",
                    "DONOR"
                );

                NotificationDAO.addNotification(
                    "New donation of RM " + String.format("%.2f", amount) +
                    " received from " + donorName + ".",
                    "DONATION_RECEIVED",
                    "FUNDRAISER"
                );

                response.sendRedirect("Payments.jsp?payment=success");
            } else {
                response.sendRedirect("Payments.jsp?payment=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Payments.jsp?payment=invalid_input");
        }
    }
}