<%-- 
    Document   : DonorSidebar
    Created on : 1 Jul 2026, 1:02:41 AM
    Author     : farajuhaimi
--%>

<%@page import="model.User"%>
<%
    User donorUser = (User) session.getAttribute("user");

    if (donorUser == null) {
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

    .donor-sidebar {
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

    .donor-profile-box {
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

    .donor-profile-box.show {
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

<div class="donor-sidebar">

    <div class="sidebar-user" onclick="toggleDonorProfile()">
        <span>Logged in as</span>
        <strong><%= donorUser.getUsername() %></strong>
        <small>Donor</small>
    </div>

    <div class="donor-profile-box" id="donorProfileBox">
        <div class="profile-row">
            <label>Name</label>
            <%= donorUser.getUsername() %>
        </div>

        <div class="profile-row">
            <label>Email</label>
            <%= donorUser.getEmail() %>
        </div>

        <div class="profile-row">
            <label>Phone No</label>
            <%= donorUser.getPhoneNo() %>
        </div>

        <div class="profile-row">
            <label>Role</label>
            <%= donorUser.getRole() %>
        </div>
    </div>

    <div class="sidebar-menu">
        <a href="DonorDashboard.jsp" class="<%= currentPage.contains("DonorDashboard.jsp") ? "active" : "" %>">Dashboard</a>
        <a href="DonorProfile.jsp" class="<%= currentPage.contains("DonorProfile.jsp") ? "active" : "" %>">My Profile</a>
        <a href="BrowseCampaigns.jsp" class="<%= currentPage.contains("BrowseCampaigns.jsp") || currentPage.contains("CampaignDetails") ? "active" : "" %>">Browse Campaigns</a>
        <a href="DonationHistory.jsp" class="<%= currentPage.contains("DonationHistory.jsp") || currentPage.contains("DonationReceipt.jsp") ? "active" : "" %>">Donation History</a>
        <a href="ViewMessagesDonor.jsp" class="<%= currentPage.contains("ViewMessagesDonor.jsp") ? "active" : "" %>">Messages</a>
    </div>

    <div class="sidebar-logout">
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<script>
    function toggleDonorProfile() {
        var profileBox = document.getElementById("donorProfileBox");
        profileBox.classList.toggle("show");
    }
</script>
