<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Car,dao.CarDAO,java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Car> cars = new CarDAO().getAllCars();
    int availableCount = 0;
    int unavailableCount = 0;
    for (Car c : cars) {
        if ("Available".equalsIgnoreCase(c.getStatus())) {
            availableCount++;
        } else {
            unavailableCount++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <meta name="theme-color" content="#073b73">
    <title>View Cars - Car Rental Portal</title>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mobile-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reference-modern.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/final-ui-fixes.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-all-pages.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/crp-modern-v2026.css?v=20260918-2">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/crp-cars-v2026.css?v=20260918-2">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/view-cars-consistency.css?v=20261012">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head>
<body class="crp-cars-page">

<header class="main-header crp-viewcars-header">
    <div class="logo-area">
        <h1>Car Rental Portal</h1>
        <p>Welcome back, <%=user.getFullName()%> — find your next ride</p>
    </div>
    <div class="crp-viewcars-header-tag">PREMIUM FLEET</div>
</header>

<nav class="navbar crp-viewcars-nav" aria-label="Main navigation">
    <a href="index.jsp">Home</a>
    <a href="dashboard.jsp">Dashboard</a>
    <a class="active" aria-current="page" href="cars.jsp">View Cars</a>
    <a href="bookingHistory.jsp">My Bookings</a>
    <a href="payment.jsp">Payments</a>
    <a href="cart">My Cart</a>
    <a href="support">Support</a>
    <a href="profile">Profile</a>
    <a href="logout">Logout</a>
</nav>

<main class="crp-cars-main">
    <section class="crp-cars-intro">
        <div>
            <span class="crp-kicker">OUR FLEET</span>
            <h2>Choose Your Ride</h2>
            <p>Browse comfortable, reliable vehicles and reserve the car that fits your journey.</p>
        </div>
        <a class="crp-back-dashboard" href="dashboard.jsp">← Dashboard</a>
    </section>

    <section class="crp-fleet-stats" aria-label="Fleet summary">
        <div class="crp-fleet-stat">
            <span class="crp-stat-icon">✓</span>
            <div><strong><%=availableCount%></strong><small>Available</small></div>
        </div>
        <div class="crp-fleet-stat">
            <span class="crp-stat-icon">×</span>
            <div><strong><%=unavailableCount%></strong><small>Not Available</small></div>
        </div>
        <div class="crp-fleet-stat">
            <span class="crp-stat-icon">▦</span>
            <div><strong><%=cars.size()%></strong><small>Total Cars</small></div>
        </div>
    </section>

    <% if (cars.isEmpty()) { %>
        <section class="crp-empty-fleet">
            <div class="crp-empty-icon">🚘</div>
            <h3>No cars available</h3>
            <p>The fleet is currently empty. Please check again later.</p>
        </section>
    <% } else { %>
        <section class="crp-fleet-grid" aria-label="Available cars">
            <% for (Car c : cars) {
                String name = c.getCarName() == null ? "" : c.getCarName().trim();
                String image = "images/noimage.jpeg";
                String key = name.toLowerCase();

                if (key.contains("swift")) image = "images/car1.jpeg";
                else if (key.contains("baleno")) image = "images/car2.jpeg";
                else if (key.contains("creta")) image = "images/car3.jpeg";
                else if (key.contains("venue")) image = "images/car4.jpeg";
                else if (key.contains("nexon")) image = "images/car5.jpeg";
                else if (key.contains("harrier")) image = "images/car6.jpeg";
                else if (key.contains("city")) image = "images/car2.jpeg";
                else if (key.contains("innova")) image = "images/car4.jpeg";
                else if (key.contains("xuv")) image = "images/car5.jpeg";
                else if (key.contains("fortuner")) image = "images/car6.jpeg";
                else if (c.getCarId() > 0) image = "images/car" + (((c.getCarId() - 1) % 6) + 1) + ".jpeg";
            %>
                <article class="crp-fleet-card">
                    <div class="crp-fleet-photo">
                        <img
                            src="<%=request.getContextPath()%>/car-image?id=<%=c.getCarId()%>"
                            alt="<%=name%>"
                            loading="lazy"
                            onerror="this.onerror=null;this.src='<%=request.getContextPath()%>/images/noimage.jpeg?v=20260918-2';">
                        <span class="crp-status <%= "Available".equalsIgnoreCase(c.getStatus()) ? "is-available" : "is-unavailable" %>">
                            <%=c.getStatus()%>
                        </span>
                    </div>

                    <div class="crp-fleet-body">
                        <div class="crp-fleet-title-row">
                            <div>
                                <h3><%=name%></h3>
                                <p><%=c.getBrand() == null ? "" : c.getBrand()%> <span>•</span> <%=c.getModel() == null ? "" : c.getModel()%></p>
                            </div>
                            <span class="crp-car-id">#<%=c.getCarId()%></span>
                        </div>

                        <div class="crp-fleet-tags">
                            <span>⛽ <%=c.getFuelType() == null || c.getFuelType().isBlank() ? "Fuel" : c.getFuelType()%></span>
                            <span>👥 5 Seats</span>
                            <span>✓ Verified</span>
                        </div>

                        <div class="crp-fleet-bottom">
                            <div class="crp-price">
                                <strong>₹<%=String.format("%.0f", c.getPricePerDay())%></strong>
                                <span>/ day</span>
                            </div>
                            <% if ("Available".equalsIgnoreCase(c.getStatus())) { %>
                                <span><a class="crp-book-btn" href="booking.jsp?carId=<%=c.getCarId()%>">Book Now <span>→</span></a> <a href="cart?action=add&amp;carId=<%=c.getCarId()%>">Add to Cart</a></span>
                            <% } else { %>
                                <span class="crp-book-btn is-disabled">Unavailable</span>
                            <% } %>
                        </div>
                    </div>
                </article>
            <% } %>
        </section>
    <% } %>
</main>

<footer class="crp-cars-footer">
    <strong>Car Rental Portal</strong>
    <span>Reliable cars • Easy booking • Comfortable journeys</span>
</footer>

</body>
</html>
