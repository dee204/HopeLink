<%-- 
    Document   : Register
    Created on : 31 Dec 2025, 1:02:19 PM
    Author     : farajuhaimi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HopeLink | Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&display=swap" rel="stylesheet">
    
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
            --shadow: 0 15px 35px rgba(214, 51, 132, 0.1);
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
            transition: transform 0.3s ease;
        }

        .logo img:hover { transform: scale(1.05); }

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
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--charcoal);
            font-weight: 700;
            font-size: 1.1em;
        }

        /* --- Register Box Styling --- */
        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px 140px 20px;
        }

        .register-box {
            background-color: white;
            padding: 40px;
            border-radius: 30px; /* Aesthetic rounding */
            border: 2px solid var(--border-pink);
            width: 100%;
            max-width: 550px;
            box-shadow: var(--shadow);
            text-align: center;
        }

        h2 {
            color: var(--magenta-accent);
            margin-bottom: 30px;
            font-size: 1.8em;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 0.95em;
            margin-bottom: 8px;
            color: #777;
            padding-left: 10px;
        }

        /* Input and Select Styling to match Payment Form */
        .form-group input, 
        .form-group select {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--border-pink);
            border-radius: 18px;
            background-color: var(--light-pink-bg);
            box-sizing: border-box;
            font-family: 'Quicksand', sans-serif;
            font-size: 1em;
            color: var(--charcoal);
            transition: all 0.3s ease;
        }

        .form-group input:focus, 
        .form-group select:focus {
            outline: none;
            border-color: var(--input-focus);
            background-color: white;
            box-shadow: 0 0 10px rgba(251, 194, 235, 0.5);
        }

        /* --- Submit Button Styling --- */
        .btn-container {
            margin-top: 30px;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--button-pink) 0%, #ff85a1 100%);
            color: white;
            border: none;
            padding: 15px 60px;
            border-radius: 50px; /* Pill shape */
            font-size: 1.1em;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 182, 193, 0.4);
            width: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(214, 51, 132, 0.3);
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

    <header>
        <div class="logo">
            <a href="HomePage.jsp">
                <img src="HopeLinkLogo.png" alt="HopeLink Logo">
            </a>
        </div>

        <div class="header-center">
            ❀ REGISTER YOUR ACCOUNT ❀
        </div>

        <div class="header-right">
            <div class="nav-links">
                <a href="Login.jsp">Login</a>
            </div>
            
        </div>
    </header>

    <div class="main-content">
        <div class="register-box">
            <h2>Join HopeLink ✨</h2>
            <form action="UserServlet" method="POST">
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" placeholder="Choose a username" required>
                </div>
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                </div>
                <div class="form-group">
                    <label>Email Address:</label>
                    <input type="email" name="email" placeholder="example@mail.com" required>
                </div>
                <div class="form-group">
                    <label>Phone Number:</label>
                    <input type="text" name="phoneNo" placeholder="e.g. 012-3456789" required>
                </div>
                <div class="form-group">
                    <label for="role">Account Role:</label>
                    <select id="role" name="role" required>
                        <option value="" disabled selected>Select your role</option>
                        <option value="Fundraiser">Fundraiser</option>
                        <option value="Donor">Donor</option>
                    </select>
                </div>
                
                <div class="btn-container">
                    <button type="submit" class="btn-submit">Register Now</button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>© 2026 Fundraising Platform. All rights reserved</p>
    </footer>

</body>
</html>