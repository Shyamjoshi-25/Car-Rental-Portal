<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>Login - Car Rental Portal</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
    <script defer src="<%=request.getContextPath()%>/js/script.js"></script>
    <script defer src="<%=request.getContextPath()%>/js/validation.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-ui-fixes.css">
    <link rel="stylesheet" href="css/modern-all-pages.css">

    <link rel="stylesheet" href="css/crp-modern-v2026.css?v=20260918">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head>
<body class="auth-layout-page">
    <div class="auth-shell">
        <section class="auth-visual auth-visual-login">
            <div class="auth-visual-overlay"></div>
            <div class="auth-visual-content">
                <a class="auth-brand" href="<%=request.getContextPath()%>/index.jsp">🚗 <span>Car Rental Portal</span></a>
                <span class="auth-kicker">PREMIUM CAR RENTAL</span>
                <h1>Welcome Back</h1>
                <p>Sign in to manage your bookings, payments and rental journey from one place.</p>
                <div class="auth-quick-links">
                    <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
                    <a href="<%=request.getContextPath()%>/about.jsp">About</a>
                    <a href="<%=request.getContextPath()%>/register.jsp">Create Account</a>
                </div>
            </div>
        </section>

        <section class="auth-panel">
            <div class="auth-card auth-card-modern">
                <div class="auth-mobile-brand">
                    🚗 Car Rental Portal
                </div>
                <div class="auth-heading">
                    <span class="auth-eyebrow">ACCOUNT ACCESS</span>
                    <h2>Welcome Back</h2>
                    <p>Sign in to continue your rental journey.</p>
                </div>

                <% String error=(String)request.getAttribute("error"); if(error!=null){ %>
                    <div class="auth-error"><%=error%></div>
                <% } %>

                <form action="<%=request.getContextPath()%>/LoginServlet" method="post" autocomplete="on" class="auth-form-modern">
                    <div class="auth-field">
                        <label for="email">Email</label>
                        <input id="email" type="email" name="email" placeholder="Enter your email" autocomplete="email" required>
                    </div>
                    <div class="auth-field">
                        <label for="password">Password</label>
                        <input id="password" type="password" name="password" placeholder="Enter your password" autocomplete="current-password" required>
                    </div>
                    <button class="auth-submit" type="submit">Sign In</button>
                </form>

                <div class="auth-links auth-links-modern">
                    <p>Don't have an account? <a href="<%=request.getContextPath()%>/register.jsp">Register here</a></p>
                    <p><a href="<%=request.getContextPath()%>/admin-login.jsp">Admin Login</a> <span>•</span> <a href="<%=request.getContextPath()%>/index.jsp">Home</a></p>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
