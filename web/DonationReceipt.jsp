<%-- 
    Document   : DonationReceipt
    Created on : 9 Jun 2026, 5:45:06 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonationDAO"%>
<%@page import="model.Donation"%>

<%
    int donationId = Integer.parseInt(request.getParameter("id"));
    Donation d = DonationDAO.getDonationById(donationId);

    if (d == null) {
        response.sendRedirect("DonationHistory.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Donation Receipt</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fef9f9;
            margin: 0;
            padding: 40px;
            color: #333;
        }

        .receipt-card {
            max-width: 720px;
            margin: auto;
            background: white;
            border: 2px solid #ffdae9;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(214, 51, 132, 0.1);
        }

        .receipt-header {
            text-align: center;
            border-bottom: 2px solid #ffdae9;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .receipt-header img {
            height: 90px;
        }

        .receipt-header h1 {
            color: #d63384;
            margin-bottom: 5px;
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            padding: 14px 0;
            border-bottom: 1px solid #ffe6ef;
        }

        .label {
            font-weight: bold;
        }

        .value {
            text-align: right;
        }

        .amount {
            color: #d63384;
            font-size: 1.4em;
            font-weight: bold;
        }

        .thanks {
            text-align: center;
            margin-top: 30px;
            font-weight: bold;
            color: #d63384;
        }

        .button-area {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            margin: 5px;
        }

        .print-btn {
            background: #d63384;
            color: white;
        }

        .back-btn {
            background: #fff0f5;
            color: #d63384;
            border: 1px solid #ffdae9;
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }

            .receipt-card {
                border: none;
                box-shadow: none;
            }

            .button-area {
                display: none;
            }
        }
    </style>
</head>

<body>
<%@ include file="DonorSidebar.jsp" %>
<div class="receipt-card">
    <div class="receipt-header">
        <img src="HopeLinkLogo.png" alt="HopeLink Logo">
        <h1>Donation Receipt</h1>
        <p>Receipt No: R-<%= d.getDonationId() %></p>
    </div>

    <div class="receipt-row">
        <div class="label">Donation ID</div>
        <div class="value">D-<%= d.getDonationId() %></div>
    </div>

    <div class="receipt-row">
        <div class="label">Donor Name</div>
        <div class="value"><%= d.getDonorName() %></div>
    </div>

    <div class="receipt-row">
        <div class="label">Campaign ID</div>
        <div class="value">C-<%= d.getCampaignId() %></div>
    </div>

    <div class="receipt-row">
        <div class="label">Campaign Title</div>
        <div class="value"><%= d.getCampaignTitle() %></div>
    </div>

    <div class="receipt-row">
        <div class="label">Donation Date</div>
        <div class="value"><%= d.getDonationDate() %></div>
    </div>

    <div class="receipt-row">
        <div class="label">Amount Donated</div>
        <div class="value amount">RM <%= String.format("%.2f", d.getAmount()) %></div>
    </div>

    <div class="thanks">
        Thank you for your donation.
    </div>

    <div class="button-area">
        <button class="btn print-btn" onclick="window.print()">Print / Export PDF</button>
        <button class="btn back-btn" onclick="location.href='DonationHistory.jsp'">Back</button>
    </div>
</div>

</body>
</html>