<%-- 
    Document   : ManagerReportChatbot
    Created on : 1 Jul 2026, 1:46:07 AM
    Author     : farajuhaimi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
    .report-chatbot {
        position: fixed;
        right: 28px;
        bottom: 90px;
        width: 330px;
        background: white;
        border: 2px solid #ffdae9;
        border-radius: 20px;
        box-shadow: 0 18px 40px rgba(214, 51, 132, 0.18);
        z-index: 1000;
        overflow: hidden;
        font-family: 'Inter', sans-serif;
    }

    .chatbot-header {
        background: #ffd1dc;
        color: #333;
        padding: 15px 18px;
        font-weight: 900;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .chatbot-body {
        padding: 15px;
        max-height: 260px;
        overflow-y: auto;
        background: #fff8fa;
    }

    .chat-msg {
        padding: 10px 12px;
        border-radius: 14px;
        margin-bottom: 10px;
        font-size: 0.9em;
        line-height: 1.4;
    }

    .bot-msg {
        background: white;
        border: 1px solid #ffdae9;
        color: #555;
    }

    .user-msg {
        background: #d63384;
        color: white;
        margin-left: 35px;
    }

    .chatbot-actions {
        display: grid;
        grid-template-columns: 1fr;
        gap: 8px;
        padding: 12px 15px;
        background: white;
        border-top: 1px solid #ffdae9;
    }

    .chatbot-actions button {
        border: 1px solid #ffbfd5;
        background: #fff0f5;
        color: #d63384;
        border-radius: 999px;
        padding: 10px 12px;
        font-weight: 800;
        cursor: pointer;
        transition: 0.25s;
    }

    .chatbot-actions button:hover {
        background: #d63384;
        color: white;
    }

    .chatbot-input {
        display: flex;
        gap: 8px;
        padding: 12px 15px 15px;
        background: white;
    }

    .chatbot-input input {
        flex: 1;
        border: 1px solid #ffdae9;
        border-radius: 999px;
        padding: 10px 12px;
        outline: none;
    }

    .chatbot-input button {
        border: none;
        background: #d63384;
        color: white;
        border-radius: 999px;
        padding: 10px 14px;
        font-weight: 800;
        cursor: pointer;
    }
</style>

<div class="report-chatbot">
    <div class="chatbot-header">
        Report Assistant
        <span>AI</span>
    </div>

    <div class="chatbot-body" id="chatbotBody">
        <div class="chat-msg bot-msg">
            Hi manager. You can ask me to list reports or export a report.
        </div>
    </div>

    <div class="chatbot-actions">
        <button type="button" onclick="chatbotListReports()">List All Reports</button>
        <button type="button" onclick="chatbotExportFund()">Export Fund Report</button>
        <button type="button" onclick="chatbotExportCampaign()">Export Campaign Report</button>
    </div>

    <div class="chatbot-input">
        <input type="text" id="chatbotInput" placeholder="Type: list report / export fund">
        <button type="button" onclick="chatbotSend()">Send</button>
    </div>
</div>

<script>
    function addChatMessage(text, type) {
        var body = document.getElementById("chatbotBody");
        var msg = document.createElement("div");
        msg.className = "chat-msg " + type;
        msg.innerHTML = text;
        body.appendChild(msg);
        body.scrollTop = body.scrollHeight;
    }

    function chatbotListReports() {
        addChatMessage("List all reports", "user-msg");
        addChatMessage(
            "Available reports:<br>1. Fund Donation Report<br>2. Active Campaign Report<br><br>You can click export buttons below.",
            "bot-msg"
        );
    }

    function chatbotExportFund() {
        addChatMessage("Export fund report", "user-msg");
        addChatMessage("Okay, exporting Fund Donation Report.", "bot-msg");

        if (typeof exportFundReport === "function") {
            exportFundReport();
        } else {
            sessionStorage.setItem("pendingExport", "fund");
            window.location = "ViewFundReports.jsp";
        }
    }

    function chatbotExportCampaign() {
        addChatMessage("Export campaign report", "user-msg");
        addChatMessage("Okay, exporting Active Campaign Report.", "bot-msg");

        if (typeof exportCampaignReport === "function") {
            exportCampaignReport();
        } else {
            sessionStorage.setItem("pendingExport", "campaign");
            window.location = "ViewCampaignReports.jsp";
        }
    }

    function chatbotSend() {
        var input = document.getElementById("chatbotInput");
        var text = input.value.trim().toLowerCase();

        if (text === "") {
            return;
        }

        addChatMessage(input.value, "user-msg");
        input.value = "";

        if (text.includes("list")) {
            chatbotListReports();
        } else if (text.includes("fund")) {
            chatbotExportFund();
        } else if (text.includes("campaign")) {
            chatbotExportCampaign();
        } else {
            addChatMessage("I can help with: list reports, export fund report, or export campaign report.", "bot-msg");
        }
    }
</script>
</html>
