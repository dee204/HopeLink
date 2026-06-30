<%-- 
    Document   : FundraiserSidebar
    Created on : 1 Jul 2026, 12:32:57 AM
    Author     : farajuhaimi
--%>

<%@page import="model.User"%>
<%
    User fundraiserUser = (User) session.getAttribute("user");

    if (fundraiserUser == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String currentPage = request.getRequestURI();
%>

<style>
    body {
        padding-left: 280px;
        box-sizing: border-box;
    }

    .fundraiser-sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 280px;
        height: 100vh;
        background: linear-gradient(180deg, #ffd1dc 0%, #fff0f5 100%);
        border-right: 1px solid #ffbfd5;
        box-shadow: 8px 0 30px rgba(214, 51, 132, 0.10);
        z-index: 999;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 26px 20px;
        box-sizing: border-box;
    }

    .sidebar-user {
        width: 100%;
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid #ffdae9;
        border-radius: 18px;
        padding: 16px 14px;
        text-align: center;
        margin-bottom: 18px;
        box-sizing: border-box;
        box-shadow: 0 8px 22px rgba(214, 51, 132, 0.08);
        cursor: pointer;
        transition: 0.25s ease;
    }

    .sidebar-user:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 26px rgba(214, 51, 132, 0.14);
    }

    .sidebar-user span {
        display: block;
        font-size: 0.82em;
        color: #777;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .sidebar-user strong {
        display: block;
        color: #d63384;
        font-size: 1.15em;
        margin: 6px 0 4px;
    }

    .sidebar-user small {
        display: inline-block;
        background: #fff0f5;
        color: #d63384;
        border: 1px solid #ffdae9;
        border-radius: 999px;
        padding: 4px 12px;
        font-weight: 700;
        font-size: 0.78em;
    }

    .fundraiser-profile-box {
        width: 100%;
        background: white;
        border: 1px solid #ffdae9;
        border-radius: 16px;
        padding: 14px;
        margin-bottom: 18px;
        box-sizing: border-box;
        display: none;
        box-shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
    }

    .fundraiser-profile-box.show {
        display: block;
    }

    .profile-row {
        margin-bottom: 10px;
        font-size: 0.9em;
        color: #555;
    }

    .profile-row label {
        display: block;
        color: #d63384;
        font-weight: 800;
        font-size: 0.78em;
        text-transform: uppercase;
        margin-bottom: 3px;
    }

    .sidebar-menu {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 11px;
    }

    .sidebar-menu a {
        text-decoration: none;
        color: #333333;
        background: rgba(255, 255, 255, 0.82);
        border: 1px solid #ffdae9;
        border-radius: 14px;
        padding: 13px 15px;
        font-weight: 800;
        font-size: 0.95em;
        transition: all 0.25s ease;
        box-shadow: 0 5px 14px rgba(214, 51, 132, 0.05);
    }

    .sidebar-menu a:hover,
    .sidebar-menu a.active {
        background: #d63384;
        color: white;
        border-color: #d63384;
        transform: translateX(5px);
        box-shadow: 0 8px 18px rgba(214, 51, 132, 0.22);
    }

    .sidebar-logout {
        margin-top: auto;
        width: 100%;
        padding-top: 18px;
    }

    .sidebar-logout a {
        display: block;
        text-align: center;
        text-decoration: none;
        background: #d63384;
        color: white;
        border-radius: 14px;
        padding: 13px;
        font-weight: 900;
        box-shadow: 0 10px 22px rgba(214, 51, 132, 0.25);
        transition: all 0.25s ease;
    }

    .sidebar-logout a:hover {
        background: #b82b70;
        transform: translateY(-2px);
    }

    footer {
        left: 280px;
        width: calc(100% - 280px) !important;
    }
</style>

<div class="fundraiser-sidebar">

    <div class="sidebar-user" onclick="toggleFundraiserProfile()">
        <span>Logged in as</span>
        <strong><%= fundraiserUser.getUsername() %></strong>
        <small>Fundraiser</small>
    </div>

    <div class="fundraiser-profile-box" id="fundraiserProfileBox">
    <div class="profile-row">
        <label>Name</label>
        <%= fundraiserUser.getUsername() %>
    </div>

    <div class="profile-row">
        <label>Email</label>
        <%= fundraiserUser.getEmail() %>
    </div>

    <div class="profile-row">
        <label>Phone No</label>
        <%= fundraiserUser.getPhoneNo() %>
    </div>

    <div class="profile-row">
        <label>Organization</label>
        <%= fundraiserUser.getOrgName() %>
    </div>

    <div class="profile-row">
        <label>Role</label>
        <%= fundraiserUser.getRole() %>
    </div>
</div>

    <div class="sidebar-menu">
        <a href="FundraiserDashboard.jsp" class="<%= currentPage.contains("FundraiserDashboard.jsp") ? "active" : "" %>">Dashboard</a>
        <a href="FundraiserProfile.jsp" class="<%= currentPage.contains("FundraiserProfile.jsp") ? "active" : "" %>">My Profile</a>
        <a href="CreateCampaign.jsp" class="<%= currentPage.contains("CreateCampaign.jsp") ? "active" : "" %>">Create Campaign</a>
        <a href="ViewActiveCampaigns.jsp" class="<%= currentPage.contains("ViewActiveCampaigns.jsp") || currentPage.contains("EditCampaign.jsp") ? "active" : "" %>">Active Campaign</a>
        <a href="AllDonations.jsp" class="<%= currentPage.contains("AllDonations.jsp") ? "active" : "" %>">All Donations</a>
        <a href="TotalFund.jsp" class="<%= currentPage.contains("TotalFund.jsp") ? "active" : "" %>">Total Fund</a>
        <a href="ViewMessagesFundraiser.jsp" class="<%= currentPage.contains("ViewMessagesFundraiser.jsp") ? "active" : "" %>">Messages</a>
    </div>

    <div class="sidebar-logout">
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<script>
    function toggleFundraiserProfile() {
        var profileBox = document.getElementById("fundraiserProfileBox");
        profileBox.classList.toggle("show");
    }
</script>
