<%-- 
    Document   : AllDonations
    Created on : 31 Dec 2025, 8:35:18 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonationDAO"%>
<%@page import="model.Donation"%>
<%@page import="java.util.List"%>

<%
    List<Donation> list = DonationDAO.getAllDonations();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | List All Donations</title>

    <style>
        :root {
            --primary-accent: #F2D3BC; 
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
            --table-header-bg: #fff0f3;
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
            max-width: 1000px;
            margin: 60px auto 140px auto; 
            padding: 0 25px;
        }

        .table-card {
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
            padding: 22px 15px;
            font-size: 1.1em;
            font-weight: 700;
            border-bottom: 2px solid var(--border-pink);
            text-align: center;
        }

        td {
            padding: 20px 15px;
            text-align: center;
            border-bottom: 1px solid var(--border-pink);
            font-size: 1em;
            color: #555;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #fff9fa;
        }

        .amount-tag {
            font-weight: bold;
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
    </style>
</head>

<body>
<%@ include file="FundraiserSidebar.jsp" %>
<header>
    <div class="logo">

            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
       
    </div>

    <div class="header-center">LIST OF ALL DONATIONS</div>

</header>

<div class="container">
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Donor Name</th>
                    <th>Amount</th>
                    <th>Campaign Title</th>
                    <th>Date</th>
                </tr>
            </thead>

            <tbody>
                <% if (list != null && !list.isEmpty()) {
                    for (Donation d : list) { %>

                    <tr>
                        <td><%= d.getDonorName() %></td>
                        <td class="amount-tag">RM <%= d.getAmount() %></td>
                        <td><%= d.getCampaignTitle() %></td>
                        <td><%= d.getDonationDate() %></td>
                    </tr>

                <%  }
                } else { %>

                    <tr>
                        <td colspan="4">No donation records found.</td>
                    </tr>

                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>