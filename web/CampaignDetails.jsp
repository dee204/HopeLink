<%-- 
    Document   : CampaignDetails
    Created on : 21 Apr 2026, 7:22:28 PM
    Author     : farajuhaimi
--%>

<%@page import="model.Campaign,dao.DonationDAO,model.Donation,java.util.*"%>

<%
    Campaign c = (Campaign) request.getAttribute("campaign");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Campaign Details</title>

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
            font-family: 'Quicksand', sans-serif;
            margin: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        /* HEADER */
        header {
            display: grid;
            grid-template-columns: 1fr 2fr 1fr;
            align-items: center;
            padding: 0px 60px;
            background-color: var(--pink-theme);
            height: 100px;
        }

        .logo img {
            height: 100px;
        }

        .header-center {
            text-align: center;
            font-weight: 700;
            font-size: 1.4em;
            text-transform: uppercase;
        }

        /* CONTAINER */
        .container {
            max-width: 900px;
            margin: 40px auto 120px auto;
            padding: 30px;
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 20px;
            box-shadow: var(--shadow);
        }

        h2 {
            margin-top: 0;
            font-size: 2em;
        }

        .campaign-img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .info p {
            margin: 8px 0;
        }

        .goal {
            font-weight: 700;
            color: var(--magenta-text);
        }

        /* PROGRESS BAR */
        .progress-bar {
            background: #eee;
            border-radius: 20px;
            overflow: hidden;
            height: 20px;
            margin: 15px 0;
        }

        .progress-fill {
            background: var(--magenta-text);
            height: 100%;
        }

        /* DONATION FORM */
        .donation-box {
            margin-top: 30px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 15px;
        }

        .donation-box input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .btn-donate {
            background-color: var(--magenta-text);
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-donate:hover {
            background-color: #b52a6a;
        }

        /* DONATION LIST */
        .donation-list {
            margin-top: 30px;
        }

        .donation-item {
            background: #fff;
            border: 1px solid #eee;
            padding: 10px 15px;
            border-radius: 10px;
            margin-bottom: 10px;
        }

        /* FOOTER */
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
<%@ include file="FundraiserSidebar.jsp" %>
<header>
    <div class="logo">

            <img src="HopeLinkLogo.png">
    </div>
    <div class="header-center">JOIN CAMPAIGN</div>
</header>

<div class="container">
<%
    String success = request.getParameter("success");
    if("true".equals(success)){
%>

<div style="
    background:#d4edda;
    color:#155724;
    padding:15px;
    border-radius:10px;
    margin-bottom:20px;
    text-align:center;
    font-weight:600;">
    Donation Successful! Thank you for your support.
</div>

<% } %>
    <h2><%=c.getTitle()%></h2>

    <img class="campaign-img" src="uploads/<%=c.getImage()%>">

    <div class="info">
        <p><%=c.getDescription()%></p>
        <p><b>Organization:</b> <%=c.getOrgName()%></p>

        <p class="goal">Goal: RM <%=c.getAmountGoal()%></p>
        <p><b>Raised:</b> RM <%=c.getAmountRaised()%></p>
    </div>

    <!-- PROGRESS -->
    <div class="progress-bar">
        <div class="progress-fill"
             style="width:<%= (c.getAmountGoal() == 0 ? 0 : (c.getAmountRaised()/c.getAmountGoal())*100) %>%;">
        </div>
    </div>

    <!-- DONATION BUTTON ONLY -->
<div class="donation-box">
    <h3>Support this Campaign</h3>

    <form action="Payments.jsp" method="get">
        <input type="hidden" name="campaignId" value="<%=c.getCampaignId()%>">
        <input type="hidden" name="campaignTitle" value="<%=c.getTitle()%>">

        <button class="btn-donate">Donate Now</button>
    </form>
</div>

    

</div>

<footer>
    <p>© 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>