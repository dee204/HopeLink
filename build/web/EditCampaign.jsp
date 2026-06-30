<%-- 
    Document   : EditCampaign
    Created on : 16 Jan 2026, 8:30:50 PM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CampaignDAO,model.Campaign"%>

<%
int id = Integer.parseInt(request.getParameter("id"));
Campaign c = CampaignDAO.getCampaignById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HopeLink | Edit Campaign</title>

<style>
:root {
    --pink-theme:#ffd1dc;
    --soft-white:#fef9f9;
    --charcoal:#333;
    --magenta:#d63384;
    --light-pink:#fff0f5;
    --border-pink:#ffdae9;
    --btn-pink:#ffb6c1;
}

body{
    font-family:'Inter',sans-serif;
    background:var(--soft-white);
    margin:0;
}

/* HEADER */
header{
    display:grid;
    grid-template-columns:1fr 2fr 1fr;
    align-items:center;
    padding:0 60px;
    background:var(--pink-theme);
    height:100px;
}

.logo img{
    height:100px;
    filter:drop-shadow(0 4px 6px rgba(0,0,0,.15));
}

/* FORM CARD */
.container{
    max-width:600px;
    margin:60px auto 120px;
    background:white;
    padding:40px;
    border-radius:25px;
    border:2px solid var(--border-pink);
    box-shadow:0 15px 35px rgba(214,51,132,.1);
}

h2{
    color:var(--magenta);
    text-align:center;
}

label{
    font-weight:700;
    color:#666;
}

input{
    width:100%;
    padding:14px;
    margin-top:8px;
    border-radius:15px;
    border:2px solid var(--border-pink);
    background:var(--light-pink);
}

.btn{
    width:100%;
    margin-top:25px;
    background:var(--btn-pink);
    color:white;
    padding:15px;
    border:none;
    border-radius:50px;
    font-weight:800;
    cursor:pointer;
}

.btn:hover{
    background:var(--magenta);
}

/* FOOTER */
footer{
    background:var(--pink-theme);
    text-align:center;
    padding:20px;
    position:fixed;
    bottom:0;
    width:100%;
}
</style>
</head>

<body>
<%@ include file="FundraiserSidebar.jsp" %>
<header>
    <div class="logo">
    
            <img src="HopeLinkLogo.png">
      
    </div>
    <div style="text-align:center;font-weight:700;font-size:1.4em;">
        EDIT CAMPAIGN
    </div>
    <div></div>
</header>

<div class="container">

<h2>Edit Campaign Details</h2>

<form action="CampaignServlet" method="POST" enctype="multipart/form-data">

<input type="hidden" name="action" value="update">
<input type="hidden" name="id" value="<%=c.getCampaignId()%>">

<label>Campaign Title</label>
<input type="text" name="title" value="<%=c.getTitle()%>" required>

<label>Description</label>
<input type="text" name="description" value="<%=c.getDescription()%>" required>

<label>Organization</label>
<input type="text" name="orgName" value="<%=c.getOrgName()%>" required>

<label>Amount Goal (RM):</label>
<input type="text" name="amount" value="<%=c.getAmountGoal()%>" required>



<label>Change Image</label>
<input type="file" name="campaignImage" accept="image/*">
<button class="btn">Update Campaign</button>

</form>

</div>

<footer>
<p>© 2026 Fundraising Platform. All rights reserved</p>
</footer>

</body>
</html>

