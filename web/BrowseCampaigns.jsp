<%-- 
    Document   : BrowseCampaigns
    Created on : 31 Dec 2025, 9:04:57 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO"%>
<%@page import="model.Campaign"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Browse Campaigns</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
            --magenta-text: #d63384;
            --border-pink: #ffdae9;
            --shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
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
        }

        .header-right {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto 140px auto;
            padding: 25px;
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 20px;
            box-shadow: var(--shadow);
        }

        h2 {
            margin-top: 0;
            font-size: 1.8em;
            color: var(--charcoal);
        }

        .filter-bar {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            background: #f2f2f2;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 40px;
        }

        .filter-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1em;
        }

        .filter-group select {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-family: 'Quicksand', sans-serif;
            font-size: 1em;
            background-color: white;
        }

        .campaign-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
        }

        .campaign-card {
            border: 1px solid #ddd;
            border-radius: 15px;
            padding: 25px;
            text-align: left;
            transition: transform 0.3s ease;
        }

        .campaign-card:hover {
            transform: translateY(-5px);
            border-color: var(--magenta-text);
        }

        .campaign-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .campaign-title {
            font-size: 1.4em;
            font-weight: 700;
            margin: 10px 0;
            color: var(--charcoal);
        }

        .campaign-desc {
            font-size: 1em;
            color: #555;
            line-height: 1.5;
            margin-bottom: 20px;
            height: 4.5em;
            overflow: hidden;
        }

        .btn-view {
            background-color: #d9d9d9;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: background 0.3s;
        }

        .btn-view:hover {
            background-color: var(--magenta-text);
            color: white;
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
<%@ include file="DonorSidebar.jsp" %>
<header>
    <div class="logo">

            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
    </div>

    <div class="header-center">BROWSE FOR CAMPAIGNS</div>
</header>

<div class="container">
    <h2>Available Campaigns</h2>

    <div class="filter-bar">
        <div class="filter-group">
            <label>Sort Campaigns</label>

            <form method="get" style="display:flex; gap:10px;">
                <select name="sort" onchange="this.form.submit()">
                    <option value="none" <%= "none".equals(request.getParameter("sort")) || request.getParameter("sort") == null ? "selected" : "" %>>
                        Sort By
                    </option>
                    <option value="title" <%= "title".equals(request.getParameter("sort")) ? "selected" : "" %>>
                        Title
                    </option>
                    <option value="goal" <%= "goal".equals(request.getParameter("sort")) ? "selected" : "" %>>
                        Goal Amount
                    </option>
                </select>
            </form>
        </div>
    </div>

    <div class="campaign-grid">
        <%
            List<Campaign> list = CampaignDAO.getApprovedCampaigns();

            String sort = request.getParameter("sort");

            if (sort != null) {
                if (sort.equals("goal")) {
                    Collections.sort(list, new Comparator<Campaign>() {
                        public int compare(Campaign c1, Campaign c2) {
                            return Double.compare(c1.getAmountGoal(), c2.getAmountGoal());
                        }
                    });
                } else if (sort.equals("title")) {
                    Collections.sort(list, new Comparator<Campaign>() {
                        public int compare(Campaign c1, Campaign c2) {
                            return c1.getTitle().compareToIgnoreCase(c2.getTitle());
                        }
                    });
                }
            }

            if (list != null && !list.isEmpty()) {
                for (Campaign c : list) {
        %>

        <div class="campaign-card">
            <img src="uploads/<%= c.getImage() %>" alt="Campaign Image">

            <div class="campaign-title"><%= c.getTitle() %></div>

            <div class="campaign-desc"><%= c.getDescription() %></div>

            <p style="font-weight:600;">Organization: <%= c.getOrgName() %></p>

            <p style="font-weight:700;color:#d63384;">
                Goal: RM <%= String.format("%.2f", c.getAmountGoal()) %>
            </p>

            <p style="font-weight:700;color:#333333;">
                Raised: RM <%= String.format("%.2f", c.getAmountRaised()) %>
            </p>

            <a href="CampaignDetailsServlet?id=<%= c.getCampaignId() %>">
                <button class="btn-view">View Campaign</button>
            </a>
        </div>

        <%
                }
            } else {
        %>

        <p>No approved campaigns available.</p>

        <%
            }
        %>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>