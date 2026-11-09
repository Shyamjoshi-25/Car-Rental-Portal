<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>Register - Car Rental Portal</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ui.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
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
        <section class="auth-visual auth-visual-register">
            <div class="auth-visual-overlay"></div>
            <div class="auth-visual-content">
                <a class="auth-brand" href="<%=request.getContextPath()%>/index.jsp">🚗 <span>Car Rental Portal</span></a>
                <span class="auth-kicker">START YOUR JOURNEY</span>
                <h1>Create Your Account</h1>
                <p>Register once and keep your bookings, rental details and payment history together.</p>
                <div class="auth-benefits">
                    <div><strong>✓</strong><span>Easy online booking</span></div>
                    <div><strong>✓</strong><span>Secure account access</span></div>
                    <div><strong>✓</strong><span>Track your rentals</span></div>
                </div>
            </div>
        </section>

        <section class="auth-panel auth-panel-register">
            <div class="auth-card auth-card-modern auth-card-register">
                <div class="auth-mobile-brand">
                    🚗 Car Rental Portal
                </div>

                <%
                    Integer userId = (Integer) request.getAttribute("userId");
                    String fullName = (String) request.getAttribute("fullName");
                    String email = (String) request.getAttribute("email");
                    String phone = (String) request.getAttribute("phone");
                    String address = (String) request.getAttribute("address");
                    String error = (String) request.getAttribute("error");
                %>

                <% if (userId != null && userId > 0) { %>
                    <div class="auth-success-icon">✓</div>
                    <div class="auth-heading success-heading">
                        <span class="auth-eyebrow">ACCOUNT CREATED</span>
                        <h2>Registration Successful</h2>
                        <p>Your Car Rental Portal account has been created successfully.</p>
                    </div>

                    <div class="register-summary">
                        <div class="register-user-id">
                            <span>Your User ID</span>
                            <strong><%= userId %></strong>
                        </div>
                        <div class="register-summary-row"><span>Name</span><strong><%= fullName %></strong></div>
                        <div class="register-summary-row"><span>Email</span><strong><%= email %></strong></div>
                        <div class="register-summary-row"><span>Phone</span><strong><%= phone %></strong></div>
                    </div>

                    <div class="register-success-note">Please keep your User ID for future reference.</div>
                    <a href="<%=request.getContextPath()%>/login.jsp" class="register-primary-link">Login Now</a>
                    <div class="auth-links auth-links-modern"><p><a href="<%=request.getContextPath()%>/index.jsp">Home</a> <span>•</span> <a href="<%=request.getContextPath()%>/about.jsp">About</a></p></div>
                <% } else { %>
                    <div class="auth-heading">
                        <span class="auth-eyebrow">NEW CUSTOMER</span>
                        <h2>Create an Account</h2>
                        <p>Fill in your details to get started.</p>
                    </div>

                    <% if (error != null) { %>
                        <div class="auth-error"><%= error %></div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/RegisterServlet" method="post" class="auth-form-modern register-form-modern" autocomplete="on">
                        <div class="register-form-grid">
                            <div class="auth-field">
                                <label for="fullName">Full Name</label>
                                <input id="fullName" type="text" name="fullName" placeholder="Enter full name" value="<%= fullName != null ? fullName : "" %>" autocomplete="name" required>
                            </div>
                            <div class="auth-field">
                                <label for="email">Email</label>
                                <input id="email" type="email" name="email" placeholder="Enter email" value="<%= email != null ? email : "" %>" autocomplete="email" required>
                            </div>
                            <div class="auth-field">
                                <label for="phone">Phone Number</label>
                                <input id="phone" type="text" name="phone" placeholder="Enter phone number" value="<%= phone != null ? phone : "" %>" autocomplete="tel" required>
                            </div>
                            <div class="auth-field auth-field-full">
                                <label for="address">Address</label>
                                <textarea id="address" name="address" placeholder="Enter your address" autocomplete="street-address" required><%= address != null ? address : "" %></textarea>
                            </div>
                            <div class="auth-field auth-field-full">
                                <label for="password">Password</label>
                                <input id="password" type="password" name="password" placeholder="Create a password" autocomplete="new-password" required>
                            </div>
                        </div>
                        <button class="auth-submit" type="submit">Create Account</button>
                    </form>

                    <div class="auth-links auth-links-modern">
                        <p>Already have an account? <a href="<%=request.getContextPath()%>/login.jsp">Login</a></p>
                        <p><a href="<%=request.getContextPath()%>/index.jsp">Home</a> <span>•</span> <a href="<%=request.getContextPath()%>/about.jsp">About</a></p>
                    </div>
                <% } %>
            </div>
        </section>
    </div>
</body>
</html>
