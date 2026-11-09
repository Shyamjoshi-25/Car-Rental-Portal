<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Payment,model.Booking,model.Car,dao.PaymentDAO,dao.BookingDAO,dao.CarDAO" %>
<%
    User user=(User)session.getAttribute("user");
    if(user==null){response.sendRedirect("login.jsp");return;}
    Payment payment=null; Booking booking=null; Car car=null;
    String type=request.getParameter("type");
    try {
        int paymentId=Integer.parseInt(request.getParameter("paymentId"));
        payment=new PaymentDAO().getPaymentById(paymentId);
        if(payment!=null){
            booking=new BookingDAO().getBookingById(payment.getBookingId());
            if(booking!=null && booking.getUserId()==user.getUserId()) car=new CarDAO().getCarById(booking.getCarId());
            else { payment=null; booking=null; }
        }
    } catch(Exception ignored) {}
    if(payment==null || booking==null){ response.sendRedirect("bookingHistory.jsp"); return; }
    double total=booking.getTotalAmount();
    double paid=new PaymentDAO().getPaidTotal(booking.getBookingId());
    double remaining=Math.max(0,total-paid);
    String title="final".equalsIgnoreCase(type)?"Final Payment Successful":"Booking Advance Payment Successful";
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Payment Successful</title>
<style>body{font-family:Arial,sans-serif;background:#f4f6f8;margin:0;color:#1f2937}.top{background:#1f4e79;color:#fff;padding:22px;text-align:center}.nav{background:#222;text-align:center;padding:12px}.nav a{color:#fff;text-decoration:none;margin:0 10px}.receipt{max-width:700px;margin:35px auto;background:#fff;border-radius:14px;box-shadow:0 4px 18px #ccc;overflow:hidden}.success{background:#e8f5e9;padding:28px;text-align:center;color:#176b2d}.check{font-size:48px}.content{padding:28px}.row{display:flex;justify-content:space-between;gap:20px;padding:12px 0;border-bottom:1px solid #eee}.row b:last-child{text-align:right}.txn{background:#f0f7ff;border:1px dashed #1f4e79;border-radius:8px;padding:14px;margin:20px 0;text-align:center}.txn strong{font-size:20px;letter-spacing:1px}.summary{background:#f8fafc;border-radius:9px;padding:15px;margin-top:20px}.btn{display:inline-block;background:#1f4e79;color:#fff;padding:11px 16px;border-radius:7px;text-decoration:none;margin:8px 5px 0 0;border:0;cursor:pointer}.actions{text-align:center;margin-top:20px}@media print{.nav,.actions{display:none}.receipt{box-shadow:none;margin:0;width:100%}}</style><link rel="stylesheet" href="css/ui.css">
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
<body><div class="top"><h1>Car Rental Portal</h1><p>Payment Confirmation</p></div><div class="nav"><a href="dashboard.jsp">Dashboard</a><a href="cars.jsp">Cars</a><a href="bookingHistory.jsp">My Bookings</a><a href="profile">My Profile</a></div>
<div class="receipt"><div class="flow" style="padding:18px 18px 0"><div class="flow-step done"><div class="dot">✓</div>Choose car</div><div class="flow-step done"><div class="dot">✓</div>Booking</div><div class="flow-step done"><div class="dot">✓</div>Payment</div><div class="flow-step active"><div class="dot">4</div>Confirmation</div><div class="flow-step"><div class="dot">5</div>Invoice</div></div><div class="success"><div class="check">✓</div><h2><%=title%></h2><p>Your payment has been recorded successfully.</p></div><div class="content">
<div class="row"><span>Booking ID</span><b>#<%=booking.getBookingId()%></b></div>
<div class="row"><span>Car</span><b><%=car==null?"Car":car.getCarName()%></b></div>
<div class="row"><span>Payment Type</span><b><%="final".equalsIgnoreCase(type)?"Final Payment":"Booking Advance (20%)"%></b></div>
<div class="row"><span>Amount Paid</span><b>₹<%=String.format("%.2f",payment.getAmount())%></b></div>
<div class="row"><span>Payment Method</span><b><%=payment.getPaymentMethod()%></b></div>
<div class="row"><span>Payment Status</span><b><%=payment.getPaymentStatus()%></b></div>
<div class="row"><span>Payment Date</span><b><%=payment.getPaymentDate()%></b></div>
<div class="txn"><div>Transaction ID</div><strong><%=payment.getTransactionId()%></strong></div>
<div class="summary"><div class="row"><span>Total Rental Amount</span><b>₹<%=String.format("%.2f",total)%></b></div><div class="row"><span>Total Paid</span><b>₹<%=String.format("%.2f",paid)%></b></div><div class="row"><span>Remaining</span><b>₹<%=String.format("%.2f",remaining)%></b></div><div class="row"><span>Booking Status</span><b><%=booking.getBookingStatus()%></b></div></div>
<div class="actions"><a class="btn" href="bookingHistory.jsp">View My Booking</a><a class="btn" href="payment-details.jsp?bookingId=<%=booking.getBookingId()%>">Payment Details</a><button class="btn" onclick="window.print()">Print Receipt</button></div>
</div></div></body></html>