<%-- 
    Document   : DonationHistory
    Created on : 31 Dec 2025, 10:02:40 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonationDAO"%>
<%@page import="model.Donation"%>
<%@page import="java.util.List"%>

<%
    String deleteMsg = request.getParameter("delete");
    List<Donation> list = DonationDAO.getAllDonations();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Donation History</title>

    <style>
        :root {
            --pink-theme: #ffd1dc;
            --soft-white: #fef9f9;
            --charcoal: #333333;
            --magenta-accent: #d63384;
            --table-header-bg: #fff0f5;
            --border-pink: #ffdae9;
            --shadow: 0 15px 35px rgba(214, 51, 132, 0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        header {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 60px;
            background-color: var(--pink-theme);
            height: 100px;
            border-bottom: 1px solid #eee;
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        }

        .header-center {
            text-align: center;
            font-weight: 800;
            font-size: 1.4em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .container {
            max-width: 1100px;
            margin: 60px auto 120px;
            padding: 0 25px;
        }

        .table-card {
            background: white;
            border-radius: 18px;
            border: 2px solid var(--border-pink);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: var(--table-header-bg);
            color: var(--magenta-accent);
            padding: 18px;
            font-size: 1em;
            font-weight: 800;
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
            background: #fff8fa;
        }

        .amount-tag {
            font-weight: 800;
            color: var(--magenta-accent);
        }

        .receipt-btn,
        .delete-btn {
            border: 1px solid var(--border-pink);
            padding: 8px 14px;
            border-radius: 999px;
            cursor: pointer;
            color: #d63384;
            transition: 0.25s;
            font-weight: 700;
            margin: 2px;
            background: #fff0f5;
        }

        .receipt-btn:hover,
        .delete-btn:hover {
            background: #d63384;
            color: white;
            transform: translateY(-2px);
        }

        .alert {
            padding: 14px;
            border-radius: 14px;
            margin: 0 0 20px;
            text-align: center;
            font-weight: 700;
        }

        .alert-delete {
            background: #ffe6ea;
            color: #d63384;
            border: 1px solid var(--border-pink);
        }

        footer {
            background: var(--pink-theme);
            text-align: center;
            padding: 20px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>

<body>

<%@ include file="DonorSidebar.jsp" %>

<header>
    <div class="header-center">DONATION HISTORY</div>
</header>

<div class="container">
    <% if ("success".equals(deleteMsg)) { %>
        <div class="alert alert-delete">
            Donation deleted successfully.
        </div>
    <% } %>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Donor Name</th>
                    <th>Amount</th>
                    <th>Campaign Title</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                <% if (list != null && !list.isEmpty()) {
                    for (Donation d : list) { %>

                    <tr>
                        <td><%= d.getDonorName() %></td>
                        <td class="amount-tag">RM <%= String.format("%.2f", d.getAmount()) %></td>
                        <td><%= d.getCampaignTitle() %></td>
                        <td><%= d.getDonationDate() %></td>
                        <td>
                            <a href="DonationReceipt.jsp?id=<%= d.getDonationId() %>">
                                <button type="button" class="receipt-btn">Receipt</button>
                            </a>

                            <a href="DeleteDonationServlet?id=<%= d.getDonationId() %>"
                               onclick="return confirm('Delete this donation?');">
                                <button type="button" class="delete-btn">Delete</button>
                            </a>
                        </td>
                    </tr>

                <% }
                } else { %>

                    <tr>
                        <td colspan="5">No donation records found.</td>
                    </tr>

                <% } %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    &copy; 2026 Fundraising Platform
</footer>

</body>
</html>