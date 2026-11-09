<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Booking,model.Car,dao.BookingDAO,dao.CarDAO,dao.PaymentDAO,java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Load the logged-in customer's bookings directly so this page also works
    // when opened from a normal JSP link (not only through a servlet).
    List<Booking> bookings = new BookingDAO().getBookingsByUserId(user.getUserId());
    CarDAO carDAO = new CarDAO();
    PaymentDAO paymentDAO = new PaymentDAO();
    String message = request.getParameter("payment");
    if (message == null) message = request.getParameter("cancel");
    if (message == null) message = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Bookings - Car Rental Portal</title>
<style>
    *{box-sizing:border-box}
    body{
        margin:0;
        font-family:"Segoe UI",Arial,sans-serif;
        background:#f7f8fb;
        color:#263246;
    }
    .topbar{
        background:#202124;
        color:#fff;
        padding:28px 8%;
    }
    .topbar h1{
        margin:0 0 7px;
        font-size:27px;
        font-weight:600;
    }
    .breadcrumb{
        color:#c7cad0;
        font-size:14px;
    }
    .breadcrumb a{
        color:#c7cad0;
        text-decoration:none;
    }
    .breadcrumb a:hover{text-decoration:underline}
    .page{
        width:88%;
        max-width:1250px;
        margin:42px auto 70px;
    }
    .page-title{
        margin:0 0 25px;
        font-size:28px;
        color:#1f2937;
        font-weight:700;
    }
    .message{
        background:#e9f7ef;
        color:#176b3a;
        border:1px solid #ccebd8;
        border-radius:7px;
        padding:12px 15px;
        margin-bottom:18px;
    }
    .table-card{
        background:#fff;
        border-radius:8px;
        box-shadow:0 3px 16px rgba(0,0,0,.08);
        overflow:hidden;
    }
    table{
        width:100%;
        border-collapse:collapse;
    }
    th{
        background:#fff;
        color:#172033;
        text-align:left;
        font-size:15px;
        font-weight:700;
        padding:22px 20px;
        border-bottom:1px solid #e8ebef;
        white-space:nowrap;
    }
    td{
        padding:21px 20px;
        border-bottom:1px solid #edf0f3;
        font-size:15px;
        vertical-align:middle;
    }
    tr:last-child td{border-bottom:0}
    .booking-id{font-weight:700;color:#374151}
    .car-name{font-weight:600;color:#263246}
    .amount{font-weight:600;white-space:nowrap}
    .status{
        display:inline-block;
        padding:6px 11px;
        border-radius:20px;
        font-size:13px;
        font-weight:700;
        white-space:nowrap;
    }
    .status.upcoming{background:#eaf2ff;color:#2467c6}
    .status.booked{background:#eaf2ff;color:#2467c6}
    .status.delivered{background:#fff3df;color:#a56200}
    .status.completed{background:#e7f7ee;color:#18864b}
    .status.cancelled{background:#fdeaea;color:#c33b3b}
    .payment-note{
        display:block;
        margin-top:6px;
        font-size:12px;
        color:#727b88;
    }
    .payment-note.due{color:#b26a00;font-weight:600}
    .action-cell{min-width:210px}
    .btn{
        display:inline-block;
        padding:8px 13px;
        border-radius:5px;
        text-decoration:none;
        font-size:13px;
        font-weight:600;
        margin:2px 5px 2px 0;
        border:1px solid #1f4e79;
        color:#1f4e79;
        background:#fff;
    }
    .btn.primary{background:#1f4e79;color:#fff}
    .btn.danger{border-color:#c33b3b;color:#c33b3b}
    .cancel-form{display:inline}
    .empty{
        background:#fff;
        text-align:center;
        padding:65px 25px;
        border-radius:8px;
        box-shadow:0 3px 16px rgba(0,0,0,.08);
    }
    .empty h2{margin:0 0 10px;color:#263246}
    .empty p{color:#6b7280;margin:0 0 22px}
    .bottom-nav{text-align:center;margin-top:28px}
    .bottom-nav a{color:#1f4e79;text-decoration:none;margin:0 9px;font-size:14px}
    @media(max-width:900px){
        .page{width:96%;margin-top:25px}
        .table-card{overflow-x:auto}
        table{min-width:1000px}
        .topbar{padding:24px 5%}
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

<div class="topbar">
    <h1>My Bookings</h1>
    <div class="breadcrumb"><a href="dashboard.jsp">Home</a> &nbsp;›&nbsp; My Bookings</div>
</div>

<div class="page">
    <h2 class="page-title">Booking History</h2>

    <% if ("success".equalsIgnoreCase(message)) { %>
        <div class="message">Your request was processed successfully.</div>
    <% } %>

    <% if (bookings == null || bookings.isEmpty()) { %>
        <div class="empty">
            <h2>No bookings yet</h2>
            <p>Your confirmed and past car bookings will appear here.</p>
            <a class="btn primary" href="cars.jsp">Browse Cars</a>
        </div>
    <% } else { %>
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Car</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Booking b : bookings) {
                    Car car = carDAO.getCarById(b.getCarId());
                    double paid = paymentDAO.getPaidTotal(b.getBookingId());
                    double remaining = Math.max(0, b.getTotalAmount() - paid);
                    String status = b.getBookingStatus() == null ? "Pending" : b.getBookingStatus();
                    String statusClass = status.toLowerCase().replace(" ", "");
                    if ("pending".equals(statusClass)) statusClass = "upcoming";
                    String paymentText;
                    boolean advanceDue = "Pending".equalsIgnoreCase(status) && paid < 0.01;
                    boolean finalDue = "Delivered".equalsIgnoreCase(status) && remaining > 0.01;
                    if (advanceDue) paymentText = "Advance payment due (20%)";
                    else if (finalDue) paymentText = "Final payment due";
                    else if (remaining <= 0.01) paymentText = "Fully paid";
                    else paymentText = "Advance paid";
                %>
                    <tr>
                        <td class="booking-id">#BK<%= b.getBookingId() %></td>
                        <td class="car-name"><%= car == null ? "Car not found" : car.getCarName() %></td>
                        <td><%= b.getPickupDate() %></td>
                        <td><%= b.getReturnDate() %></td>
                        <td class="amount">₹<%= String.format("%.2f", b.getTotalAmount()) %></td>
                        <td>
                            <span class="status <%= statusClass %>"><%= status %></span>
                            <span class="payment-note <%= (advanceDue || finalDue) ? "due" : "" %>">
                                <%= paymentText %>
                            </span>
                        </td>
                        <td class="action-cell">
                            <a class="btn" href="rental-agreement?bookingId=<%= b.getBookingId() %>">View</a>
                            <a class="btn" href="payment-details.jsp?bookingId=<%= b.getBookingId() %>">Payment Details</a>
                            <a class="btn" href="invoice?bookingId=<%= b.getBookingId() %>">Download Invoice</a>

                            <% if (advanceDue) { %>
                                <a class="btn primary" href="payment.jsp?bookingId=<%= b.getBookingId() %>">Pay Advance</a>
                            <% } else if (finalDue) { %>
                                <a class="btn primary" href="payment.jsp?bookingId=<%= b.getBookingId() %>">Pay Final</a>
                            <% } %>

                            <% if ("Pending".equalsIgnoreCase(status) || "Booked".equalsIgnoreCase(status)) { %>
                                <details><summary>Modify Dates</summary><form action="modify-booking" method="post"><input type="hidden" name="bookingId" value="<%=b.getBookingId()%>"><label>Pickup <input type="date" name="pickupDate" value="<%=b.getPickupDate()%>" required></label><label>Return <input type="date" name="returnDate" value="<%=b.getReturnDate()%>" required></label><button class="btn primary" type="submit">Save Changes</button></form></details>
                                <form class="cancel-form" action="BookingServlet" method="post">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                                    <button class="btn danger" type="submit" onclick="return confirm('Cancel this booking?')">Cancel</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    <% } %>

    <div class="bottom-nav">
        <a href="dashboard.jsp">Home</a>
        <a href="cars.jsp">Cars</a>
        <a href="cart">Cart</a>
        <a href="support">Support</a>
        <a href="payment-history">Payment History</a>
        <a href="bookingHistory.jsp">My Bookings</a>
    <a href="cart">My Cart</a>
    <a href="support">Customer Support</a>
    <a href="payment-history">Payment History</a>
        <a href="payment.jsp">Payment</a>
        <a href="profile">My Profile</a>
        <a href="logout">Logout</a>
    </div>
</div>
</body>
</html>
