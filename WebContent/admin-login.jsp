<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Admin Login</title>
<style>body{font-family:Arial;background:#f4f6f8;margin:0}.box{width:380px;max-width:90%;margin:80px auto;background:#fff;padding:30px;border-radius:12px;box-shadow:0 5px 20px #bbb}h2{text-align:center;color:#1f4e79}input{width:100%;box-sizing:border-box;padding:11px;margin:8px 0 16px;border:1px solid #ccc;border-radius:6px}button{width:100%;padding:12px;background:#1f4e79;color:#fff;border:0;border-radius:6px;font-size:16px;cursor:pointer}.err{color:#c62828;text-align:center}.links{text-align:center;margin-top:18px}.links a{color:#1f4e79;text-decoration:none}</style><link rel="stylesheet" href="css/ui.css">
<link rel="stylesheet" href="css/responsive.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-modern.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-ui-fixes.css">
    <link rel="stylesheet" href="css/modern-all-pages.css">

    <link rel="stylesheet" href="css/crp-modern-v2026.css?v=20260918">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head>
<body><div class="box"><h2>Admin Login</h2><% String error=(String)request.getAttribute("error"); if(error!=null){%><p class="err"><%=error%></p><%}%>
<form action="AdminLoginServlet" method="post"><input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>"><label>Username</label><input name="username" required><label>Password</label><input type="password" name="password" required><button type="submit">Login</button></form>
<div class="links"><a href="login.jsp">User Login</a> · <a href="index.jsp">Home</a></div></div></body></html>
