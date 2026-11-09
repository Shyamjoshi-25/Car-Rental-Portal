<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>About - Car Rental Portal</title>
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
<body class="about-page-modern">
    <header class="about-header-modern">
        <div class="about-brand-modern">
            <a href="<%=request.getContextPath()%>/index.jsp">🚗 <span>Car Rental Portal</span></a>
            <p>Rent Your Dream Car Easily</p>
        </div>
        <nav class="about-nav-modern" aria-label="Main navigation">
            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
            <a href="<%=request.getContextPath()%>/cars.jsp">Cars</a>
            <a href="<%=request.getContextPath()%>/about.jsp" class="active">About</a>
            <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/register.jsp" class="nav-register">Register</a>
        </nav>
    </header>

    <main>
        <section class="about-hero-modern">
            <div class="about-hero-overlay"></div>
            <div class="about-hero-content">
                <span class="about-kicker">ABOUT OUR PLATFORM</span>
                <h1>Simple Car Rental, Built Around Your Journey</h1>
                <p>Car Rental Portal brings car discovery, booking, payments and rental records into one clean experience for customers and administrators.</p>
                <div class="about-hero-actions">
                    <a href="<%=request.getContextPath()%>/cars.jsp" class="about-btn about-btn-primary">Explore Cars</a>
                    <a href="<%=request.getContextPath()%>/register.jsp" class="about-btn about-btn-secondary">Create Account</a>
                </div>
            </div>
        </section>

        <section class="about-section-modern">
            <div class="about-section-heading">
                <span>WHAT WE DO</span>
                <h2>Everything You Need for a Rental</h2>
                <p>Designed to keep the customer journey clear from the first search to final payment.</p>
            </div>

            <div class="about-feature-grid">
                <article class="about-feature-card">
                    <div class="about-feature-icon">🚘</div>
                    <h3>Browse Available Cars</h3>
                    <p>View vehicles with pricing, details and availability in a clear card-based layout.</p>
                </article>
                <article class="about-feature-card">
                    <div class="about-feature-icon">📅</div>
                    <h3>Book Online</h3>
                    <p>Choose rental dates and submit your booking from a responsive booking interface.</p>
                </article>
                <article class="about-feature-card">
                    <div class="about-feature-icon">💳</div>
                    <h3>Manage Payments</h3>
                    <p>Keep advance and final payment records connected to the rental workflow.</p>
                </article>
                <article class="about-feature-card">
                    <div class="about-feature-icon">🧾</div>
                    <h3>Rental Records</h3>
                    <p>Access booking history, payment details and rental agreement information from your account.</p>
                </article>
            </div>
        </section>

        <section class="about-split-modern">
            <div class="about-split-image">
                <img src="<%=request.getContextPath()%>/images/hero-car-wide.jpg" alt="Car Rental Portal journey">
            </div>
            <div class="about-split-content">
                <span class="about-kicker about-kicker-dark">WHY THE PORTAL</span>
                <h2>A Modern Experience on Desktop and Mobile</h2>
                <p>The interface is designed to adapt from large Windows screens to mobile phones while keeping the same visual language, navigation structure and core rental workflow.</p>
                <div class="about-check-list">
                    <div><span>✓</span> Responsive layouts for different screen sizes</div>
                    <div><span>✓</span> Consistent navigation and clear actions</div>
                    <div><span>✓</span> Customer and admin workflows in one project</div>
                    <div><span>✓</span> PostgreSQL database with Java Servlet backend</div>
                </div>
            </div>
        </section>

        <section class="about-section-modern about-process-section">
            <div class="about-section-heading">
                <span>HOW IT WORKS</span>
                <h2>From Search to Completed Rental</h2>
            </div>
            <div class="about-process-grid">
                <div class="about-process-card"><div class="about-process-number">01</div><h3>Choose a Car</h3><p>Browse cars and open the details page for the vehicle you want.</p></div>
                <div class="about-process-card"><div class="about-process-number">02</div><h3>Enter Rental Details</h3><p>Select your dates and provide the booking information.</p></div>
                <div class="about-process-card"><div class="about-process-number">03</div><h3>Complete Payment</h3><p>Use the payment flow to record the required rental payment.</p></div>
                <div class="about-process-card"><div class="about-process-number">04</div><h3>Manage Your Rental</h3><p>Review history, payments and agreement details from your account.</p></div>
            </div>
        </section>

        <section class="about-tech-modern">
            <div>
                <span class="about-kicker about-kicker-dark">PROJECT TECHNOLOGY</span>
                <h2>Built as a Java Web Application</h2>
                <p>The project combines a JSP/Servlet web layer with PostgreSQL persistence and Docker-based deployment for repeatable local setup.</p>
            </div>
            <div class="about-tech-grid">
                <span>Java 17</span><span>JSP + Servlets</span><span>Tomcat 10.1</span><span>PostgreSQL</span><span>Maven</span><span>Docker</span>
            </div>
        </section>

        <section class="about-cta-modern">
            <div>
                <span class="about-kicker">READY TO START?</span>
                <h2>Find the Right Car for Your Next Trip</h2>
                <p>Explore the fleet or create your account to begin.</p>
            </div>
            <div class="about-cta-actions">
                <a href="<%=request.getContextPath()%>/cars.jsp" class="about-btn about-btn-primary">View Cars</a>
                <a href="<%=request.getContextPath()%>/login.jsp" class="about-btn about-btn-secondary">Login</a>
            </div>
        </section>
    </main>

    <footer class="about-footer-modern">
        <div>
            <strong>Car Rental Portal</strong>
            <span>Modern, responsive car rental management.</span>
        </div>
        <div class="about-footer-links">
            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
            <a href="<%=request.getContextPath()%>/cars.jsp">Cars</a>
            <a href="<%=request.getContextPath()%>/about.jsp">About</a>
            <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/register.jsp">Register</a>
        </div>
        <div class="about-footer-copy">© 2026 Car Rental Portal</div>
    </footer>
</body>
</html>
