<%-- 
    Document   : FundraiserDashboard
    Created on : 31 Dec 2025, 4:55:57 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User u=(User)session.getAttribute("user");
if(u==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Fundraiser Dashboard</title>
    <style>
        :root {
            --primary-accent: #F2D3BC; 
            --charcoal: #333333;
            --soft-white: #f8f8f8;
            --pink-theme: #ffd1dc;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        /* --- Header Styling (Consistent) --- */
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
        /* --- Message Icon Styling --- */
        .msg-link {
        text-decoration: none !important; /* Removes the blue underline */
        border-bottom: none !important;  /* Ensures no border line appears */
        display: flex;
        align-items: center;
        transition: transform 0.2s ease;
        }

        .msg-link:hover {
        transform: scale(1.1); /* Cute pop effect */
        }

        .msg-icon {
        font-size: 1.8em;
        cursor: pointer;
        user-select: none;
        text-decoration: none;
        /* This ensures the emoji doesn't inherit link colors */
        color: initial; 
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px 120px 20px;
        }

        .welcome-msg {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 40px;
        }

        /* Grid for Dashboard Cards */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-bottom: 30px;
        }

        .bottom-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            max-width: 800px;
            margin: 0 auto;
        }

       /* --- Card Styling with "Pop" Effect --- */
.dash-card {
    background: linear-gradient(180deg, #ffffff 0%, #fff8fa 100%);
    border: 1px solid #ffdae9;
    border-radius: 18px;
    padding: 34px 28px;
    min-height: 230px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(214, 51, 132, 0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
    cursor: default;
}

.dash-card:hover {
    transform: translateY(-8px);
    border-color: #ffb6cf;
    box-shadow: 0 16px 35px rgba(214, 51, 132, 0.16);
}

.dash-card h3 {
    font-size: 1.45em;
    margin: 0 0 12px 0;
    font-weight: 800;
    color: #333333;
}

.card-icon {
    width: 68px;
    height: 68px;
    border-radius: 50%;
    background-color: #fff0f5;
    border: 2px solid #ffdae9;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2em;
    margin-bottom: 18px;
    box-shadow: inset 0 0 0 4px #ffffff;
}

.dash-card p {
    color: #666;
    font-size: 0.95em;
    line-height: 1.5;
    margin: 0 0 22px 0;
    max-width: 240px;
}

.dash-card a {
    color: #d63384;
    background-color: #fff0f5;
    border: 1px solid #ffbfd5;
    border-radius: 999px;
    padding: 10px 18px;
    text-decoration: none;
    font-weight: 700;
    font-size: 0.95em;
    transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
}

.dash-card a:hover {
    background-color: #d63384;
    color: white;
    text-decoration: none;
    transform: translateY(-2px);
}
.logout-btn {
    text-decoration: none;
    color: white;
    background: #d63384;
    border: 1px solid #c42b75;
    border-radius: 999px;
    padding: 11px 22px;
    font-weight: 800;
    font-size: 0.95em;
    box-shadow: 0 8px 18px rgba(214, 51, 132, 0.22);
    transition: all 0.25s ease;
}

.logout-btn:hover {
    background: #b82b70;
    transform: translateY(-2px);
    box-shadow: 0 12px 24px rgba(214, 51, 132, 0.30);
}

.logout-btn:active {
    transform: translateY(0);
}
        /* --- Footer Styling (Consistent) --- */
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

    <header>
        <div class="logo">
            <a href="HomePage.jsp">
                <img src="HopeLinkLogo.png" alt="HopeLink Logo">
            </a>
        </div>

        <div class="header-center">
            FUNDRAISER DASHBOARD
        </div>

        <div class="header-right">
            <a href="ViewMessagesFundraiser.jsp" class="msg-link" title="View Messages">
            <div class="msg-icon">💬</div>
            </a>
           <div class="header-right">
          <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="welcome-msg">
            Welcome, <%=u.getUsername()%> 
        </div>

        <div class="dashboard-grid">
            <div class="dash-card">
                <h3>My Profile</h3>
                <div class="card-icon">👤</div>
                <p>Edit personal and store information here</p>
                <a href="FundraiserProfile.jsp">Edit Profile</a>
            </div>

            <div class="dash-card">
                <h3>Create Campaign</h3>
                <div class="card-icon">📢</div>
                <p>Create a new campaign</p>
                <a href="CreateCampaign.jsp">Go to Campaigns Form</a>
            </div>

            <div class="dash-card">
                <h3>Active Campaign</h3>
                <div class="card-icon">⚙️</div>
                <p>See list of all active; approved campaigns</p>
                <a href="ViewActiveCampaigns.jsp">View Campaigns</a>
            </div>
        </div>

        <div class="bottom-grid">
            <div class="dash-card">
                <h3>All Donations</h3>
                <div class="card-icon">💰</div>
                <p>See list of all donations</p>
                <a href="AllDonations.jsp">View Donations</a>
            </div>

            <div class="dash-card">
                <h3>Total Fund</h3>
                <div class="card-icon">🏦</div>
                <p>See total money donated</p>
                <a href="TotalFund.jsp">View Total Fund</a>
            </div>
        </div>
    </div>
<%-- Show popup only if campaign created successfully --%>
<% if("true".equals(request.getParameter("success"))){ %>
<script>
    alert("✅ Campaign created successfully!");
</script>
<% } %>



    <footer>
        <p>© 2026 Fundraising Platform. All rights reserved</p>
    </footer>
<%-- Show popup if profile updated successfully --%>
<% if("success".equals(request.getParameter("update"))){ %>
<script>
    alert("✅ Profile updated successfully!");
</script>
<% } %>
</body>
</html>
