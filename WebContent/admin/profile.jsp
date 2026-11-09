<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<% if(session.getAttribute("admin")==null || !"ADMIN".equals(session.getAttribute("role"))){response.sendRedirect("../admin-login.jsp");return;} Admin admin=(Admin)session.getAttribute("admin"); %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Admin Profile</title><style>body{font-family:Arial;background:#f4f6f8;margin:0}.top{background:#1f4e79;color:white;padding:22px;text-align:center}.box{max-width:520px;margin:35px auto;background:white;padding:28px;border-radius:12px;box-shadow:0 2px 12px #ddd}.row{padding:12px;border-bottom:1px solid #eee}.label{font-weight:bold;color:#555}.links{text-align:center;margin-top:22px}.links a{margin:0 8px;color:#1f4e79}</style><link rel="stylesheet" href="../css/ui.css">
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
</head><body><div class="top"><h1>Admin Profile</h1></div><div class="box"><div class="row"><span class="label">Username:</span> <%=admin.getUsername()%></div><div class="row"><span class="label">Email:</span> <%=admin.getEmail()==null?"Not set":admin.getEmail()%></div><div class="row"><span class="label">Admin ID:</span> <%=admin.getAdminId()%></div><div class="links"><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a><a href="../logout">Logout</a></div></div></body></html>
