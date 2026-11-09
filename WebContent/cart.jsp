<%@ page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*,model.Car" %><%if(session.getAttribute("user")==null){response.sendRedirect("login.jsp");return;}List<Car> cars=(List<Car>)request.getAttribute("cartCars");%><!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>My Cart - Car Rental Portal</title><style>body{font:16px Arial;background:#f4f7fb;color:#172033}.wrap{max-width:900px;margin:30px auto;padding:20px}.item{background:white;border-radius:12px;padding:18px;margin:12px 0;display:flex;justify-content:space-between;gap:15px;align-items:center;flex-wrap:wrap}a{color:#0755a5}.btn{display:inline-block;padding:10px 14px;border-radius:8px;background:#0755a5;color:white;text-decoration:none}</style>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/portal-unified.css?v=20261011fix1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-unified.css?v=20261012-match">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/modern-design-system.css?v=20261012">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-visual-repair.css?v=20261017">
</head><body><main class="wrap"><a href="cars.jsp">← Browse Cars</a><h1>Your Car Cart</h1><p>Cart items are saved for this login session. Dates and availability are confirmed when you book.</p><%if(cars==null||cars.isEmpty()){%><div class="item">Your cart is empty. <a class="btn" href="cars.jsp">Browse Cars</a></div><%}else for(Car c:cars){%><div class="item"><div><h2><%=c.getBrand()==null?"":c.getBrand()%> <%=c.getCarName()%></h2><p>₹<%=String.format("%.2f",c.getPricePerDay())%> per day</p></div><div><a class="btn" href="booking.jsp?carId=<%=c.getCarId()%>">Book Now</a> <a href="cart?action=remove&carId=<%=c.getCarId()%>">Remove</a></div></div><%}%></main></body></html>
