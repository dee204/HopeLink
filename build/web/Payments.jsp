<%-- 
    Document   : Payments
    Created on : 31 Dec 2025, 9:52:05 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DonationDAO,model.Donation,java.util.*"%>
<!DOCTYPE html>
<%
    // ===== HANDLE MESSAGES =====
 
    String paymentMsg = request.getParameter("payment");

    // ===== FETCH DATA =====
    List<Donation> list = DonationDAO.getAllDonations();
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Payment Forms</title>
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
            max-width: 600px;
            margin: 60px auto 120px auto;
            padding: 40px;
            background: white;
            border-radius: 25px; 
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
/* --- Uniform Style for Input AND Select --- */
        input, select {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--border-pink);
            border-radius: 18px; /* High rounding for cute look */
            background-color: var(--light-pink-bg);
            font-size: 1em;
            font-family: 'Quicksand', sans-serif;
            color: var(--charcoal);
            box-sizing: border-box; 
            transition: all 0.3s ease;
            appearance: none; /* Removes default arrow for custom styling */
        }

        /* Adding a custom arrow for the select dropdown */
        .select-wrapper {
            position: relative;
        }
        .select-wrapper::after {
            content: '▼';
            font-size: 0.8em;
            color: var(--magenta-accent);
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--input-focus);
            background-color: white;
            box-shadow: 0 0 10px rgba(251, 194, 235, 0.5);
        }
/* --- Button Style --- */
        .btn-update {
            margin-top: 25px;
            width: 100%;
            background: linear-gradient(135deg, var(--button-pink) 0%, #ff85a1 100%);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 50px; 
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
<%@ include file="DonorSidebar.jsp" %>
    <header>
        <div class="logo">
          
                <img src="HopeLinkLogo.png" alt="HopeLink Logo">
            
        </div>
        <div class="header-center">PAYMENT</div>
       
    </header>

    <div class="container">
        <% if("success".equals(paymentMsg)) { %>
            <div class="alert alert-success">
                ✅ Payment Successful! Thank you for your donation.
            </div>
        <% } %>
        <h2>Enter Payment Details</h2>
        
        <form action="DonateServlet" method="post">

    <input type="hidden" name="campaignId" value="<%= request.getParameter("campaignId") %>">
    <input type="hidden" name="campaignTitle" value="<%= request.getParameter("campaignTitle") %>">

    <div class="form-group">
        <label>Full Name:</label>
        <input type="text" name="donorName" required>
    </div>

    <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" required>
    </div>

    <div class="form-group">
        <label>Phone Number:</label>
        <input type="text" name="phoneNo" required>
    </div>

    <div class="form-group">
        <label>Amount:</label>
        <input type="number" step="0.01" name="amount" required>
    </div>

    <div class="form-group">
        <label>Payment Method:</label>
        <select name="method" required>
            <option value="">Select</option>
            <option value="ToyyibPay">ToyyibPay</option>
        </select>
    </div>

    <button type="submit" class="btn-update">
        Pay Now
    </button>

</form>
    </div>

    <footer>
        <p>© 2026 Fundraising Platform. All rights reserved</p>
    </footer>

</body>
</html>



