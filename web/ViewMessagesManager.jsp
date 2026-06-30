<%-- 
    Document   : ViewMessages
    Created on : 31 Dec 2025, 7:22:20 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NotificationDAO"%>
<%@page import="java.util.*"%>
<%@ page import="model.User" %>
<%
    String filter = request.getParameter("filter");

    if (filter == null || filter.trim().equals("")) {
        filter = "ALL";
    }

    List<Map<String, String>> notifications;

    if ("READ".equalsIgnoreCase(filter)) {
        notifications = NotificationDAO.getNotificationsByRoleAndStatus("MANAGER", "READ");
    } else if ("UNREAD".equalsIgnoreCase(filter)) {
        notifications = NotificationDAO.getNotificationsByRoleAndStatus("MANAGER", "UNREAD");
    } else {
        notifications = NotificationDAO.getNotificationsByRole("MANAGER");
        filter = "ALL";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Notifications</title>
    <style>
        :root {
            --pink-theme: #ffd1dc;
            --soft-white: #fef9f9;
            --charcoal: #333333;
            --magenta-accent: #d63384;
            --light-pink-bg: #fff0f5;
            --border-pink: #ffdae9;
            --button-pink: #ffb6c1;
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
            max-width: 900px;
            margin: 50px auto 120px auto;
            padding: 30px;
            background: white;
            border-radius: 20px;
            border: 2px solid var(--border-pink);
            box-shadow: 0 10px 25px rgba(214, 51, 132, 0.05);
        }

        .filter-section {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-pink);
            font-weight: 600;
        }

        .filter-option {
            display: flex;
            align-items: center;
            cursor: pointer;
            gap: 8px;
        }

        .filter-option input[type="radio"] {
            accent-color: var(--magenta-accent);
            width: 18px;
            height: 18px;
        }

        .notification-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .notification-item {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notif-card {
            flex-grow: 1;
            padding: 20px;
            background-color: var(--light-pink-bg);
            border: 1px solid var(--border-pink);
            border-radius: 12px;
            font-size: 0.95em;
            color: #555;
            min-height: 25px;
            transition: transform 0.2s ease;
        }

        .notif-card:hover {
            transform: translateX(5px);
        }

        .status-read {
            color: #28a745;
            font-weight: bold;
        }

        .status-unread {
            color: #d63384;
            font-weight: bold;
        }

        .btn-mark-read {
            background-color: var(--button-pink);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(255, 182, 193, 0.4);
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .btn-mark-read:hover {
            background-color: var(--magenta-accent);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(214, 51, 132, 0.3);
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
<%@ include file="ManagerSidebar.jsp" %>
<header>
    <div class="logo">
    
            <img src="HopeLinkLogo.png" alt="HopeLink Logo">
    </div>

    <div class="header-center">NOTIFICATIONS AND UPDATES</div>

    <div class="header-right">
        
    </div>
</header>

<div class="container">
    <h3 style="color: var(--magenta-accent); margin-top: 0;">Filter:</h3>

    <form method="get" action="ViewMessages.jsp">
        <div class="filter-section">
            <label class="filter-option">
                <input type="radio" name="filter" value="ALL"
                       onchange="this.form.submit()"
                       <%= "ALL".equalsIgnoreCase(filter) ? "checked" : "" %>>
                All
            </label>

            <label class="filter-option">
                <input type="radio" name="filter" value="READ"
                       onchange="this.form.submit()"
                       <%= "READ".equalsIgnoreCase(filter) ? "checked" : "" %>>
                Read
            </label>

            <label class="filter-option">
                <input type="radio" name="filter" value="UNREAD"
                       onchange="this.form.submit()"
                       <%= "UNREAD".equalsIgnoreCase(filter) ? "checked" : "" %>>
                Unread
            </label>
        </div>
    </form>

    <div class="notification-list">
        <% if (notifications != null && !notifications.isEmpty()) {
            for (Map<String, String> n : notifications) {
                String status = n.get("status");
        %>

            <div class="notification-item">
                <div class="notif-card">
                    <strong><%= n.get("type") %></strong><br>
                    <%= n.get("message") %><br>
                    <small>
                        <%= n.get("createdAt") %> |
                        <span class="<%= "READ".equalsIgnoreCase(status) ? "status-read" : "status-unread" %>">
                            <%= status %>
                        </span>
                    </small>
                </div>

                <% if ("UNREAD".equalsIgnoreCase(status)) { %>
                    <form action="NotificationServlet" method="post">
                        <input type="hidden" name="notificationId" value="<%= n.get("id") %>">
                        <input type="hidden" name="filter" value="<%= filter %>">
                        <input type="hidden" name="returnPage" value="ViewMessages.jsp">
                        <button type="submit" class="btn-mark-read">Mark as read</button>
                    </form>
                <% } %>
            </div>

        <%  }
        } else { %>

            <div class="notification-item">
                <div class="notif-card">
                    No notifications available.
                </div>
            </div>

        <% } %>
    </div>
</div>

<footer>
    <p>&copy; 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>