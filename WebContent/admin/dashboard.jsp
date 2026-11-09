<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin,dao.AdminDAO" %>
<% if(session.getAttribute("admin")==null || !"ADMIN".equals(session.getAttribute("role"))){response.sendRedirect("../admin-login.jsp");return;} Admin admin=(Admin)session.getAttribute("admin"); AdminDAO stats=new AdminDAO(); int users=stats.countUsers(), cars=stats.countCars(), available=stats.countAvailableCars(), unavailable=stats.countNotAvailableCars(), bookings=stats.countBookings(), completed=stats.countCompletedBookings(), cancelled=stats.countCancelledBookings(); double revenue=stats.totalRevenue(); double availability=cars==0?0:(available*100.0/cars); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Admin Dashboard - Car Rental Portal</title><link rel="stylesheet" href="../css/ui.css">
<link rel="stylesheet" href="../css/responsive.css"><link rel="stylesheet" href="../css/admin.css"><style>
.admin-wrap{width:min(1250px,94%);margin:34px auto 60px}.admin-hero{background:linear-gradient(135deg,#123b6d,#0b294e);color:#fff;border-radius:18px;padding:28px 30px;margin-bottom:22px;box-shadow:0 12px 30px rgba(11,41,78,.18)}.admin-hero h2{margin:0 0 6px;font-size:28px}.admin-hero p{margin:0;opacity:.88}.stat-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px}.stat-card{background:#fff;border:1px solid #e3e8ef;border-radius:15px;padding:20px;box-shadow:0 8px 25px rgba(15,35,60,.08);position:relative;overflow:hidden}.stat-card .label{color:#667085;font-weight:650;font-size:13px}.stat-card .value{font-size:30px;font-weight:800;color:#123b6d;margin:6px 0}.stat-card .hint{font-size:12px;color:#667085}.stat-card .accent{position:absolute;right:-18px;top:-18px;width:70px;height:70px;border-radius:50%;background:#eef5ff}.panel-grid{display:grid;grid-template-columns:1.1fr .9fr;gap:18px;margin-top:18px}.panel{background:#fff;border:1px solid #e3e8ef;border-radius:15px;padding:22px;box-shadow:0 8px 25px rgba(15,35,60,.08)}.panel h3{margin:0 0 16px;color:#123b6d}.bar-row{margin:15px 0}.bar-label{display:flex;justify-content:space-between;font-size:13px;font-weight:650;margin-bottom:7px}.bar{height:10px;background:#edf1f6;border-radius:999px;overflow:hidden}.bar span{display:block;height:100%;background:#2e86df;border-radius:999px}.bar.green span{background:#16834b}.bar.red span{background:#c93636}.quick{display:grid;grid-template-columns:1fr 1fr;gap:10px}.quick a{display:block;padding:13px 14px;border:1px solid #dce3eb;border-radius:10px;color:#123b6d;font-weight:700;background:#fafcff}.quick a:hover{background:#eef5ff}.demo-banner{margin-top:18px;background:#f8fbff;border:1px solid #dceaf8;border-radius:12px;padding:15px 17px;color:#475467;font-size:13px}.demo-banner strong{color:#123b6d}@media(max-width:900px){.stat-grid{grid-template-columns:1fr 1fr}.panel-grid{grid-template-columns:1fr}}@media(max-width:560px){.stat-grid{grid-template-columns:1fr}.quick{grid-template-columns:1fr}}
</style><link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="../css/final-modern.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/final-ui-fixes.css">
    <link rel="stylesheet" href="../css/modern-all-pages.css">

    <link rel="stylesheet" href="../css/crp-modern-v2026.css?v=20260918">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head><body>
<header><h1>Car Rental Portal</h1><p>Administrator Control Center</p></header>
<nav><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a><a href="${pageContext.request.contextPath}/admin/manageCars.jsp">Cars</a><a href="${pageContext.request.contextPath}/admin/manageBookings.jsp">Bookings</a><a href="${pageContext.request.contextPath}/admin/manageUsers.jsp">Users</a><a href="${pageContext.request.contextPath}/admin/reports.jsp">Reports</a><a href="${pageContext.request.contextPath}/admin-support">Support Inbox</a><a href="../logout">Logout</a></nav>
<main class="admin-wrap">
<section class="admin-hero"><h2>Welcome, <%=admin.getUsername()%> 👋</h2><p>Monitor your rental business from one place.</p></section>
<section class="stat-grid">
<div class="stat-card"><div class="accent"></div><div class="label">TOTAL USERS</div><div class="value"><%=users%></div><div class="hint">Registered customers</div></div>
<div class="stat-card"><div class="accent"></div><div class="label">TOTAL CARS</div><div class="value"><%=cars%></div><div class="hint"><%=available%> currently available</div></div>
<div class="stat-card"><div class="accent"></div><div class="label">TOTAL BOOKINGS</div><div class="value"><%=bookings%></div><div class="hint"><%=completed%> completed</div></div>
<div class="stat-card"><div class="accent"></div><div class="label">REVENUE</div><div class="value">₹<%=String.format("%,.2f",revenue)%></div><div class="hint">Paid transactions</div></div>
</section>
<section class="panel-grid">
<div class="panel"><h3>Fleet & Booking Overview</h3>
<div class="bar-row"><div class="bar-label"><span>Car availability</span><span><%=String.format("%.0f",availability)%>%</span></div><div class="bar"><span style="width:<%=Math.min(100,Math.max(0,availability))%>%"></span></div></div>
<div class="bar-row"><div class="bar-label"><span>Completed bookings</span><span><%=bookings==0?0:String.format("%.0f",completed*100.0/bookings)%>%</span></div><div class="bar green"><span style="width:<%=bookings==0?0:Math.min(100,Math.max(0,completed*100.0/bookings))%>%"></span></div></div>
<div class="bar-row"><div class="bar-label"><span>Cancelled bookings</span><span><%=cancelled%></span></div><div class="bar red"><span style="width:<%=bookings==0?0:Math.min(100,Math.max(0,cancelled*100.0/bookings))%>%"></span></div></div>
</div>
<div class="panel"><h3>Quick Actions</h3><div class="quick"><a href="${pageContext.request.contextPath}/admin/manageCars.jsp">🚗 Manage Cars</a><a href="${pageContext.request.contextPath}/admin/manageBookings.jsp">📋 Manage Bookings</a><a href="${pageContext.request.contextPath}/admin/manageUsers.jsp">👥 Manage Users</a><a href="${pageContext.request.contextPath}/admin/reports.jsp">📊 View Reports</a><a href="${pageContext.request.contextPath}/admin-support">💬 Support Inbox</a></div></div>
</section>
</main></body></html>
