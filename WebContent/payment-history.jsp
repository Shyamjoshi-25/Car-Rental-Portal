<%@ page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%if(session.getAttribute("user")==null){response.sendRedirect("login.jsp");return;}List<Map<String,Object>> payments=(List<Map<String,Object>>)request.getAttribute("payments");%><!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>Payment History - Car Rental Portal</title><style>body{font:16px Arial;background:#f4f7fb;color:#172033;margin:0}.wrap{max-width:1000px;margin:30px auto;padding:20px}.table{background:white;border-radius:12px;overflow:auto}table{width:100%;border-collapse:collapse}th,td{text-align:left;padding:13px;border-bottom:1px solid #e4e9f0}th{background:#eaf2fb}a{color:#0755a5}</style>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head><body><main class="wrap"><a href="dashboard.jsp">← Dashboard</a><h1>Payment History</h1><div class="table"><table><thead><tr><th>Payment</th><th>Booking</th><th>Date</th><th>Amount</th><th>Method</th><th>Status</th><th>Invoice</th></tr></thead><tbody><%if(payments!=null)for(Map<String,Object> p:payments){%><tr><td>#<%=p.get("payment_id")%></td><td>#<%=p.get("booking_id")%></td><td><%=p.get("payment_date")%></td><td>₹<%=p.get("amount")%></td><td><%=p.get("payment_method")%></td><td><%=p.get("payment_status")%></td><td><a href="invoice?bookingId=<%=p.get("booking_id")%>">Download Invoice</a></td></tr><%}%></tbody></table></div><p><a href="payment.jsp">Make a Payment</a></p></main></body></html>
