<%-- 
    Document   : Homepage
    Created on : 31 Dec 2025, 1:02:19 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO"%>
<%@page import="model.Campaign"%>
<%@page import="java.util.List"%>

<%
    double totalFund = CampaignDAO.getTotalAmountRaised();
    List<Campaign> campaignList = CampaignDAO.getApprovedCampaigns();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Helping Hands</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --soft-pink: #fff0f3;
            --aesthetic-pink: #ffb3c1;
            --magenta-accent: #d63384;
            --charcoal: #333333;
            --shadow: 0 10px 30px rgba(255, 182, 193, 0.2);
        }

        body {
            font-family: 'Quicksand', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff9fa;
            color: var(--charcoal);
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0px 60px;
            background-color: #ffd1dc;
            border-bottom: 1px solid #eee;
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
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

        .header-right {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--charcoal);
            font-weight: 700;
            font-size: 1.1em;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: var(--magenta-accent);
        }

        .search-bar {
            display: flex;
            align-items: center;
            font-weight: bold;
            font-size: 1.1em;
            cursor: pointer;
        }

        .hero-container {
            max-width: 1100px;
            margin: 40px auto;
            position: relative;
            border-radius: 30px;
            overflow: hidden;
            box-shadow: var(--shadow);
            height: 450px;
            border: 8px solid white;
        }

        .mySlides {
            display: none;
            width: 100%;
            height: 450px;
            object-fit: cover;
        }

        .content-section {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 20px;
            text-align: center;
        }

        .section-title {
            font-size: 2.5em;
            color: var(--magenta-accent);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .campaign-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            margin-top: 50px;
        }

        .campaign-card {
            background: white;
            padding: 20px;
            border-radius: 25px;
            box-shadow: var(--shadow);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: 1px solid var(--soft-pink);
            position: relative;
            overflow: hidden;
        }

        .campaign-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(214, 51, 132, 0.15);
        }

        .campaign-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 20px;
            margin-bottom: 15px;
            background: var(--soft-pink);
        }

        .goal-tag {
            background: var(--soft-pink);
            color: var(--magenta-accent);
            padding: 5px 15px;
            border-radius: 50px;
            font-weight: 700;
            display: inline-block;
            margin: 6px 4px;
        }

        .btn-donate {
            background: linear-gradient(135deg, #ffb3c1 0%, #ff85a1 100%);
            border: none;
            padding: 15px 25px;
            border-radius: 50px;
            color: white;
            font-weight: 700;
            font-size: 1.1em;
            cursor: pointer;
            margin-top: 20px;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 133, 161, 0.3);
        }

        .btn-donate:hover {
            transform: scale(1.02);
            box-shadow: 0 6px 20px rgba(255, 133, 161, 0.5);
        }

        footer {
            background-color: #ffd1dc;
            color: black;
            text-align: center;
            padding: 25px 0;
            margin-top: 80px;
            font-weight: 600;
        }

        .fade {
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @keyframes fade {
            from { opacity: .4; } 
            to { opacity: 1; }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">

    </div>

    <div class="header-right">
        <div class="nav-links">
            <a href="Login.jsp">Login</a>
        </div>

    </div>
</header>

<div class="hero-container">
    <img class="mySlides fade" src="donate1.png" alt="Campaign 1">
    <img class="mySlides fade" src="donate2.jpg" alt="Campaign 2">
    <img class="mySlides fade" src="donate3.jpg" alt="Campaign 3">
</div>

<div style="text-align: center; margin-top: -20px; position: relative; z-index: 10;">
    <div style="display: inline-flex; background: white; padding: 15px 40px; border-radius: 50px; box-shadow: 0 10px 20px rgba(214, 51, 132, 0.1); border: 1px solid #ffdae9; align-items: center; gap: 15px;">
        <span style="font-size: 1.5em;">&#9829;</span>
        <span style="font-weight: 700; color: #d63384;">
            Total Fund Raised: RM <span id="dailyTotal">0</span>
        </span>
    </div>
</div>

<section class="content-section">
    <h2 class="section-title">Active Fundraising Campaigns</h2>
    <p style="color: #888; font-size: 1.2em; font-weight: 400;">Your small contribution can make a big difference</p>

    <div class="campaign-grid">
        <% if (campaignList != null && !campaignList.isEmpty()) {
            for (Campaign c : campaignList) { %>

            <div class="campaign-card">
                <img class="campaign-img" src="uploads/<%= c.getImage() %>" alt="Campaign Image">

                <h3 style="color: #d63384; font-size: 1.5em; margin-bottom: 10px;">
                    <%= c.getTitle() %>
                </h3>

                <p style="color: #666; font-size: 0.95em; line-height: 1.6; height: 50px; overflow: hidden;">
                    <%= c.getDescription() %>
                </p>

                <p style="color:#555; font-weight:700;">
                    Organization: <%= c.getOrgName() %>
                </p>

                <div class="goal-tag">
                    Target: RM <%= String.format("%.2f", c.getAmountGoal()) %>
                </div>

                <div class="goal-tag">
                    Raised: RM <%= String.format("%.2f", c.getAmountRaised()) %>
                </div>

                <a href="Login.jsp">
                    <button class="btn-donate">Donate with Love</button>
                </a>
            </div>

        <%  }
        } else { %>

            <p style="grid-column: 1 / -1; color: #888; font-size: 1.2em;">
                No active campaigns available.
            </p>

        <% } %>
    </div>
</section>

<script>
    function animateStats(id, start, end, duration) {
        var obj = document.getElementById(id);
        var startTime = null;

        function step(timestamp) {
            if (!startTime) {
                startTime = timestamp;
            }

            var progress = Math.min((timestamp - startTime) / duration, 1);
            var current = start + ((end - start) * progress);

            obj.innerHTML = current.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });

            if (progress < 1) {
                requestAnimationFrame(step);
            }
        }

        requestAnimationFrame(step);
    }

    var slideIndex = 0;

    function showSlides() {
        var slides = document.getElementsByClassName("mySlides");

        for (var i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }

        slideIndex++;

        if (slideIndex > slides.length) {
            slideIndex = 1;
        }

        if (slides.length > 0) {
            slides[slideIndex - 1].style.display = "block";
        }

        setTimeout(showSlides, 5000);
    }

    document.addEventListener('DOMContentLoaded', function() {
        showSlides();
        animateStats("dailyTotal", 0, <%= totalFund %>, 2000);
    });
</script>

<footer>
    <p>&copy; 2026 Hopelink Fundraising Platform. All rights reserved.</p>
</footer>

</body>
</html>