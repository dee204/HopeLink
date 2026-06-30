<%-- 
    Document   : ViewCampaignsApproval
    Created on : 31 Dec 2025, 5:50:48 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Campaign"%>
<%@page import="dao.CampaignDAO"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Campaign Approval</title>

    <style>
        :root {
            --primary-accent: #F2D3BC; 
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
            --table-header-bg: #fff0f3;
            --row-hover: #fff8f9;
            --border-radius: 15px;
            --approve-green: #77dd77;
            --reject-red: #ff6961;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        header {
            display: grid;
            grid-template-columns: 1fr 2fr 1fr;
            align-items: center;
            padding: 0px 60px;
            background-color: var(--pink-theme);
            border-bottom: 1px solid #eee;
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
            height: 100px;
        }

        .logo img {
            height: 100px; 
            width: auto;
            display: block;
            filter: drop-shadow(0px 4px 6px rgba(0, 0, 0, 0.15)); 
            transition: transform 0.3s ease, filter 0.3s ease;
        }

        .logo img:hover {
            transform: scale(1.05);
            filter: drop-shadow(0px 8px 12px rgba(0, 0, 0, 0.2));
        }

        .header-center {
            text-align: center;
            font-weight: 700;
            font-size: 1.4em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .header-right {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 20px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            font-weight: 700;
            font-size: 1.1em;
            cursor: pointer;
        }

        .container {
            max-width: 1200px;
            margin: 60px auto 120px auto;
            padding: 25px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 30px rgba(255, 182, 193, 0.2);
            border: 1px solid rgba(255, 209, 220, 0.5);
        }

        .table-wrapper {
            overflow: hidden;
            border-radius: var(--border-radius);
            border: 2px solid var(--pink-theme);
            margin-bottom: 30px; 
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th {
            background-color: var(--table-header-bg);
            color: #d63384; 
            padding: 20px;
            font-size: 1.1em;
            font-weight: 700;
            border-bottom: 2px solid var(--pink-theme);
            text-align: center;
        }

        td {
            padding: 18px 15px;
            text-align: center;
            border-bottom: 1px solid #ffe5ec;
            font-size: 0.95em;
        }

        tr:hover td {
            background-color: var(--row-hover);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .control-btn {
            padding: 10px 20px;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            font-weight: 700;
            font-size: 0.9em;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .btn-approve {
            background-color: var(--approve-green);
        }

        .btn-reject {
            background-color: var(--reject-red);
        }

        .control-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            filter: brightness(1.05);
        }

        footer {
            background-color: var(--pink-theme);
            text-align: center;
            padding: 20px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>

<body>
<%@ include file="ManagerSidebar.jsp" %>
<header>
    <div class="logo">
       
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
      
    </div>

    <div class="header-center">CAMPAIGN APPROVAL PANEL</div>

    <div class="header-right">
        
    </div>
</header>

<div class="container">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Campaign ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Goal Fund</th>
                    <th>Amount Raised</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
            <%
                List<Campaign> campaigns = CampaignDAO.getPendingCampaigns();

                if (campaigns != null && !campaigns.isEmpty()) {
                    for (Campaign campaign : campaigns) {
            %>
                <tr>
                    <td>C-<%= campaign.getCampaignId() %></td>
                    <td><%= campaign.getTitle() %></td>
                    <td><%= campaign.getDescription() %></td>
                    <td>RM <%= campaign.getAmountGoal() %></td>
                    <td>RM <%= campaign.getAmountRaised() %></td>
                    <td>
                        <span style="color: #ffa500; font-weight: bold;">
                            <%= campaign.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <form action="CampaignServlet" method="post">
                            <input type="hidden" name="campaignId" value="<%= campaign.getCampaignId() %>">

                            <div class="action-buttons">
                                <button type="submit" name="action" value="reject" class="control-btn btn-reject">
                                    Reject
                                </button>

                                <button type="submit" name="action" value="approve" class="control-btn btn-approve">
                                    Approve
                                </button>
                            </div>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="7">No pending campaigns found.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>