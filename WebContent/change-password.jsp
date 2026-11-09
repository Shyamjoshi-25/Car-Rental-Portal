<%@ page contentType="text/html;charset=UTF-8" %><%@ page import="model.User" %><% if(session.getAttribute("user")==null){response.sendRedirect("login.jsp");return;} %><!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>Change Password - Car Rental Portal"><link rel="stylesheet" href="css/style.css"><style>body{font:16px Arial;background:#f3f6fb;margin:0}.wrap{max-width:520px;margin:7vh auto;background:white;padding:28px;border-radius:16px;box-shadow:0 8px 28px #18385c18}input,button{width:100%;box-sizing:border-box;padding:12px;margin:8px 0;border:1px solid #ccd5e1;border-radius:8px}button{background:#0755a5;color:white;border:0;font-weight:bold}.msg{color:#0755a5}.err{color:#b42318}</style>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head><body><main class="wrap"><h1>Change Password</h1><p>Choose a strong password of at least 8 characters.</p><%if(request.getAttribute("error")!=null){%><p class="err"><%=request.getAttribute("error")%></p><%}if(request.getAttribute("message")!=null){%><p class="msg"><%=request.getAttribute("message")%></p><%}%><form method="post" action="change-password"><label>Current password</label><input type="password" name="currentPassword" required><label>New password</label><input type="password" name="newPassword" minlength="8" required><label>Confirm new password</label><input type="password" name="confirmPassword" minlength="8" required><button>Update Password</button></form><a href="profile">Back to Profile</a></main></body></html>
