<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.User" %>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = user.getFullName() != null
            ? user.getFullName()
            : "User";

    String email = user.getEmail() != null
            ? user.getEmail()
            : "";

    String phone = user.getPhone() != null
            ? user.getPhone()
            : "";

    String address = user.getAddress() != null
            ? user.getAddress()
            : "";

    int userId = user.getUserId();

    String initial = name.trim().isEmpty()
            ? "U"
            : name.trim().substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>My Profile - Car Rental Portal</title>

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/profile.css">
<link rel="stylesheet" href="css/responsive.css">

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f4f4;
}

/* ================= HEADER ================= */

header {
    background: #1f4e79;
    color: white;
    padding: 20px;
    text-align: center;
}

header h1 {
    margin: 0;
}

header h3 {
    margin: 8px 0 0;
}

/* ================= NAVIGATION ================= */

nav {
    background: #333;
    padding: 12px;
    text-align: center;
}

nav a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
    font-size: 17px;
}

nav a:hover {
    color: yellow;
}

/* ================= PROFILE ================= */

.profile-container {
    width: 90%;
    max-width: 700px;
    margin: 40px auto;
}

.profile-card {
    background: white;
    padding: 35px;
    border-radius: 12px;
    box-shadow: 0 0 12px #bbb;
}

/* ================= PROFILE ICON ================= */

.profile-icon {
    width: 90px;
    height: 90px;
    margin: 0 auto 20px;

    border-radius: 50%;

    background: #1f4e79;
    color: white;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 40px;
    font-weight: bold;
}

.profile-icon img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
}

.profile-icon span { font-size: 40px; font-weight: bold; }

/* ================= NAME ================= */

.profile-card h2 {
    text-align: center;
    color: #1f4e79;
    margin-bottom: 30px;
}

/* ================= PROFILE INFORMATION ================= */

.profile-info {
    margin: 18px 0;
    padding: 15px;

    background: #f7f7f7;

    border-radius: 7px;

    border-left: 4px solid #1f4e79;
}

.profile-info strong {
    display: block;

    color: #1f4e79;

    margin-bottom: 5px;
}

.profile-info span {
    color: #333;

    font-size: 16px;
}

/* ================= BUTTONS ================= */

.buttons {
    text-align: center;

    margin-top: 30px;
}

.btn {
    display: inline-block;

    padding: 11px 22px;

    margin: 5px;

    background: #1f4e79;

    color: white;

    text-decoration: none;

    border-radius: 5px;
}

.btn:hover {
    background: #0d6efd;
}

/* ================= FOOTER ================= */

footer {
    background: #1f4e79;

    color: white;

    text-align: center;

    padding: 15px;

    margin-top: 50px;
}

/* ================= MOBILE ================= */

@media (max-width: 600px) {

    nav a {
        display: block;

        margin: 8px 0;
    }

    .profile-container {
        width: 94%;
    }

    .profile-card {
        padding: 25px 18px;
    }

}

</style>

<link rel="stylesheet" href="css/ui.css">
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

<body>

<!-- ================= HEADER ================= -->

<header>

    <h1>Car Rental Portal</h1>
<p><a href="change-password">Change Password</a> | <a href="support">Customer Support</a></p>

    <h3>My Profile</h3>

</header>


<!-- ================= NAVIGATION ================= -->

<nav>

    <a href="index.jsp">Home</a>

    <a href="dashboard.jsp">Dashboard</a>

    <a href="cars.jsp">View Cars</a>

    <a href="bookingHistory.jsp">My Bookings</a>
    <a href="cart">My Cart</a>
    <a href="support">Customer Support</a>
    <a href="payment-history">Payment History</a>

    <a href="payment.jsp">Payments</a>

    <a href="profile">My Profile</a>

    <a href="logout">Logout</a>

</nav>


<!-- ================= PROFILE ================= -->

<div class="profile-container">

    <div class="profile-card">


        <!-- PROFILE AVATAR -->

        <div class="profile-icon">
            <img src="profile-photo" alt="Profile Photo"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block';">
            <span style="display:none;"><%= initial %></span>
        </div>


        <!-- USER NAME -->

        <h2>

            <%= name %>

        </h2>


        <!-- USER ID -->

        <div class="profile-info">

            <strong>User ID</strong>

            <span>

                <%= userId %>

            </span>

        </div>


        <!-- FULL NAME -->

        <div class="profile-info">

            <strong>Full Name</strong>

            <span>

                <%= name %>

            </span>

        </div>


        <!-- EMAIL -->

        <div class="profile-info">

            <strong>Email</strong>

            <span>

                <%= email %>

            </span>

        </div>


        <!-- PHONE -->

        <div class="profile-info">

            <strong>Phone</strong>

            <span>

                <%= phone %>

            </span>

        </div>


        <!-- ADDRESS -->

        <div class="profile-info">

            <strong>Address</strong>

            <span>

                <%= address.isEmpty() ? "Not provided" : address %>

            </span>

        </div>


        <!-- BUTTONS -->

        <div class="buttons">

            <a href="edit-profile.jsp" class="btn">

                Edit Profile

            </a>

            <a href="dashboard.jsp" class="btn">

                Back to Dashboard

            </a>

        </div>


    </div>

</div>


<!-- ================= FOOTER ================= -->

<footer>

    &copy; 2026 Car Rental Portal | All Rights Reserved

</footer>

</body>

</html>