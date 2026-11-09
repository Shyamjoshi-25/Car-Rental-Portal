<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Car Rental Portal</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mobile-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/final-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reference-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/final-ui-fixes.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar-fix.css">
    <link rel="stylesheet" href="css/modern-all-pages.css">

    <link rel="stylesheet" href="css/crp-modern-v2026.css?v=20260918">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-final-consistency.css?v=20261012-final">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-overrides.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mobile-fix.css?v=20261014">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-consistency-final.css?v=20261014">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head>

<body>

<!-- ================= HEADER ================= -->

<header class="main-header">

    <div class="logo-area">
        <h1>Car Rental Portal</h1>
        <p>Rent Your Dream Car Easily</p>
    </div>



</header>


<!-- ================= NAVIGATION ================= -->

<nav class="navbar">

    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>

    <a href="${pageContext.request.contextPath}/cars.jsp">Cars</a>

    <a href="${pageContext.request.contextPath}/about.jsp">About</a>

    <a href="${pageContext.request.contextPath}/login.jsp">Login</a>

    <a href="${pageContext.request.contextPath}/register.jsp">Register</a>

</nav>


<!-- ================= HERO SECTION ================= -->

<section class="hero">

    <div class="hero-content">

        <span class="hero-small">PREMIUM CAR RENTAL</span>

        <h2>Find Your Perfect Ride</h2>

        <p>
            Rent quality cars at affordable prices.
            Easy booking, comfortable rides and reliable service.
        </p>

        <div class="hero-buttons">

            <a href="${pageContext.request.contextPath}/cars.jsp"
               class="btn primary-btn">
                Browse Cars
            </a>

            <a href="${pageContext.request.contextPath}/register.jsp"
               class="btn secondary-btn">
                Get Started
            </a>

        </div>

    </div>


</section>


<!-- ================= SEARCH SECTION ================= -->

<section class="search-section">

    <h2>Find Your Car</h2>

    <p>Choose your rental details and start your journey.</p>

    <div class="search-box">

        <div class="search-field">
            <label>Pick-up Location</label>
            <input type="text"
                   placeholder="Enter location">
        </div>

        <div class="search-field">
            <label>Pick-up Date</label>
            <input type="date">
        </div>

        <div class="search-field">
            <label>Return Date</label>
            <input type="date">
        </div>

        <a href="${pageContext.request.contextPath}/cars.jsp"
           class="search-btn">
            Search Cars
        </a>

    </div>

</section>


<!-- ================= POPULAR CARS ================= -->

<section class="cars-section">

    <div class="section-title">

        <span>OUR FLEET</span>

        <h2>Popular Cars</h2>

        <p>
            Choose from our wide range of comfortable and reliable cars.
        </p>

    </div>


    <div class="car-grid">


        <!-- CAR 1 -->

        <div class="car-card">

            <img src="${pageContext.request.contextPath}/images/car1.jpeg"
                 alt="Car 1">

            <div class="car-info">

                <h3>Premium Car</h3>

                <p class="car-description">
                    Comfortable and stylish car for your journey.
                </p>

                <div class="car-bottom">

                    <strong>₹1,200 / day</strong>

                    <a href="${pageContext.request.contextPath}/cars.jsp"
                       class="small-btn">
                        Book Now
                    </a>

                </div>

            </div>

        </div>


        <!-- CAR 2 -->

        <div class="car-card">

            <img src="${pageContext.request.contextPath}/images/car2.jpeg"
                 alt="Car 2">

            <div class="car-info">

                <h3>Family Car</h3>

                <p class="car-description">
                    Spacious and comfortable for family trips.
                </p>

                <div class="car-bottom">

                    <strong>₹1,800 / day</strong>

                    <a href="${pageContext.request.contextPath}/cars.jsp"
                       class="small-btn">
                        Book Now
                    </a>

                </div>

            </div>

        </div>


        <!-- CAR 3 -->

        <div class="car-card">

            <img src="${pageContext.request.contextPath}/images/car3.jpeg"
                 alt="Car 3">

            <div class="car-info">

                <h3>Luxury Car</h3>

                <p class="car-description">
                    Enjoy a premium and comfortable driving experience.
                </p>

                <div class="car-bottom">

                    <strong>₹2,500 / day</strong>

                    <a href="${pageContext.request.contextPath}/cars.jsp"
                       class="small-btn">
                        Book Now
                    </a>

                </div>

            </div>

        </div>


    </div>


    <div class="view-all">

        <a href="${pageContext.request.contextPath}/cars.jsp"
           class="btn primary-btn">
            View All Cars
        </a>

    </div>

</section>


<!-- ================= WHY CHOOSE US ================= -->

<section class="why-section">

    <div class="section-title">

        <span>WHY US</span>

        <h2>Why Choose Car Rental Portal?</h2>

        <p>
            We make your car rental experience simple and convenient.
        </p>

    </div>


    <div class="feature-grid">


        <div class="feature-card">

            <div class="feature-icon">🛡️</div>

            <h3>Safe & Reliable</h3>

            <p>
                Our vehicles are maintained regularly
                for a safe and comfortable journey.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">💰</div>

            <h3>Affordable Prices</h3>

            <p>
                Get quality cars at competitive and
                affordable rental prices.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">⚡</div>

            <h3>Easy Booking</h3>

            <p>
                Select your car and complete your booking
                quickly and easily.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">📞</div>

            <h3>Customer Support</h3>

            <p>
                Our support team is available to help
                you with your rental experience.
            </p>

        </div>


    </div>

</section>


<!-- ================= HOW IT WORKS ================= -->

<section class="how-section">

    <div class="section-title">

        <span>SIMPLE PROCESS</span>

        <h2>How It Works</h2>

    </div>


    <div class="steps">


        <div class="step">

            <div class="step-number">01</div>

            <h3>Choose Your Car</h3>

            <p>
                Browse our available cars and select
                the vehicle you like.
            </p>

        </div>


        <div class="step">

            <div class="step-number">02</div>

            <h3>Make a Booking</h3>

            <p>
                Select your rental dates and complete
                the booking process.
            </p>

        </div>


        <div class="step">

            <div class="step-number">03</div>

            <h3>Enjoy Your Ride</h3>

            <p>
                Pick up your car and enjoy your journey.
            </p>

        </div>


    </div>

</section>


<!-- ================= REVIEWS ================= -->

<section class="reviews-section">

    <div class="section-title">

        <span>CUSTOMER REVIEWS</span>

        <h2>What Our Customers Say</h2>

    </div>


    <div class="review-grid">


        <div class="review-card">

            <div class="stars">
                ★★★★★
            </div>

            <p>
                "The booking process was very easy and
                the car was in excellent condition."
            </p>

            <h3>Rahul</h3>

            <span>Customer</span>

        </div>


        <div class="review-card">

            <div class="stars">
                ★★★★★
            </div>

            <p>
                "Great service and affordable prices.
                I would definitely rent again."
            </p>

            <h3>Priya</h3>

            <span>Customer</span>

        </div>


        <div class="review-card">

            <div class="stars">
                ★★★★☆
            </div>

            <p>
                "Good selection of cars and a smooth
                rental experience."
            </p>

            <h3>Aditya</h3>

            <span>Customer</span>

        </div>


    </div>

</section>


<!-- ================= CALL TO ACTION ================= -->

<section class="cta-section">

    <h2>Ready to Start Your Journey?</h2>

    <p>
        Find your perfect car and hit the road today.
    </p>

    <a href="${pageContext.request.contextPath}/cars.jsp"
       class="cta-btn">
        Browse Cars
    </a>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-content">

        <h2>Car Rental Portal</h2>

        <p>
            Rent your dream car easily and affordably.
        </p>

        <div class="footer-links">

            <a href="${pageContext.request.contextPath}/index.jsp">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/cars.jsp">
                Cars
            </a>

            <a href="${pageContext.request.contextPath}/about.jsp">
                About
            </a>

            <a href="${pageContext.request.contextPath}/login.jsp">
                Login
            </a>

            <a href="${pageContext.request.contextPath}/register.jsp">
                Register
            </a>

        </div>

        <p class="copyright">
            © 2026 Car Rental Portal | All Rights Reserved
        </p>

    </div>

</footer>


</body>
</html>