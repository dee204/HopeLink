<%-- 
    Document   : ViewActiveCampaigns
    Created on : 31 Dec 2025, 8:06:08 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO"%>
<%@page import="model.Campaign"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HopeLink | Active Campaign</title>

<style>
:root {
    --primary-accent: #F2D3BC; 
    --charcoal: #333333;
    --soft-white: #fef9f9;
    --pink-theme: #ffd1dc;
    --table-header-bg: #fff0f3;
    --magenta-text: #d63384;
    --border-pink: #ffdae9;
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
}

.container {
    max-width: 1250px;
    margin: 60px auto 140px auto;
    padding: 0 25px;
}

.table-card {
    background: white;
    border-radius: 15px;
    border: 2px solid var(--border-pink);
    overflow: hidden;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: var(--table-header-bg);
    color: var(--magenta-text);
    padding: 20px;
}

td {
    padding: 18px;
    text-align: center;
    border-bottom: 1px solid var(--border-pink);
}

.icon-btn {
    border: none;
    background: none;
    cursor: pointer;
}

.icon-btn img {
    width: 30px;
}

footer {
    background: var(--pink-theme);
    text-align: center;
    padding: 20px;
    position: fixed;
    bottom: 0;
    width: 100%;
}
</style>
</head>

<body>
<%@ include file="FundraiserSidebar.jsp" %>
<header>
    <div class="logo">
      
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
        
    </div>

    <div class="header-center">LIST OF ALL ACTIVE CAMPAIGNS</div>
</header>

<div class="container">
    <div class="table-card">

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Organization</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Goal (RM)</th>
                    <th>Status</th>
                    <th>Created At</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
            <%
                List<Campaign> list = CampaignDAO.getApprovedCampaigns();

                if (list != null && !list.isEmpty()) {
                    for (Campaign c : list) {
            %>
                <tr>
                    <td>C-<%= c.getCampaignId() %></td>

                    <td>
                        <img src="uploads/<%= c.getImage() %>" 
                             style="width:70px;border-radius:10px;"
                             alt="Campaign Image">
                    </td>

                    <td><%= c.getOrgName() %></td>
                    <td><%= c.getTitle() %></td>
                    <td><%= c.getDescription() %></td>
                    <td>RM <%= c.getAmountGoal() %></td>

                    <td style="color:#28a745;font-weight:bold;">
                        <%= c.getStatus() %>
                    </td>

                    <td><%= c.getCreatedAt() %></td>

                    <td>
                        <button class="icon-btn"
                                onclick="location.href='EditCampaign.jsp?id=<%= c.getCampaignId() %>'">
                            <img src="https://cdn-icons-png.flaticon.com/512/1159/1159633.png" alt="Edit">
                        </button>

                        <button class="icon-btn"
                                onclick="return confirmDelete(<%= c.getCampaignId() %>)">
                            <img src="https://cdn-icons-png.flaticon.com/512/6861/6861362.png" alt="Delete">
                        </button>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="9">No active campaigns found.</td>
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

<script>
function confirmDelete(id) {
    if (confirm("Are you sure want to delete this campaign?")) {
        window.location = "CampaignServlet?action=delete&id=" + id;
    }

    return false;
}
</script>

<% if ("success".equals(request.getParameter("update"))) { %>
<script>
    alert("Campaign updated successfully!");
</script>
<% } %>

</body>
</html>