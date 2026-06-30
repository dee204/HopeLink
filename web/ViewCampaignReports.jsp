<%-- 
    Document   : ViewCampaignReports
    Created on : 31 Dec 2025, 7:21:51 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO"%>
<%@page import="model.Campaign"%>
<%@page import="java.util.List"%>
<%@ page import="model.User" %>
<%
    List<Campaign> campaignList = CampaignDAO.getApprovedCampaigns();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Active Campaign Report</title>
    <style>
        :root {
            --primary-accent: #F2D3BC; 
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
            --table-header-bg: #fff0f3;
            --row-hover: #fff8f9;
            --border-radius: 15px;
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
            max-width: 1250px;
            margin: 60px auto 120px auto;
            padding: 25px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .report-top {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .report-summary {
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 15px;
            padding: 16px 24px;
            font-weight: 800;
            color: var(--magenta-text);
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
        }

        .export-btn {
            background: var(--magenta-text);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 22px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.15);
        }

        .export-btn:hover {
            background: #b82b70;
        }

        .table-card {
            width: 100%;
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            border: 2px solid var(--border-pink);
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: var(--table-header-bg);
            color: var(--magenta-text);
            padding: 18px;
            font-size: 1em;
            font-weight: 700;
            border-bottom: 1px solid var(--border-pink);
            text-align: center;
        }

        td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid var(--border-pink);
            font-size: 0.95em;
            color: #555;
        }

        tr:hover td {
            background-color: var(--row-hover);
        }

        .amount {
            color: var(--magenta-text);
            font-weight: 800;
        }

        footer {
            background-color: var(--pink-theme);
            text-align: center;
            padding: 20px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        @media print {
    .manager-sidebar,
    header,
    footer,
    .export-btn,
    .report-chatbot,
    .chatbot-header,
    .chatbot-body,
    .chatbot-actions,
    .chatbot-input {
        display: none !important;
    }

    body {
        padding-left: 0 !important;
        margin: 0 !important;
        background: white !important;
        color: black !important;
        font-family: Arial, sans-serif !important;
    }

    .container {
        max-width: none !important;
        width: 100% !important;
        margin: 0 !important;
        padding: 20px !important;
        box-sizing: border-box !important;
    }

    .report-top {
        display: block !important;
        margin-bottom: 15px !important;
    }

    .total-box,
    .report-summary {
        border: none !important;
        box-shadow: none !important;
        background: white !important;
        color: black !important;
        padding: 0 0 12px 0 !important;
        font-size: 16px !important;
        font-weight: bold !important;
    }

    .chart-card {
        display: none !important;
    }

    .table-card {
        width: 100% !important;
        border: none !important;
        box-shadow: none !important;
        border-radius: 0 !important;
        overflow: visible !important;
        background: white !important;
    }

    table {
        width: 100% !important;
        border-collapse: collapse !important;
        font-size: 12px !important;
        color: black !important;
    }

    th {
        background: white !important;
        color: black !important;
        border: 1px solid black !important;
        padding: 8px !important;
        font-weight: bold !important;
        text-align: center !important;
    }

    td {
        background: white !important;
        color: black !important;
        border: 1px solid black !important;
        padding: 8px !important;
        text-align: center !important;
    }

    tr:hover td {
        background: white !important;
    }

    .amount {
        color: black !important;
        font-weight: normal !important;
    }

    a {
        color: black !important;
        text-decoration: none !important;
    }

    @page {
        size: A4 landscape;
        margin: 12mm;
    }
}

            body {
                background: white;
            }

            .container {
                margin: 20px auto;
                padding: 0;
            }

            .table-card,
            .report-summary {
                box-shadow: none;
            }
        
    </style>
</head>

<body>
<%@ include file="ManagerSidebar.jsp" %>
<header>
    <div class="logo">
       
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
    </div>

    <div class="header-center">ACTIVE CAMPAIGN REPORT</div>

    <div class="header-right">
        
    </div>
</header>

<div class="container">

    <div class="report-top">
        <div class="report-summary">
            Total Active Campaigns: <%= campaignList != null ? campaignList.size() : 0 %>
        </div>

       <button class="export-btn" onclick="exportCampaignReport()">
    Export Report
</button>
    </div>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Campaign ID</th>
                    <th>Organization</th>
                    <th>Campaign Title</th>
                    <th>Description</th>
                    <th>Goal Fund</th>
                    <th>Amount Raised</th>
                    <th>Status</th>
                    <th>Created At</th>
                </tr>
            </thead>

            <tbody>
                <% if (campaignList != null && !campaignList.isEmpty()) {
                    for (Campaign c : campaignList) { %>

                    <tr>
                        <td>C-<%= c.getCampaignId() %></td>
                        <td><%= c.getOrgName() %></td>
                        <td><%= c.getTitle() %></td>
                        <td><%= c.getDescription() %></td>
                        <td class="amount">RM <%= String.format("%.2f", c.getAmountGoal()) %></td>
                        <td class="amount">RM <%= String.format("%.2f", c.getAmountRaised()) %></td>
                        <td><%= c.getStatus() %></td>
                        <td><%= c.getCreatedAt() %></td>
                    </tr>

                <%  }
                } else { %>

                    <tr>
                        <td colspan="8">No active campaign records found.</td>
                    </tr>

                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>
<script>
function exportCampaignReport() {
    window.print();

    setTimeout(function() {
        window.location = "ExportReportServlet?reportType=Active campaign report&returnPage=ViewCampaignReports.jsp";
    }, 1000);
}

window.onload = function() {
    if (sessionStorage.getItem("pendingExport") === "campaign") {
        sessionStorage.removeItem("pendingExport");
        exportCampaignReport();
    }
};
</script>
</body>
</html>