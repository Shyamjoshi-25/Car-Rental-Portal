<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="model.User" %>
<%@ page import="model.Booking" %>
<%@ page import="model.Car" %>

<%
    // ==========================================
    // GET DATA FROM SERVLET
    // ==========================================

    User user = (User) request.getAttribute("user");
    Booking booking = (Booking) request.getAttribute("booking");
    Car car = (Car) request.getAttribute("car");


    // ==========================================
    // CHECK DATA
    // ==========================================

    if (user == null || booking == null || car == null) {

        response.sendRedirect("dashboard.jsp");

        return;
    }


    // ==========================================
    // USER INFORMATION
    // ==========================================

    String fullName = user.getFullName() != null
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
            : "Not provided";


    // ==========================================
    // BOOKING INFORMATION
    // ==========================================

    int bookingId = booking.getBookingId();

    String pickupDate = booking.getPickupDate() != null
            ? booking.getPickupDate()
            : "";

    String returnDate = booking.getReturnDate() != null
            ? booking.getReturnDate()
            : "";

    double totalAmount = booking.getTotalAmount();

    String bookingStatus = booking.getBookingStatus() != null
            ? booking.getBookingStatus()
            : "Pending";


    // ==========================================
    // CAR INFORMATION
    // ==========================================

    String carName = car.getCarName() != null
            ? car.getCarName()
            : "";

    String brand = car.getBrand() != null
            ? car.getBrand()
            : "";

    String model = car.getModel() != null
            ? car.getModel()
            : "";

    String fuelType = car.getFuelType() != null
            ? car.getFuelType()
            : "";

    double pricePerDay = car.getPricePerDay();


    // ==========================================
    // AGREEMENT NUMBER
    // ==========================================

    String agreementNumber =
            "RA-" + bookingId;


    // ==========================================
    // INITIALS
    // ==========================================

    String initial = "U";

    if (fullName != null && !fullName.trim().isEmpty()) {

        String[] nameParts =
                fullName.trim().split("\\s+");

        if (nameParts.length >= 2) {

            initial =
                    nameParts[0].substring(0, 1)
                    + nameParts[nameParts.length - 1]
                      .substring(0, 1);

        } else {

            initial =
                    nameParts[0].substring(0, 1);
        }

        initial = initial.toUpperCase();
    }
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Rental Agreement - Car Rental Portal
</title>


<style>

/* ==========================================
   GENERAL
   ========================================== */

* {
    box-sizing: border-box;
}

body {

    margin: 0;

    padding: 30px 15px;

    font-family: Arial, Helvetica, sans-serif;

    background: #f2f4f7;

    color: #333;
}


/* ==========================================
   TOP BUTTONS
   ========================================== */

.top-bar {

    width: 100%;

    max-width: 950px;

    margin: 0 auto 20px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 10px;
}


.btn {

    display: inline-block;

    padding: 11px 18px;

    border-radius: 6px;

    text-decoration: none;

    border: none;

    cursor: pointer;

    font-size: 14px;

    font-weight: bold;
}


.dashboard-btn {

    background: #1f4e79;

    color: white;
}


.dashboard-btn:hover {

    background: #163a5c;
}


.print-btn {

    background: #198754;

    color: white;
}


.print-btn:hover {

    background: #146c43;
}


/* ==========================================
   AGREEMENT PAPER
   ========================================== */

.agreement {

    max-width: 950px;

    margin: auto;

    background: white;

    padding: 45px;

    border-radius: 8px;

    box-shadow: 0 3px 18px rgba(0,0,0,0.15);
}


/* ==========================================
   HEADER
   ========================================== */

.header {

    text-align: center;

    border-bottom: 3px solid #1f4e79;

    padding-bottom: 20px;

    margin-bottom: 25px;
}


.header h1 {

    margin: 0;

    color: #1f4e79;

    font-size: 30px;
}


.header h2 {

    margin: 8px 0;

    color: #333;

    font-size: 21px;
}


.header p {

    margin: 5px 0;

    color: #777;

    font-size: 14px;
}


/* ==========================================
   AGREEMENT DETAILS
   ========================================== */

.agreement-details {

    display: flex;

    justify-content: space-between;

    gap: 20px;

    margin-bottom: 25px;
}


.detail-box {

    width: 50%;

    background: #f7f9fb;

    border: 1px solid #ddd;

    border-radius: 6px;

    padding: 15px;
}


.detail-box strong {

    color: #1f4e79;
}


/* ==========================================
   SECTION
   ========================================== */

.section {

    margin-top: 28px;
}


.section-title {

    background: #1f4e79;

    color: white;

    padding: 11px 15px;

    border-radius: 5px 5px 0 0;

    font-size: 17px;

    font-weight: bold;
}


/* ==========================================
   TABLE
   ========================================== */

.info-table {

    width: 100%;

    border-collapse: collapse;

    border: 1px solid #ddd;
}


.info-table td {

    border: 1px solid #ddd;

    padding: 12px;

    font-size: 14px;
}


.info-table td:first-child {

    width: 35%;

    background: #f7f7f7;

    color: #1f4e79;

    font-weight: bold;
}


.total-row td {

    font-size: 17px;

    font-weight: bold;

    background: #eef4f9;
}


/* ==========================================
   STATUS
   ========================================== */

.status {

    display: inline-block;

    padding: 6px 12px;

    border-radius: 20px;

    background: #e7f5ec;

    color: #198754;

    font-weight: bold;

    font-size: 13px;
}


/* ==========================================
   TERMS
   ========================================== */

.terms {

    padding: 15px 20px;

    line-height: 1.7;

    border: 1px solid #ddd;

    border-top: none;

    margin: 0;
}


.terms li {

    margin-bottom: 8px;
}


/* ==========================================
   DECLARATION
   ========================================== */

.declaration {

    border: 1px solid #ddd;

    border-top: none;

    padding: 18px;

    line-height: 1.7;

    font-size: 14px;
}


/* ==========================================
   SIGNATURES
   ========================================== */

.signatures {

    display: flex;

    justify-content: space-between;

    gap: 60px;

    margin-top: 70px;
}


.signature {

    width: 45%;

    text-align: center;
}


.signature-space {

    height: 55px;
}


.signature-line {

    border-top: 1px solid #333;

    margin-bottom: 8px;
}


.signature p {

    margin: 4px;

    font-size: 14px;
}


/* ==========================================
   FOOTER
   ========================================== */

.footer {

    text-align: center;

    border-top: 1px solid #ddd;

    margin-top: 45px;

    padding-top: 15px;

    color: #777;

    font-size: 12px;
}


/* ==========================================
   MOBILE
   ========================================== */

@media (max-width: 650px) {

    body {

        padding: 10px;
    }


    .agreement {

        padding: 20px 15px;
    }


    .header h1 {

        font-size: 23px;
    }


    .header h2 {

        font-size: 18px;
    }


    .agreement-details {

        flex-direction: column;
    }


    .detail-box {

        width: 100%;
    }


    .info-table td {

        padding: 9px;

        font-size: 13px;
    }


    .signatures {

        flex-direction: column;

        gap: 50px;
    }


    .signature {

        width: 100%;
    }

}


/* ==========================================
   PRINT
   ========================================== */

@media print {

    body {

        background: white;

        padding: 0;
    }


    .top-bar {

        display: none;
    }


    .agreement {

        width: 100%;

        max-width: 100%;

        padding: 20px;

        box-shadow: none;

        border-radius: 0;
    }

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


<!-- ==========================================
     TOP BUTTONS
     ========================================== -->

<div class="top-bar">

    <a href="dashboard.jsp"
       class="btn dashboard-btn">

        ← Back to Dashboard

    </a>


    <button
        type="button"
        onclick="window.print()"
        class="btn print-btn">

        🖨 Print Agreement

    </button>

</div>


<!-- ==========================================
     AGREEMENT
     ========================================== -->

<div class="agreement">


    <!-- ======================================
         HEADER
         ====================================== -->

    <div class="header">

        <h1>
            CAR RENTAL PORTAL
        </h1>

        <h2>
            VEHICLE RENTAL AGREEMENT
        </h2>

        <p>
            Official Rental Agreement
        </p>

    </div>


    <!-- ======================================
         AGREEMENT DETAILS
         ====================================== -->

    <div class="agreement-details">

        <div class="detail-box">

            <strong>
                Agreement Number
            </strong>

            <br><br>

            <%= agreementNumber %>

        </div>


        <div class="detail-box">

            <strong>
                Booking Number
            </strong>

            <br><br>

            BK-<%= bookingId %>

        </div>

    </div>


    <!-- ======================================
         CUSTOMER INFORMATION
         ====================================== -->

    <div class="section">

        <div class="section-title">

            1. Renter Information

        </div>


        <table class="info-table">

            <tr>

                <td>
                    Full Name
                </td>

                <td>
                    <%= fullName %>
                </td>

            </tr>


            <tr>

                <td>
                    Email
                </td>

                <td>
                    <%= email %>
                </td>

            </tr>


            <tr>

                <td>
                    Phone
                </td>

                <td>
                    <%= phone %>
                </td>

            </tr>


            <tr>

                <td>
                    Address
                </td>

                <td>
                    <%= address %>
                </td>

            </tr>

        </table>

    </div>


    <!-- ======================================
         VEHICLE INFORMATION
         ====================================== -->

    <div class="section">

        <div class="section-title">

            2. Vehicle Information

        </div>


        <table class="info-table">

            <tr>

                <td>
                    Car Name
                </td>

                <td>
                    <%= carName %>
                </td>

            </tr>


            <tr>

                <td>
                    Brand
                </td>

                <td>
                    <%= brand %>
                </td>

            </tr>


            <tr>

                <td>
                    Model
                </td>

                <td>
                    <%= model %>
                </td>

            </tr>


            <tr>

                <td>
                    Fuel Type
                </td>

                <td>
                    <%= fuelType %>
                </td>

            </tr>


            <tr>

                <td>
                    Rental Price Per Day
                </td>

                <td>
                    ₹<%= String.format("%.2f", pricePerDay) %>
                </td>

            </tr>

        </table>

    </div>


    <!-- ======================================
         RENTAL PERIOD
         ====================================== -->

    <div class="section">

        <div class="section-title">

            3. Rental Period

        </div>


        <table class="info-table">

            <tr>

                <td>
                    Pickup Date
                </td>

                <td>
                    <%= pickupDate %>
                </td>

            </tr>


            <tr>

                <td>
                    Return Date
                </td>

                <td>
                    <%= returnDate %>
                </td>

            </tr>


            <tr>

                <td>
                    Booking Status
                </td>

                <td>

                    <span class="status">

                        <%= bookingStatus %>

                    </span>

                </td>

            </tr>

        </table>

    </div>


    <!-- ======================================
         PAYMENT INFORMATION
         ====================================== -->

    <div class="section">

        <div class="section-title">

            4. Rental Charges

        </div>


        <table class="info-table">

            <tr>

                <td>
                    Price Per Day
                </td>

                <td>
                    ₹<%= String.format("%.2f", pricePerDay) %>
                </td>

            </tr>


            <tr class="total-row">

                <td>
                    Total Rental Amount
                </td>

                <td>
                    ₹<%= String.format("%.2f", totalAmount) %>
                </td>

            </tr>

        </table>

    </div>


    <!-- ======================================
         TERMS
         ====================================== -->

    <div class="section">

        <div class="section-title">

            5. Terms and Conditions

        </div>


        <ol class="terms">

            <li>
                The renter confirms that the information
                provided in this agreement is accurate.
            </li>


            <li>
                The renter agrees to use the rented vehicle
                responsibly and in accordance with applicable
                traffic and transportation laws.
            </li>


            <li>
                The vehicle must not be used for unlawful
                purposes, racing, or any prohibited activity.
            </li>


            <li>
                The vehicle must be returned on or before
                the agreed return date.
            </li>


            <li>
                Late return of the vehicle may result in
                additional rental charges according to the
                applicable rental policy.
            </li>


            <li>
                The renter must report any accident, damage,
                theft, or mechanical problem to the rental
                company as soon as reasonably possible.
            </li>


            <li>
                The renter may be responsible for permitted
                damage, traffic fines, penalties, or other
                charges resulting from the renter's use of
                the vehicle.
            </li>


            <li>
                The vehicle should be returned in substantially
                the same condition as when it was collected,
                allowing for normal wear and tear.
            </li>


            <li>
                Any extension or modification of the rental
                period is subject to the applicable rental
                policy.
            </li>


            <li>
                The renter agrees to follow all applicable
                terms and conditions of the Car Rental Portal.
            </li>

        </ol>

    </div>


    <!-- ======================================
         DECLARATION
         ====================================== -->

    <div class="section">

        <div class="section-title">

            6. Declaration

        </div>


        <div class="declaration">

            I, <strong><%= fullName %></strong>, confirm that
            I have read and understood this vehicle rental
            agreement and agree to comply with the terms and
            conditions stated above.

            I acknowledge responsibility for the rented
            vehicle during the rental period, subject to
            applicable law and the rental company's policies.

        </div>

    </div>


    <!-- ======================================
         SIGNATURES
         ====================================== -->

    <div class="signatures">


        <div class="signature">

            <div class="signature-space"></div>

            <div class="signature-line"></div>

            <p>
                <strong>
                    Renter Signature
                </strong>
            </p>

            <p>
                <%= fullName %>
            </p>

            <p>
                Date: __________________
            </p>

        </div>


        <div class="signature">

            <div class="signature-space"></div>

            <div class="signature-line"></div>

            <p>
                <strong>
                    Authorized Representative
                </strong>
            </p>

            <p>
                Car Rental Portal
            </p>

            <p>
                Date: __________________
            </p>

        </div>


    </div>


    <!-- ======================================
         FOOTER
         ====================================== -->

    <div class="footer">

        Car Rental Portal |
        Vehicle Rental Agreement |
        &copy; 2026

        <br><br>

        This document is a project template and should
        be reviewed for legal compliance before real-world use.

    </div>


</div>


</body>

</html>