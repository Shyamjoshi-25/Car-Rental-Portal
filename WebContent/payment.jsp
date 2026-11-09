<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Booking,dao.BookingDAO,dao.PaymentDAO,java.util.List" %>
<%
 User user=(User)session.getAttribute("user");
 if(user==null){response.sendRedirect("login.jsp");return;}
 List<Booking> bookings=new BookingDAO().getBookingsByUserId(user.getUserId());
 PaymentDAO paymentDAO=new PaymentDAO();
 String error=(String)request.getAttribute("error");
 String selected=request.getParameter("bookingId");
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Payments - Car Rental Portal</title>
<style>body{font-family:Arial;background:#f4f6f8;margin:0;color:#1f2937}.top{background:#1f4e79;color:#fff;padding:20px;text-align:center}.nav{background:#333;text-align:center;padding:12px}.nav a{color:#fff;text-decoration:none;margin:0 12px}.box{width:560px;max-width:92%;margin:35px auto;background:#fff;padding:28px;border-radius:12px;box-shadow:0 3px 15px #ccc}h1{text-align:center;color:#1f4e79}label{font-weight:bold;display:block;margin-top:14px}select,input{width:100%;box-sizing:border-box;padding:11px;margin-top:6px;border:1px solid #ccc;border-radius:6px}button{width:100%;padding:12px;margin-top:20px;background:#1f4e79;color:#fff;border:0;border-radius:6px;font-size:16px}.info{background:#eef5fb;padding:15px;border-radius:7px;margin-top:15px;line-height:1.6}.success{background:#e8f5e9;color:#176b2d;padding:12px;border-radius:7px}.err{color:#c62828}.due{font-weight:bold;color:#176b2d}.links{text-align:center;margin-top:18px}</style><link rel="stylesheet" href="css/ui.css">
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
<body><div class="top"><h1>Car Rental Portal</h1><p>Payments</p></div><div class="nav"><a href="index.jsp">Home</a><a href="dashboard.jsp">Dashboard</a><a href="cars.jsp">Cars</a><a href="bookingHistory.jsp">My Bookings</a>
    <a href="cart">My Cart</a>
    <a href="support">Customer Support</a>
    <a href="payment-history">Payment History</a><a href="profile">My Profile</a><a href="logout">Logout</a></div>
<div class="box"><div class="flow"><div class="flow-step done"><div class="dot">✓</div>Choose car</div><div class="flow-step done"><div class="dot">✓</div>Booking</div><div class="flow-step active"><div class="dot">3</div>Advance</div><div class="flow-step"><div class="dot">4</div>Confirmation</div><div class="flow-step"><div class="dot">5</div>Invoice</div></div><h1>Payment</h1>
<%if(error!=null){%><p class="err"><%=error%></p><%}%>
<div class="info"><b>Payment process:</b><br>1. Pay <b>20% booking advance</b> after creating a booking.<br>2. When the admin delivers the car, the <b>remaining balance</b> becomes payable.<br>3. After the final payment, the booking is marked <b>Fully Paid / Completed</b>.</div>
<form action="PaymentServlet" method="post">
<label>Booking</label><select id="bookingId" name="bookingId" required><option value="">Select a payment due</option>
<% for(Booking b:bookings){ double paid=paymentDAO.getPaidTotal(b.getBookingId()); double remaining=Math.max(0,b.getTotalAmount()-paid); boolean advanceDue="Pending".equalsIgnoreCase(b.getBookingStatus()) && paid<0.01; boolean finalDue="Delivered".equalsIgnoreCase(b.getBookingStatus()) && remaining>0.01; if(advanceDue||finalDue){ String label=advanceDue?"Booking Advance (20%)":"Final Payment (after delivery)"; double due=advanceDue?Math.round(b.getTotalAmount()*0.20*100.0)/100.0:remaining; if(due<=0) due=b.getTotalAmount(); %>
<option value="<%=b.getBookingId()%>" data-amount="<%=String.format("%.2f",due)%>" <%=String.valueOf(b.getBookingId()).equals(selected)?"selected":""%>>Booking #<%=b.getBookingId()%> - <%=label%> - ₹<%=String.format("%.2f",due)%></option>
<% }} %></select>
<label>Amount Due (₹)</label><input id="amount" name="amount" type="number" step="0.01" readonly required>
<label>Payment Method</label><select name="paymentMethod" required><option value="UPI">UPI</option><option value="Credit Card">Credit Card</option><option value="Debit Card">Debit Card</option><option value="Cash">Cash</option></select>
<button type="submit">Pay Booking Advance / Final Amount</button></form>
<div class="links"><a href="bookingHistory.jsp">View Payment Status</a></div></div>
<script>const s=document.getElementById('bookingId'),a=document.getElementById('amount');function setAmount(){a.value=s.options[s.selectedIndex].dataset.amount||''}s.addEventListener('change',setAmount);setAmount();</script></body></html>
