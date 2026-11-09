<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userName = currentUser.getFullName() == null || currentUser.getFullName().trim().isEmpty()
            ? "User" : currentUser.getFullName();
    String userEmail = currentUser.getEmail() == null ? "" : currentUser.getEmail();
    String userPhone = currentUser.getPhone() == null ? "Not provided" : currentUser.getPhone();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - Car Rental Portal</title>
<style>
    * { box-sizing: border-box; }

    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: #f5f7fb;
        color: #172033;
    }

    .top-header {
        min-height: 128px;
        background: linear-gradient(135deg, #082b72 0%, #0b3b91 55%, #0a2d73 100%);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        padding: 22px 230px 22px 20px;
        text-align: center;
    }

    .brand h1 {
        margin: 0;
        font-size: 38px;
        font-weight: 750;
        letter-spacing: .2px;
    }

    .brand p {
        margin: 5px 0 0;
        font-size: 24px;
        font-weight: 650;
    }

    .profile-area {
        position: absolute;
        right: 35px;
        top: 28px;
        z-index: 20;
    }

    .profile-toggle {
        border: 0;
        background: transparent;
        color: #fff;
        display: flex;
        align-items: center;
        gap: 10px;
        cursor: pointer;
        font-size: 17px;
        padding: 5px;
    }

    .avatar {
        width: 43px;
        height: 43px;
        border: 2px solid #fff;
        border-radius: 50%;
        background: #f8fbff;
        display: grid;
        place-items: center;
        overflow: hidden;
    }

    .avatar img { width: 100%; height: 100%; object-fit: cover; display: block; }
    .avatar svg { width: 32px; height: 32px; }

    .dropdown {
        position: absolute;
        right: 0;
        top: 57px;
        width: 270px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 12px 30px rgba(0,0,0,.20);
        padding: 15px;
        color: #1c2738;
        display: none;
    }

    .profile-area.open .dropdown { display: block; }

    .dropdown-user {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 5px 5px 14px;
        border-bottom: 1px solid #e4e8ee;
    }

    .dropdown-user .avatar {
        width: 54px;
        height: 54px;
        border: 0;
        background: #0c3b91;
    }

    .dropdown-user .avatar svg { width: 40px; height: 40px; }
    .dropdown-user strong { display: block; font-size: 18px; }
    .dropdown-user small { color: #657084; display: block; margin-top: 3px; }

    .menu-item {
        display: flex;
        align-items: center;
        gap: 13px;
        padding: 12px 10px;
        border-radius: 7px;
        margin-top: 4px;
        text-decoration: none;
        color: #293449;
        font-size: 16px;
    }

    .menu-item:hover, .menu-item.active { background: #eef2f8; }
    .menu-item svg { width: 20px; height: 20px; fill: none; stroke: #183c7e; stroke-width: 1.9; }
    .menu-item.logout { border-top: 1px solid #e4e8ee; margin-top: 8px; padding-top: 13px; color: #d72727; }
    .menu-item.logout svg { stroke: #d72727; }

    .main-nav {
        height: 60px;
        background: #0b294e;
        display: flex;
        justify-content: center;
        align-items: stretch;
        gap: 6px;
        padding: 0 15px;
    }

    .main-nav a {
        color: #fff;
        text-decoration: none;
        padding: 20px 28px 17px;
        font-size: 17px;
        font-weight: 600;
        position: relative;
    }

    .main-nav a:hover, .main-nav a.active { background: rgba(255,255,255,.035); }
    .main-nav a.active::after {
        content: "";
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        height: 5px;
        background: #59a8ff;
    }

    .page {
        max-width: 1370px;
        margin: 38px auto 0;
        padding: 0 28px;
    }

    .cards {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 23px;
    }

    .card {
        min-height: 300px;
        background: #fff;
        border: 1px solid #e0e5ec;
        border-radius: 11px;
        box-shadow: 0 4px 12px rgba(20,35,55,.10);
        padding: 22px 22px 27px;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .icon-circle {
        width: 73px;
        height: 73px;
        border-radius: 50%;
        display: grid;
        place-items: center;
        margin: 0 auto 17px;
    }

    .icon-circle svg { width: 43px; height: 43px; fill: none; stroke: #fff; stroke-width: 2.4; stroke-linecap: round; stroke-linejoin: round; }
    .blue { background: #2e86df; }
    .green { background: #12a058; }
    .purple { background: #6840bd; }
    .orange { background: #f47b08; }

    .card h2 {
        margin: 0 0 10px;
        font-size: 22px;
        font-weight: 750;
    }

    .blue-text { color: #1267c4; }
    .green-text { color: #118c4d; }
    .purple-text { color: #6240b6; }
    .orange-text { color: #ee6900; }

    .card p {
        margin: 0;
        color: #4c5667;
        font-size: 17px;
        line-height: 1.55;
        max-width: 235px;
        min-height: 54px;
    }

    .card .button {
        margin-top: auto;
        width: 140px;
        padding: 11px 10px;
        border-radius: 6px;
        color: #fff;
        text-decoration: none;
        font-size: 17px;
        font-weight: 700;
        box-shadow: 0 2px 4px rgba(0,0,0,.13);
    }

    .button.blue-btn { background: #1674d1; }
    .button.green-btn { background: #0c9c50; }
    .button.purple-btn { background: #6940c1; }
    .button.orange-btn { background: #f57908; }
    .button:hover { filter: brightness(.94); }

    .overview {
        margin-top: 26px;
        background: #fff;
        border: 1px solid #e0e5ec;
        border-radius: 11px;
        box-shadow: 0 4px 12px rgba(20,35,55,.10);
        padding: 22px 18px 20px;
    }

    .overview-title {
        display: flex;
        align-items: center;
        gap: 14px;
        color: #123a7b;
        font-size: 20px;
        font-weight: 750;
        padding: 0 4px 19px;
    }

    .overview-title svg { width: 27px; height: 27px; fill: #123a7b; }

    .overview-box {
        border: 1px solid #e0e5ec;
        border-radius: 10px;
        min-height: 145px;
        padding: 21px 25px;
        display: grid;
        grid-template-columns: 1fr 1fr;
        column-gap: 90px;
        row-gap: 24px;
    }

    .info {
        display: grid;
        grid-template-columns: 34px 1fr;
        align-items: center;
    }

    .info-icon svg { width: 23px; height: 23px; fill: none; stroke: #566275; stroke-width: 1.9; }
    .info label { display: block; font-size: 15px; font-weight: 700; color: #293449; margin-bottom: 4px; }
    .info span { display: block; font-size: 16px; color: #39465a; }

    footer {
        margin-top: 22px;
        min-height: 72px;
        background: #082e79;
        color: #fff;
        display: grid;
        place-items: center;
        font-size: 16px;
        padding: 15px;
    }

    @media (max-width: 1000px) {
        .top-header { padding-right: 180px; }
        .brand h1 { font-size: 30px; }
        .brand p { font-size: 19px; }
        .cards { grid-template-columns: repeat(2, 1fr); }
        .main-nav a { padding-left: 15px; padding-right: 15px; }
    }

    @media (max-width: 650px) {
        .top-header { min-height: 155px; padding: 20px 15px 65px; }
        .brand h1 { font-size: 27px; }
        .brand p { font-size: 17px; }
        .profile-area { top: 100px; right: 15px; }
        .dropdown { top: 48px; }
        .main-nav { height: auto; flex-wrap: wrap; padding: 4px; }
        .main-nav a { font-size: 14px; padding: 13px 9px; }
        .page { margin-top: 20px; padding: 0 12px; }
        .cards { grid-template-columns: 1fr; }
        .overview-box { grid-template-columns: 1fr; column-gap: 0; }
    }
</style>
<link rel="stylesheet" href="css/ui.css">
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
<body>

<header class="top-header">
    <div class="brand">
        <h1>Car Rental Portal</h1>
        <p>Welcome to User Dashboard</p>
    </div>

    <div class="profile-area" id="profileArea">
        <button class="profile-toggle" type="button" onclick="toggleProfile()">
            <span class="avatar">
                <img src="<%= request.getContextPath() %>/profile-photo" alt="Profile Photo">
            </span>
            <span>Hello, <%= userName %></span>
            
        </button>

        <div class="dropdown" id="profileDropdown">
            <div class="dropdown-user">
                <span class="avatar">
                    <img src="<%= request.getContextPath() %>/profile-photo" alt="Profile Photo">
                </span>
                <div>
                    <strong><%= userName %></strong>
                    <small><%= userEmail %></small>
                </div>
            </div>

            <a class="menu-item active" href="profile">
                <svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="3.2"/><path d="M5.5 20c.7-4 2.9-6 6.5-6s5.8 2 6.5 6"/></svg>
                Profile
            </a>
            <a class="menu-item" href="bookingHistory.jsp">
                <svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 9h16M8 13h3M8 17h5"/></svg>
                My Bookings
            </a>
            <a class="menu-item" href="payment.jsp">
                <svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 10h18M7 15h4"/></svg>
                Payments
            </a>
            <a class="menu-item" href="profile">
                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M19 13.5a7.7 7.7 0 0 0 0-3l2-1.2-2-3.4-2.2 1a7.7 7.7 0 0 0-2.5-1.5L14 3h-4l-.3 2.4A7.7 7.7 0 0 0 7.2 7L5 6 3 9.4l2 1.2a7.7 7.7 0 0 0 0 3L3 14.8 5 18.2l2.2-1a7.7 7.7 0 0 0 2.5 1.5L10 21h4l.3-2.4a7.7 7.7 0 0 0 2.5-1.5l2.2 1 2-3.4z"/></svg>
                Settings
            </a>
            <a class="menu-item" href="edit-profile.jsp">
                <svg viewBox="0 0 24 24"><path d="M12 3v8"/><path d="M8 8l4 4 4-4"/><path d="M5 14v4h14v-4"/></svg>
                Change Password
            </a>
            <a class="menu-item logout" href="logout" onclick="return confirm('Are you sure you want to logout?');">
                <svg viewBox="0 0 24 24"><path d="M10 5H5v14h5M14 8l4 4-4 4M18 12H9"/></svg>
                Logout
            </a>
        </div>
    </div>
</header>

<nav class="main-nav">
    <a href="dashboard.jsp" class="active">Dashboard</a>
    <a href="cars.jsp">View Cars</a>
    <a href="bookingHistory.jsp">My Bookings</a>
    <a href="cart">My Cart</a>
    <a href="support">Customer Support</a>
    <a href="payment-history">Payment History</a>
    <a href="payment.jsp">Payments</a>
    <a href="logout" onclick="return confirm('Are you sure you want to logout?');">Logout</a>
</nav>

<main class="page">
    <section class="cards">
        <article class="card">
            <div class="icon-circle blue">
                <svg viewBox="0 0 48 48"><path d="M9 29l4-11h22l4 11v9H9z"/><path d="M13 18l3-7h16l3 7M9 29h30"/><circle cx="16" cy="34" r="3"/><circle cx="32" cy="34" r="3"/></svg>
            </div>
            <h2 class="blue-text">Available Cars</h2>
            <p>Browse all available rental cars.</p>
            <a href="cars.jsp" class="button blue-btn">View Cars</a>
        </article>

        <article class="card">
            <div class="icon-circle green">
                <svg viewBox="0 0 48 48"><rect x="9" y="11" width="30" height="28" rx="3"/><path d="M15 7v8M33 7v8M9 20h30"/><path d="M17 28h6M17 33h10"/></svg>
            </div>
            <h2 class="green-text">Book a Car</h2>
            <p>Reserve your favourite car easily.</p>
            <a href="cars.jsp" class="button green-btn">Book Now</a>
        </article>

        <article class="card">
            <div class="icon-circle purple">
                <svg viewBox="0 0 48 48"><circle cx="24" cy="24" r="15"/><path d="M24 16v9l6 4"/><path d="M10 12v7h7"/><path d="M10 19a16 16 0 0 1 25-5"/></svg>
            </div>
            <h2 class="purple-text">My Bookings</h2>
            <p>View your current and past bookings.</p>
            <a href="bookingHistory.jsp" class="button purple-btn">View History</a>
        </article>

        <article class="card">
            <div class="icon-circle orange">
                <svg viewBox="0 0 48 48"><rect x="7" y="11" width="34" height="26" rx="3"/><path d="M7 19h34M13 29h9"/><path d="M13 25h8"/></svg>
            </div>
            <h2 class="orange-text">Payments</h2>
            <p>View your payments and transactions.</p>
            <a href="payment.jsp" class="button orange-btn">Pay Now</a>
        </article>
    </section>

    <section class="overview">
        <div class="overview-title">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="7" r="4"/><path d="M4 21c.8-5 3.5-7.5 8-7.5s7.2 2.5 8 7.5"/></svg>
            My Profile Overview
        </div>

        <div class="overview-box">
            <div class="info">
                <div class="info-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="3"/><path d="M5 20c.8-4 3.1-6 7-6s6.2 2 7 6"/></svg></div>
                <div><label>Full Name</label><span><%= userName %></span></div>
            </div>

            <div class="info">
                <div class="info-icon"><svg viewBox="0 0 24 24"><path d="M6 4h3l2 5-2 2c1.2 2.5 2.8 4.1 5.3 5.3l2-2 5 2v3c0 1-1 1.7-2 1.7C11.2 21 3 12.8 3 4.7 3 3.7 4 3 5 3z"/></svg></div>
                <div><label>Phone</label><span><%= userPhone %></span></div>
            </div>

            <div class="info">
                <div class="info-icon"><svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M4 7l8 6 8-6"/></svg></div>
                <div><label>Email</label><span><%= userEmail %></span></div>
            </div>

            <div class="info">
                <div class="info-icon"><svg viewBox="0 0 24 24"><rect x="4" y="4" width="16" height="16" rx="2"/><path d="M8 8h8M8 12h8M8 16h4"/></svg></div>
                <div><label>User ID</label><span><%= currentUser.getUserId() %></span></div>
            </div>
        </div>
    </section>
</main>

<footer>&copy; 2026 Car Rental Portal | All Rights Reserved</footer>

<script>
    function toggleProfile() {
        document.getElementById('profileArea').classList.toggle('open');
    }

    document.addEventListener('click', function(event) {
        const area = document.getElementById('profileArea');
        if (!area.contains(event.target)) {
            area.classList.remove('open');
        }
    });
</script>
</body>
</html>


