<%-- 
    Document   : ViewListAccounts
    Created on : 31 Dec 2025, 5:35:14 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO, model.User, java.util.List" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | List Registered Account</title>
    <style>
        :root {
            --primary-accent: #F2D3BC; 
            --charcoal: #333333;
            --soft-white: #fef9f9;
            --pink-theme: #ffd1dc;
            /* Aesthetic colors from your screenshot */
            --magenta-text: #d63384; 
            --light-pink-bg: #fff0f5;
            --border-pink: #ffdae9;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        /* --- Header Styling (UNTOUCHED) --- */
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

        /* --- Updated Aesthetic Table Style (Matches Screenshot) --- */
        .container {
            max-width: 1100px;
            margin: 60px auto 120px auto;
            padding: 20px;
        }

        .table-card {
            background-color: white;
            border-radius: 15px; /* Rounded corners like the picture */
            overflow: hidden;
            border: 2px solid var(--border-pink);
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: var(--light-pink-bg);
            color: var(--magenta-text);
            padding: 20px;
            font-size: 1.1em;
            font-weight: 700;
            border-bottom: 1px solid var(--border-pink);
            text-align: center;
        }

        td {
            padding: 18px 15px;
            text-align: center;
            border-bottom: 1px solid var(--border-pink);
            font-size: 1em;
            color: #555;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background-color: #fffafa;
        }

        /* --- Footer (UNTOUCHED) --- */
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
<%@ include file="ManagerSidebar.jsp" %>
    <header>
        <div class="logo">
           
                <img src="HopeLinkLogo.png" alt="HopeLink Logo">
        </div>
        <div class="header-center">LIST REGISTERED ACCOUNT</div>
        <div class="header-right">
           
        </div>
    </header>

    <div class="container">
        <div class="table-card">
              <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<User> users = UserDAO.getAllUsers(); // We need to create this method in DAO
                        for(User u : users){
                    %>
                    <tr>
                        <td><%= u.getUserId() %></td>
                        <td><%= u.getUsername() %></td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getPhoneNo() %></td>
                        <td><%= u.getRole() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>© 2026 Fundraising Platform. All rights reserved</p>
    </footer>

</body>
</html>
