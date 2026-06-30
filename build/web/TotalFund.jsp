<%-- 
    Document   : TotalFund
    Created on : 31 Dec 2025, 8:36:06 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO"%>
<%@page import="model.Campaign"%>
<%@page import="java.util.List"%>

<%
    double totalFund = CampaignDAO.getTotalAmountRaised();
    List<Campaign> campaignList = CampaignDAO.getCampaignFundSummary();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Total Fund Donated</title>
    <style>
        :root {
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
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
            text-transform: uppercase;
        }

        .header-right {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .container {
            max-width: 1000px;
            margin: 80px auto 140px auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .fund-card {
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 20px;
            padding: 60px;
            text-align: center;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 10px 25px rgba(214, 51, 132, 0.05);
        }

        .fund-icon {
            width: 150px;
            height: auto;
            margin-bottom: 25px;
        }

        .amount-display {
            font-size: 4em;
            font-weight: 800;
            color: var(--charcoal);
            margin: 10px 0;
            font-family: 'Monaco', monospace;
        }

        .currency-label {
            font-size: 0.5em;
            vertical-align: middle;
            margin-right: 10px;
            color: var(--magenta-text);
        }

        .fund-label {
            font-size: 1.5em;
            font-weight: 700;
            color: var(--charcoal);
            letter-spacing: 1px;
        }

        .campaign-summary {
            width: 100%;
            margin-top: 35px;
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(214, 51, 132, 0.05);
        }

        .campaign-summary table {
            width: 100%;
            border-collapse: collapse;
        }

        .campaign-summary th {
            background-color: #fff0f3;
            color: var(--magenta-text);
            padding: 18px;
            text-align: center;
            font-weight: 800;
        }

        .campaign-summary td {
            padding: 16px;
            text-align: center;
            border-top: 1px solid var(--border-pink);
        }

        .amount-raised {
            font-weight: 800;
            color: var(--magenta-text);
        }

        .progress-wrap {
            width: 100%;
            height: 10px;
            background-color: #ffeaf1;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: var(--magenta-text);
            border-radius: 999px;
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
<%@ include file="FundraiserSidebar.jsp" %>
<header>
    <div class="logo">
      
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
        
    </div>

    <div class="header-center">TOTAL FUND DONATED</div>

    
</header>

<div class="container">
    <div class="fund-card">
        <img src="https://cdn-icons-png.flaticon.com/512/2454/2454282.png" alt="Fund Jar" class="fund-icon">

        <div class="amount-display">
            <span class="currency-label">RM</span><span id="totalFund">0</span>
        </div>

        <div class="fund-label">Total Fund Raised</div>
    </div>

    <div class="campaign-summary">
        <table>
            <thead>
                <tr>
                    <th>Campaign</th>
                    <th>Goal Fund</th>
                    <th>Amount Raised</th>
                    <th>Progress</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
            <%
                if (campaignList != null && !campaignList.isEmpty()) {
                    for (Campaign c : campaignList) {
                        double progress = 0;

                        if (c.getAmountGoal() > 0) {
                            progress = (c.getAmountRaised() / c.getAmountGoal()) * 100;
                        }

                        if (progress > 100) {
                            progress = 100;
                        }
            %>
                <tr>
                    <td><%= c.getTitle() %></td>
                    <td>RM <%= String.format("%.2f", c.getAmountGoal()) %></td>
                    <td class="amount-raised">RM <%= String.format("%.2f", c.getAmountRaised()) %></td>
                    <td>
                        <div class="progress-wrap">
                            <div class="progress-fill" style="width: <%= progress %>%;"></div>
                        </div>
                    </td>
                    <td><%= c.getStatus() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5">No campaign fund records found.</td>
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
    function animateValue(id, start, end, duration) {
        var obj = document.getElementById(id);
        var range = end - start;

        if (range === 0) {
            obj.innerHTML = end.toLocaleString(undefined, {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
            return;
        }

        var startTime = null;

        function step(timestamp) {
            if (!startTime) {
                startTime = timestamp;
            }

            var progress = Math.min((timestamp - startTime) / duration, 1);
            var current = start + (range * progress);

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

    window.onload = function() {
        animateValue("totalFund", 0, <%= totalFund %>, 1500);
    };
</script>

</body>
</html>