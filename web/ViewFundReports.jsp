<%-- 
    Document   : ViewFundReports
    Created on : 31 Dec 2025, 6:21:42 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonationDAO"%>
<%@page import="model.Donation"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page import="model.User" %>
<%
    List<Donation> donationList = DonationDAO.getAllDonations();

    double grandTotal = 0;
    Map<String, Double> donorTotals = new LinkedHashMap<>();

    if (donationList != null) {
        for (Donation d : donationList) {
            grandTotal += d.getAmount();

            String donorName = d.getDonorName();
            double currentTotal = donorTotals.containsKey(donorName) ? donorTotals.get(donorName) : 0;
            donorTotals.put(donorName, currentTotal + d.getAmount());
        }
    }

    StringBuilder donorLabels = new StringBuilder();
    StringBuilder donorAmounts = new StringBuilder();

    for (Map.Entry<String, Double> entry : donorTotals.entrySet()) {
        String safeName = entry.getKey().replace("\\", "\\\\").replace("'", "\\'");
        donorLabels.append("'").append(safeName).append("',");
        donorAmounts.append(entry.getValue()).append(",");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Total Fund Report</title>

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
            max-width: 1200px;
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

        .total-box {
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 15px;
            padding: 18px 25px;
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

        .chart-card {
            width: 100%;
            background: white;
            border: 2px solid var(--border-pink);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
            box-sizing: border-box;
        }

        .chart-title {
            text-align: center;
            color: var(--magenta-text);
            font-weight: 800;
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        .chart-wrapper {
            max-width: 420px;
            margin: 0 auto;
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
            font-weight: 800;
            color: var(--magenta-text);
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
@media print {
    .chart-card {
        display: none !important;
    }
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
    </style>
</head>

<body>
<%@ include file="ManagerSidebar.jsp" %>

<header>
    <div class="logo">
      
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
        
    </div>

    <div class="header-center">TOTAL FUND REPORT</div>

    <div class="header-right">
        
    </div>
</header>

<div class="container">

    <div class="report-top">
        <div class="total-box">
            Grand Total Fund: RM <%= String.format("%.2f", grandTotal) %>
        </div>

        <button class="export-btn" onclick="exportFundReport()">
            Export Report
        </button>
    </div>

    <div class="chart-card">
        <div class="chart-title">Fund Contribution by Donor</div>

        <% if (donorTotals != null && !donorTotals.isEmpty()) { %>
            <div class="chart-wrapper">
                <canvas id="donorPieChart"></canvas>
            </div>
        <% } else { %>
            <p style="text-align:center;color:#777;">No donor fund data available.</p>
        <% } %>
    </div>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Donation ID</th>
                    <th>Donor Name</th>
                    <th>Campaign ID</th>
                    <th>Campaign Title</th>
                    <th>Donation Date</th>
                    <th>Amount</th>
                </tr>
            </thead>

            <tbody>
                <% if (donationList != null && !donationList.isEmpty()) {
                    for (Donation d : donationList) { %>

                    <tr>
                        <td>DT-<%= d.getDonationId() %></td>
                        <td><%= d.getDonorName() %></td>
                        <td>C-<%= d.getCampaignId() %></td>
                        <td><%= d.getCampaignTitle() %></td>
                        <td><%= d.getDonationDate() %></td>
                        <td class="amount">RM <%= String.format("%.2f", d.getAmount()) %></td>
                    </tr>

                <%  }
                } else { %>

                    <tr>
                        <td colspan="6">No fund records found.</td>
                    </tr>

                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
var donorLabels = [<%= donorLabels.toString() %>];
var donorAmounts = [<%= donorAmounts.toString() %>];

if (document.getElementById("donorPieChart")) {
    new Chart(document.getElementById("donorPieChart"), {
        type: "pie",
        data: {
            labels: donorLabels,
            datasets: [{
                data: donorAmounts,
                backgroundColor: [
                    "#d63384",
                    "#ff85a1",
                    "#ffb3c1",
                    "#ffd1dc",
                    "#f2d3bc",
                    "#b82b70",
                    "#ffdae9",
                    "#c77d9b"
                ],
                borderColor: "#ffffff",
                borderWidth: 3
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "bottom"
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.label + ": RM " + context.raw.toFixed(2);
                        }
                    }
                }
            }
        }
    });
}

function exportFundReport() {
    window.print();

    setTimeout(function() {
        window.location = "ExportReportServlet?reportType=Fund donation report&returnPage=ViewFundReports.jsp";
    }, 1000);
}

window.onload = function() {
    if (sessionStorage.getItem("pendingExport") === "fund") {
        sessionStorage.removeItem("pendingExport");
        exportFundReport();
    }
};
</script>

</body>
</html>