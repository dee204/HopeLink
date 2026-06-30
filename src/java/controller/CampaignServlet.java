/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.NotificationDAO;
import dao.CampaignDAO;
import model.Campaign;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.io.File;


/**
 *
 * @author farajuhaimi
 */
@MultipartConfig
public class CampaignServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("create")) {
            createCampaign(request, response);
        } 
        else if (action.equals("update")) {
            updateCampaign(request, response);
        }
        else if (action.equals("approve")) {
            approveCampaign(request, response);
        }
        else if (action.equals("reject")) {
            rejectCampaign(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equals("delete")) {
            deleteCampaign(request, response);
        }
    }

    // ================= CREATE =================
    private void createCampaign(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String title = req.getParameter("title");
        String desc = req.getParameter("description");
        String org = req.getParameter("orgName");
        double amountGoal = Double.parseDouble(req.getParameter("amount"));

        Part file = req.getPart("campaignImage");
        String fileName = "";

        if (file != null && file.getSize() > 0) {
            fileName = file.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + "uploads";
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            file.write(uploadPath + File.separator + fileName);
        }

        Campaign c = new Campaign(title, desc, org, amountGoal);
        c.setAmountGoal(amountGoal);
        c.setAmountRaised(0);
        c.setStatus("PENDING");
        c.setImage(fileName);

        boolean success = CampaignDAO.insertCampaign(c);

        if (success) {
            NotificationDAO.addNotification(
                "Campaign \"" + title + "\" created successfully and is waiting for manager approval.",
                "CAMPAIGN_CREATED",
                "FUNDRAISER"
            );
            NotificationDAO.addNotification(
    "New campaign submitted by fundraiser: \"" + title + "\". Please review for approval.",
    "CAMPAIGN_SUBMITTED",
    "MANAGER"
);

            res.sendRedirect("FundraiserDashboard.jsp?success=true");
        } else {
            res.sendRedirect("CreateCampaign.jsp?success=false");
        }
    }

    // ================= UPDATE =================
    private void updateCampaign(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        int id = Integer.parseInt(req.getParameter("id"));

        Campaign oldCampaign = CampaignDAO.getCampaignById(id);

        Campaign c = new Campaign();
        c.setCampaignId(id);
        c.setTitle(req.getParameter("title"));
        c.setDescription(req.getParameter("description"));
        c.setOrgName(req.getParameter("orgName"));
        c.setAmountGoal(Double.parseDouble(req.getParameter("amount")));

        if (oldCampaign != null) {
            c.setAmountRaised(oldCampaign.getAmountRaised());
            c.setStatus(oldCampaign.getStatus());
            c.setImage(oldCampaign.getImage());
        } else {
            c.setAmountRaised(0);
            c.setStatus("PENDING");
            c.setImage("");
        }

        Part file = req.getPart("campaignImage");

        if (file != null && file.getSize() > 0) {
            String fileName = file.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + "uploads";
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            file.write(uploadPath + File.separator + fileName);
            c.setImage(fileName);
        }

        boolean success = CampaignDAO.updateCampaign(c);

        if (success) {
            res.sendRedirect("ViewActiveCampaigns.jsp?update=success");
        } else {
            res.sendRedirect("ViewActiveCampaigns.jsp?update=fail");
        }
    }

    // ================= APPROVE =================
    private void approveCampaign(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int campaignId = Integer.parseInt(req.getParameter("campaignId"));

        boolean success = CampaignDAO.updateCampaignStatus(campaignId, "APPROVED");

        if (success) {
            Campaign campaign = CampaignDAO.getCampaignById(campaignId);

            NotificationDAO.addNotification(
                "Your campaign \"" + campaign.getTitle() + "\" has been approved by the manager.",
                "CAMPAIGN_APPROVED",
                "FUNDRAISER"
            );

            res.sendRedirect("ViewCampaignsApproval.jsp?approval=success");
        } else {
            res.sendRedirect("ViewCampaignsApproval.jsp?approval=fail");
        }
    }

    // ================= REJECT =================
    private void rejectCampaign(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int campaignId = Integer.parseInt(req.getParameter("campaignId"));

        boolean success = CampaignDAO.updateCampaignStatus(campaignId, "REJECTED");

        if (success) {
            Campaign campaign = CampaignDAO.getCampaignById(campaignId);

            NotificationDAO.addNotification(
                "Your campaign \"" + campaign.getTitle() + "\" has been rejected by the manager.",
                "CAMPAIGN_REJECTED",
                "FUNDRAISER"
            );

            res.sendRedirect("ViewCampaignsApproval.jsp?approval=success");
        } else {
            res.sendRedirect("ViewCampaignsApproval.jsp?approval=fail");
        }
    }

    // ================= DELETE =================
    private void deleteCampaign(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        CampaignDAO.deleteCampaign(id);

        res.sendRedirect("ViewActiveCampaigns.jsp");
    }
}