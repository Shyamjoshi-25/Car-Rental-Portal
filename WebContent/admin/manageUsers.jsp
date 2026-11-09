<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin,model.User,dao.UserDAO,java.util.List" %>
<% if(session.getAttribute("admin")==null || !"ADMIN".equals(session.getAttribute("role"))){response.sendRedirect("../admin-login.jsp");return;} List<User> users=new UserDAO().getAllUsers(); %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Manage Users</title><style>body{font-family:Arial;background:#f4f6f8;margin:0}.top{background:#1f4e79;color:#fff;padding:20px;text-align:center}.wrap{width:94%;margin:25px auto;overflow:auto}table{width:100%;border-collapse:collapse;background:#fff}th,td{padding:11px;border:1px solid #ddd;text-align:center}th{background:#1f4e79;color:#fff}.delete{padding:7px 11px;background:#dc3545;color:#fff;border:0;border-radius:4px;cursor:pointer}</style><link rel="stylesheet" href="../css/ui.css">
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
</head><body><div class="top"><h1>Manage Users</h1></div><div class="wrap"><table><tr><th>ID</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Address</th><th>Action</th></tr><%for(User u:users){%><tr><td><%=u.getUserId()%></td><td><%=u.getFullName()%></td><td><%=u.getEmail()%></td><td><%=u.getPhone()==null?"":u.getPhone()%></td><td><%=u.getAddress()==null?"":u.getAddress()%></td><td><form action="../AdminServlet" method="post"><input type="hidden" name="csrfToken" value="<%=session.getAttribute("csrfToken")%>"><input type="hidden" name="action" value="deleteUser"><input type="hidden" name="userId" value="<%=u.getUserId()%>"><button class="delete" onclick="return confirm('Delete this user and their bookings?')">Delete</button></form></td></tr><%}%></table><p><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Dashboard</a></p></div></body></html>
