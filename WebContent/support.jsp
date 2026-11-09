
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,util.HtmlUtil" %>
<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}
List<Map<String,Object>> queries =
    (List<Map<String,Object>>)request.getAttribute("queries");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#124d86">
<title>Customer Care Support - Car Rental Portal</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261012">

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    color: #203047;
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

.support-label {
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

.support-hero {
    background: linear-gradient(125deg,#0a3159,#1768ad);
    color: #fff;
    padding: clamp(24px,5vw,42px);
    border-radius: 20px;
    margin-bottom: 22px;
    box-shadow: 0 16px 34px #123b6d20;
}

.support-hero .eyebrow {
    font-size: .78rem;
    letter-spacing: .14em;
    font-weight: 800;
    opacity: .85;
}

.support-hero h1 {
    margin: 8px 0;
    font-size: clamp(28px,5vw,44px);
    line-height: 1.2;
    overflow-wrap: anywhere;
}

.support-hero p {
    line-height: 1.7;
    max-width: 760px;
}

.support-grid {
    display: grid;
    grid-template-columns: minmax(0,1.05fr) minmax(0,.95fr);
    gap: 20px;
    align-items: start;
}

.support-card {
    min-width: 0;
    background: #fff;
    border: 1px solid #e4ebf3;
    border-radius: 16px;
    padding: clamp(18px,3vw,26px);
    box-shadow: 0 10px 26px #1938580b;
    margin: 16px 0;
}

.support-card h2,
.support-card h3 {
    overflow-wrap: anywhere;
}

.support-card h2 {
    margin-top: 0;
}

.support-form label {
    display: block;
    margin: 14px 0 6px;
    font-weight: 600;
}

.support-form input,
.support-form textarea {
    display: block;
    width: 100%;
    max-width: 100%;
    padding: 13px;
    border: 1px solid #ccd6e2;
    border-radius: 9px;
    font: inherit;
    background: #fff;
}

.support-form input:focus,
.support-form textarea:focus {
    outline: 2px solid #1768ad;
    outline-offset: 1px;
}

.support-form textarea {
    resize: vertical;
    min-height: 130px;
}

.support-form button {
    width: 100%;
    margin-top: 16px;
    padding: 13px;
    background: #124d86;
    color: #fff;
    border: 0;
    border-radius: 9px;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
}

.support-faq {
    padding: 14px 0;
    border-bottom: 1px solid #e8edf4;
    line-height: 1.6;
}

.support-faq:last-child {
    border-bottom: 0;
}

.support-faq strong {
    display: block;
    margin-bottom: 5px;
}

.support-alert {
    padding: 13px 16px;
    border-radius: 10px;
    background: #eaf8ef;
    color: #17663a;
    margin: 16px 0;
    line-height: 1.6;
}

.support-error {
    background: #fff0ef;
    color: #9d2820;
}

.ticket-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
    color: #68788e;
    font-size: .9rem;
    line-height: 1.6;
}

.ticket-status {
    display: inline-flex;
    padding: 5px 10px;
    border-radius: 999px;
    background: #edf4fb;
    color: #164b7e;
    font-size: .82rem;
    font-weight: 750;
}

.support-message {
    white-space: pre-wrap;
    overflow-wrap: anywhere;
    line-height: 1.7;
}

.support-reply {
    background: #eff8ff;
    border: 1px solid #d5eaff;
    padding: 14px;
    border-radius: 12px;
    margin-top: 14px;
}

.support-empty {
    background: #fff;
    border: 1px solid #e4ebf3;
    border-radius: 16px;
    padding: 24px;
    margin: 16px 0;
}

@media(max-width:760px) {
    .support-grid {
        grid-template-columns: minmax(0,1fr);
    }

    .support-hero {
        padding: 24px;
    }
}

@media(max-width:480px) {
    .support-header {
        padding: 14px 12px;
    }

    .support-brand {
        font-size: 20px;
    }

    .support-label {
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

    .support-card {
        padding: 17px;
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
        <strong class="support-brand">Car Rental Portal</strong>
        <span class="support-label">Customer Care</span>
    </div>
</header>

<nav aria-label="Customer navigation">
    <a href="<%=request.getContextPath()%>/dashboard.jsp">Dashboard</a>
    <a href="<%=request.getContextPath()%>/cars.jsp">View Cars</a>
    <a href="<%=request.getContextPath()%>/bookingHistory.jsp">My Bookings</a>
    <a href="<%=request.getContextPath()%>/payment.jsp">Payments</a>
    <a href="<%=request.getContextPath()%>/profile">Profile</a>
    <a class="active" href="<%=request.getContextPath()%>/support">Customer Support</a>
    <a href="<%=request.getContextPath()%>/logout">Logout</a>
</nav>

<main class="wrap">

    <section class="support-hero">
        <span class="eyebrow">WE'RE HERE TO HELP</span>
        <h1>Customer Care Support</h1>
        <p>Have a question about a booking, payment, cancellation, or rental? Send us a message and track the reply here.</p>
    </section>

    <% if("1".equals(request.getParameter("sent"))) { %>
        <div class="support-alert" role="status">
            Your support request has been submitted. You can track its status below.
        </div>
    <% } %>

    <% if(request.getAttribute("error")!=null) { %>
        <div class="support-alert support-error" role="alert">
            <%=HtmlUtil.escape(String.valueOf(request.getAttribute("error")))%>
        </div>
    <% } %>

    <div class="support-grid">

        <section class="support-card">
            <h2>Submit a Support Request</h2>
            <p>Describe the issue clearly so our team can help you faster.</p>

            <form class="support-form" method="post"
                  action="<%=request.getContextPath()%>/support">

                <label for="subject">Subject</label>
                <input id="subject"
                       name="subject"
                       type="text"
                       maxlength="120"
                       placeholder="e.g. Question about my booking"
                       required>

                <label for="message">How can we help?</label>
                <textarea id="message"
                          name="message"
                          rows="6"
                          maxlength="3000"
                          placeholder="Describe your question. Never share your password or card PIN."
                          required></textarea>

                <button type="submit">Send Support Request</button>
            </form>
        </section>

        <aside class="support-card">
            <h2>Quick Help</h2>

            <div class="support-faq">
                <strong>Booking or car availability</strong>
                <span>Check My Bookings for the latest booking status and details.</span>
            </div>

            <div class="support-faq">
                <strong>Payment or receipt</strong>
                <span>Open Payments or Payment History to review recorded transactions and invoices.</span>
            </div>

            <div class="support-faq">
                <strong>Profile or password</strong>
                <span>Use Profile to review your account details and available password options.</span>
            </div>

            <div class="support-faq">
                <strong>What happens next?</strong>
                <span>Your request appears under My Support Requests. Its status and team reply will be shown here.</span>
            </div>
        </aside>

    </div>

    <section>
        <h2>My Support Requests</h2>
        <p>Track your requests and read replies from the support team.</p>

        <% if(queries==null || queries.isEmpty()) { %>

            <div class="support-empty">
                <h3>No Requests Yet</h3>
                <p>When you submit a support request, it will appear here.</p>
            </div>

        <% } else { %>

            <% for(Map<String,Object> x:queries) {
                Object id = x.get("id") != null ? x.get("id") : x.get("query_id");
                Object created = x.get("created") != null ? x.get("created") : x.get("created_at");
                Object status = x.get("status");
                Object subject = x.get("subject");
                Object message = x.get("message");
                Object reply = x.get("reply") != null ? x.get("reply") : x.get("admin_reply");
            %>

                <article class="support-card">

                    <div class="ticket-meta">
                        <span>
                            Request #<%=HtmlUtil.escape(String.valueOf(id))%>
                            · <%=HtmlUtil.escape(String.valueOf(created))%>
                        </span>
                        <span class="ticket-status">
                            <%=HtmlUtil.escape(String.valueOf(status))%>
                        </span>
                    </div>

                    <h3><%=HtmlUtil.escape(String.valueOf(subject))%></h3>

                    <p class="support-message"><%=HtmlUtil.escape(String.valueOf(message))%></p>

                    <% if(reply!=null && !String.valueOf(reply).isBlank()) { %>

                        <div class="support-reply">
                            <strong>Reply from Customer Care</strong>
                            <p class="support-message"><%=HtmlUtil.escape(String.valueOf(reply))%></p>
                        </div>

                    <% } else { %>

                        <p style="color:#6b7788">Our team has not replied yet.</p>

                    <% } %>

                </article>

            <% } %>

        <% } %>
    </section>

</main>

</body>
</html>
