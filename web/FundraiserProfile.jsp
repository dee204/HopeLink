<%-- 
    Document   : FundraiserProfile
    Created on : 31 Dec 2025, 7:34:16 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
User u=(User)session.getAttribute("user");
if(u==null){
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Edit Profile</title>
    <style>
        :root {
            --pink-theme: #ffd1dc;
            --soft-white: #fef9f9;
            --charcoal: #333333;
            --magenta-accent: #d63384;
            --light-pink-bg: #fff0f5;
            --border-pink: #ffdae9;
            --button-pink: #ffb6c1;
            --input-focus: #fbc2eb;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--soft-white);
            color: var(--charcoal);
        }

        /* --- Header (UNTOUCHED) --- */
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

        /* --- Aesthetic Form Styling --- */
        .container {
            max-width: 600px;
            margin: 60px auto 120px auto;
            padding: 40px;
            background: white;
            border-radius: 25px; /* Extra rounded for cute aesthetic */
            border: 2px solid var(--border-pink);
            box-shadow: 0 15px 35px rgba(214, 51, 132, 0.1);
            text-align: center;
        }

        h2 {
            color: var(--magenta-accent);
            margin-bottom: 30px;
            font-size: 1.8em;
            letter-spacing: 1px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: #666;
            font-size: 0.95em;
            padding-left: 5px;
        }

        input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--border-pink);
            border-radius: 15px;
            background-color: var(--light-pink-bg);
            font-size: 1em;
            color: var(--charcoal);
            box-sizing: border-box; /* Ensures padding doesn't affect width */
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--input-focus);
            background-color: white;
            box-shadow: 0 0 10px rgba(251, 194, 235, 0.5);
        }

        /* Cute Aesthetic Button */
        .btn-update {
            margin-top: 20px;
            width: 100%;
            background-color: var(--button-pink);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 50px; /* Pill shape */
            font-weight: 800;
            font-size: 1.1em;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(255, 182, 193, 0.4);
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            background-color: var(--magenta-accent);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.3);
        }

        .btn-update:active {
            transform: translateY(0);
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
        <div class="header-center">USER SETTINGS</div>
      
    </header>

    <div class="container">
        <h2>Edit Your Profile</h2>
        
        <form action="FundraiserUpdateProfileServlet" method="POST">

    <input type="hidden" name="id" value="<%=u.getUserId()%>">

    <div class="form-group">
        <label>Username:</label>
        <input type="text" name="username" 
               value="<%=u.getUsername()%>" required>
    </div>

    <div class="form-group">
        <label>Password:</label>
        <input type="password" name="password" 
               value="<%=u.getPassword()%>" required>
    </div>

    <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" 
               value="<%=u.getEmail()%>" required>
    </div>

    <div class="form-group">
        <label>Phone Number:</label>
        <input type="text" name="phoneNo" 
               value="<%=u.getPhoneNo()%>" required>
    </div>

    <button type="submit" class="btn-update">
        Update Profile
    </button>

</form>
    </div>

    <footer>
        <p>© 2026 Fundraising Platform. All rights reserved</p>
    </footer>

</body>
</html>
