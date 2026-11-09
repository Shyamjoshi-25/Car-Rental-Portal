<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User,model.Payment,model.Booking,dao.PaymentDAO,dao.BookingDAO,java.util.List" %>
<%
 User user=(User)session.getAttribute("user"); if(user==null){response.sendRedirect("login.jsp");return;}
 Booking booking=null; List<Payment> payments=new java.util.ArrayList<>();
 try { int bookingId=Integer.parseInt(request.getParameter("bookingId")); booking=new BookingDAO().getBookingById(bookingId); if(booking!=null && booking.getUserId()==user.getUserId()) payments=new PaymentDAO().getPaymentsByBooking(bookingId); else booking=null; } catch(Exception ignored) {}
 if(booking==null){response.sendRedirect("bookingHistory.jsp");return;}
 double paid=new PaymentDAO().getPaidTotal(booking.getBookingId()); double remaining=Math.max(0,booking.getTotalAmount()-paid);
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Payment Details</title>
<style>body{font-family:Arial;background:#f4f6f8;margin:0;color:#222}.top{background:#1f4e79;color:white;padding:22px;text-align:center}.nav{background:#222;padding:12px;text-align:center}.nav a{color:white;text-decoration:none;margin:0 10px}.box{max-width:900px;margin:30px auto;background:white;padding:28px;border-radius:14px;box-shadow:0 3px 15px #ccc}.summary{display:flex;flex-wrap:wrap;gap:12px;margin-bottom:25px}.stat{flex:1;min-width:170px;background:#f3f7fb;padding:16px;border-radius:8px}.stat b{display:block;font-size:20px;margin-top:5px}.success{color:#176b2d;font-weight:bold}table{width:100%;border-collapse:collapse}th,td{padding:12px;border-bottom:1px solid #ddd;text-align:left}th{background:#eef2f6}.txn{font-family:monospace;font-weight:bold}.btn{display:inline-block;margin-top:20px;background:#1f4e79;color:white;text-decoration:none;padding:10px 15px;border-radius:7px}</style><link rel="stylesheet" href="css/ui.css">
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
<style>
/* Payment Details page only: isolate layout from shared/global CSS overrides. */
body.payment-details-page{min-height:100vh!important;overflow-x:hidden!important}
body.payment-details-page .top{display:block!important;width:100%!important;box-sizing:border-box!important;text-align:center!important}
body.payment-details-page .nav{display:flex!important;justify-content:center!important;align-items:center!important;flex-wrap:wrap!important;gap:8px!important;box-sizing:border-box!important;width:100%!important}
body.payment-details-page .nav a{display:inline-flex!important;align-items:center!important;justify-content:center!important;margin:0!important;padding:10px 14px!important;white-space:nowrap!important;color:#fff!important;text-decoration:none!important}
body.payment-details-page .nav a:hover,body.payment-details-page .nav a:focus{color:#fff!important;background:#315f88!important}
body.payment-details-page .box{display:block!important;float:none!important;position:relative!important;width:min(900px,calc(100% - 40px))!important;max-width:900px!important;min-width:0!important;margin:30px auto!important;padding:clamp(18px,3vw,28px)!important;box-sizing:border-box!important;background:#fff!important;border-radius:14px!important}
body.payment-details-page .box h2{margin:0 0 22px!important;line-height:1.3!important;overflow-wrap:anywhere!important}
body.payment-details-page .summary{display:grid!important;grid-template-columns:repeat(2,minmax(0,1fr))!important;gap:12px!important;width:100%!important;box-sizing:border-box!important}
body.payment-details-page .stat{min-width:0!important;width:auto!important;box-sizing:border-box!important;overflow-wrap:anywhere!important}
body.payment-details-page .stat b{overflow-wrap:anywhere!important}
body.payment-details-page .payment-table-wrap{width:100%!important;max-width:100%!important;overflow-x:auto!important;-webkit-overflow-scrolling:touch!important;border-radius:8px!important}
body.payment-details-page .payment-table-wrap table{width:100%!important;min-width:620px!important;border-collapse:collapse!important}
body.payment-details-page .payment-table-wrap th{background:#1f4e79!important;color:#fff!important;white-space:nowrap!important}
body.payment-details-page .payment-table-wrap td{overflow-wrap:anywhere!important}
body.payment-details-page .btn{max-width:100%!important;box-sizing:border-box!important;white-space:normal!important}
@media(max-width:600px){
 body.payment-details-page .box{width:calc(100% - 24px)!important;margin:18px auto!important;padding:16px!important}
 body.payment-details-page .summary{grid-template-columns:repeat(2,minmax(0,1fr))!important;gap:10px!important}
 body.payment-details-page .stat{padding:12px!important}
 body.payment-details-page .stat b{font-size:1.05rem!important}
 body.payment-details-page .nav{justify-content:flex-start!important}
 body.payment-details-page .nav a{padding:9px 10px!important}
}
@media(max-width:360px){body.payment-details-page .summary{grid-template-columns:minmax(0,1fr)!important}}
</style>
</head>
<body class="payment-details-page"><div class="top"><h1>Car Rental Portal</h1><p>Payment Details</p></div><div class="nav"><a href="dashboard.jsp">Dashboard</a><a href="cars.jsp">Cars</a><a href="bookingHistory.jsp">My Bookings</a><a href="profile">My Profile</a></div>
<div class="box"><h2>Payment Details — Booking #<%=booking.getBookingId()%></h2><div class="summary"><div class="stat">Total Rental<b>₹<%=String.format("%.2f",booking.getTotalAmount())%></b></div><div class="stat">Total Paid<b>₹<%=String.format("%.2f",paid)%></b></div><div class="stat">Remaining<b>₹<%=String.format("%.2f",remaining)%></b></div><div class="stat">Status<b><%=booking.getBookingStatus()%></b></div></div>
<%if(payments.isEmpty()){%><p>No payment has been made yet.</p><%}else{%><div class="payment-table-wrap"><table><thead><tr><th>Transaction ID</th><th>Amount</th><th>Method</th><th>Status</th><th>Date</th></tr></thead><tbody><%for(Payment p:payments){%><tr><td class="txn"><%=p.getTransactionId()%></td><td>₹<%=String.format("%.2f",p.getAmount())%></td><td><%=p.getPaymentMethod()%></td><td class="success"><%=p.getPaymentStatus()%></td><td><%=p.getPaymentDate()%></td></tr><%}%></tbody></table></div><%}%><a class="btn" href="bookingHistory.jsp">← Back to My Bookings</a></div></body></html>