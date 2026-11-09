
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,util.HtmlUtil" %>
<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("admin-login.jsp");
    return;
}
List<Map<String,Object>> rows =
    (List<Map<String,Object>>)request.getAttribute("queries");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#124d86">
<title>Customer Care Inbox - Car Rental Portal</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261012">

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
}

.top {
    width: 100%;
    background: linear-gradient(120deg,#0a3159,#1768ad);
    color: #fff;
    overflow: visible;
}

.support-header {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 18px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    flex-wrap: wrap;
}

.support-brand {
    display: block;
    flex: 0 1 auto;
    min-width: 0;
    max-width: 100%;
    color: #fff;
    font-size: clamp(20px,3vw,28px);
    font-weight: 700;
    line-height: 1.4;
    white-space: normal;
    overflow-wrap: anywhere;
}

.support-admin {
    flex: 0 0 auto;
    color: #fff;
    font-size: 15px;
}

nav {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    padding: 12px 20px;
}

nav a {
    display: inline-block;
    padding: 10px 13px;
    text-decoration: none;
    border-radius: 7px;
}

main.wrap {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px 20px;
}

.inbox-hero {
    background: linear-gradient(125deg,#0a3159,#1768ad);
    color: #fff;
    padding: 30px;
    border-radius: 18px;
    margin-bottom: 22px;
}

.inbox-hero h1 {
    margin-top: 0;
    overflow-wrap: anywhere;
}

.inbox-grid {
    display: grid;
    grid-template-columns: repeat(2,minmax(0,1fr));
    gap: 18px;
}

.inbox-card {
    min-width: 0;
    padding: 22px;
    background: #fff;
    border: 1px solid #e1e8f0;
    border-radius: 15px;
    box-shadow: 0 10px 26px #1938580b;
}

.inbox-card h2 {
    overflow-wrap: anywhere;
}

.inbox-meta {
    color: #66758b;
    font-size: .9rem;
    line-height: 1.7;
    overflow-wrap: anywhere;
}

.inbox-message {
    white-space: pre-wrap;
    overflow-wrap: anywhere;
    line-height: 1.65;
    background: #f6f9fc;
    border-radius: 10px;
    padding: 13px;
}

.inbox-card label {
    display: block;
    margin: 12px 0 6px;
    font-weight: 600;
}

.inbox-card textarea,
.inbox-card select {
    display: block;
    width: 100%;
    max-width: 100%;
    padding: 12px;
    border: 1px solid #ccd6e2;
    border-radius: 8px;
    font: inherit;
}

.inbox-card button {
    width: 100%;
    margin-top: 12px;
    padding: 12px;
    border: 0;
    border-radius: 8px;
    background: #124d86;
    color: #fff;
    font-size: 15px;
    cursor: pointer;
}

.inbox-empty {
    background: #fff;
    border: 1px solid #e1e8f0;
    border-radius: 15px;
    padding: 30px;
}

@media(max-width:780px) {
    .inbox-grid {
        grid-template-columns: minmax(0,1fr);
    }

    .inbox-hero {
        padding: 22px;
    }
}

@media(max-width:480px) {
    .support-header {
        padding: 14px 12px;
        align-items: flex-start;
    }

    .support-brand {
        font-size: 20px;
    }

    .support-admin {
        font-size: 14px;
    }

    nav {
        padding: 10px;
        gap: 4px;
    }

    nav a {
        padding: 9px;
        font-size: 13px;
    }

    main.wrap {
        padding: 16px 12px;
    }

    .inbox-card {
        padding: 16px;
    }
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head>

<body>

<header class="top">
    <div class="support-header">
        <strong class="support-brand">🚗 Car Rental Portal</strong>
        <span class="support-admin">Administrator</span>
    </div>
</header>

<nav aria-label="Admin navigation">
    <a href="admin/dashboard.jsp">Dashboard</a>
    <a href="admin/manageCars.jsp">Manage Cars</a>
    <a href="admin/manageBookings.jsp">Bookings</a>
    <a href="admin/manageUsers.jsp">Users</a>
    <a href="admin/reports.jsp">Reports</a>
    <a class="active" href="admin-support">Customer Care Inbox</a>
    <a href="logout">Logout</a>
</nav>

<main class="wrap">

    <section class="inbox-hero">
        <h1>Customer Care Inbox</h1>
        <p>Review customer questions, reply to requests, and keep ticket statuses up to date.</p>
    </section>

    <% if(rows==null || rows.isEmpty()) { %>

    <section class="inbox-empty">
        <h2>All clear</h2>
        <p>There are no customer support requests at the moment.</p>
    </section>

    <% } else { %>

    <section class="inbox-grid">

        <% for(Map<String,Object> x:rows) { %>

        <article class="inbox-card">

            <div class="inbox-meta">
                <strong>Request #<%=x.get("query_id")%></strong>
                · <%=HtmlUtil.escape(String.valueOf(x.get("created_at")))%>
                <br>
                From: <%=HtmlUtil.escape(String.valueOf(x.get("full_name")))%>
                · <%=HtmlUtil.escape(String.valueOf(x.get("email")))%>
            </div>

            <h2><%=HtmlUtil.escape(String.valueOf(x.get("subject")))%></h2>

            <p class="inbox-message"><%=HtmlUtil.escape(String.valueOf(x.get("message")))%></p>

            <form method="post" action="<%=request.getContextPath()%>/admin-support">

                <input type="hidden" name="queryId" value="<%=x.get("query_id")%>">

                <label for="reply-<%=x.get("query_id")%>">Reply to customer</label>

                <textarea id="reply-<%=x.get("query_id")%>"
                          name="reply"
                          rows="5"
                          maxlength="3000"
                          required><%=HtmlUtil.escape(x.get("admin_reply")==null ? "" : String.valueOf(x.get("admin_reply")))%></textarea>

                <label for="status-<%=x.get("query_id")%>">Request status</label>

                <select id="status-<%=x.get("query_id")%>" name="status">
                    <option value="Open" <%= "Open".equals(x.get("status")) ? "selected" : "" %>>Open</option>
                    <option value="In Progress" <%= "In Progress".equals(x.get("status")) ? "selected" : "" %>>In Progress</option>
                    <option value="Answered" <%= "Answered".equals(x.get("status")) ? "selected" : "" %>>Answered</option>
                    <option value="Closed" <%= "Closed".equals(x.get("status")) ? "selected" : "" %>>Closed</option>
                </select>

                <button type="submit">Save Reply &amp; Status</button>

            </form>

        </article>

        <% } %>

    </section>

    <% } %>

</main>

</body>
</html>
