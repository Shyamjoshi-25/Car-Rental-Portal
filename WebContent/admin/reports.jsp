<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin,dao.AdminDAO" %>
<% if(session.getAttribute("admin")==null || !"ADMIN".equals(session.getAttribute("role"))){response.sendRedirect("../admin-login.jsp");return;} AdminDAO d=new AdminDAO(); %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Reports</title><style>body{font-family:Arial;background:#f4f6f8;margin:0}.top{background:#1f4e79;color:white;padding:20px;text-align:center}.wrap{width:90%;margin:25px auto}.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px}.card{background:white;padding:20px;border-radius:10px;box-shadow:0 2px 10px #ddd}.num{font-size:28px;font-weight:bold;color:#1f4e79}table{width:100%;margin-top:25px;border-collapse:collapse;background:white}th,td{padding:12px;border:1px solid #ddd;text-align:center}th{background:#1f4e79;color:white}</style><link rel="stylesheet" href="../css/ui.css">
<link rel="stylesheet" href="../css/responsive.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="../css/final-modern.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/final-ui-fixes.css">
    <link rel="stylesheet" href="../css/modern-all-pages.css">

    <link rel="stylesheet" href="../css/crp-modern-v2026.css?v=20260918">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head><body><div class="top"><h1>Reports</h1></div><div class="wrap"><div class="cards"><div class="card">Users<div class="num"><%=d.countUsers()%></div></div><div class="card">Cars<div class="num"><%=d.countCars()%></div></div><div class="card">Bookings<div class="num"><%=d.countBookings()%></div></div><div class="card">Revenue<div class="num">₹<%=String.format("%.2f",d.totalRevenue())%></div></div></div><table><tr><th>Report</th><th>Count</th></tr><tr><td>Available Cars</td><td><%=d.countAvailableCars()%></td></tr><tr><td>Not Available Cars</td><td><%=d.countNotAvailableCars()%></td></tr><tr><td>Completed Bookings</td><td><%=d.countCompletedBookings()%></td></tr><tr><td>Cancelled Bookings</td><td><%=d.countCancelledBookings()%></td></tr><tr><td>Registered Users</td><td><%=d.countUsers()%></td></tr></table><p><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Dashboard</a></p></div></body></html>
