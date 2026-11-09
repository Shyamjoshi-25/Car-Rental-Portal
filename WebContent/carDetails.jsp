<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Car Details - Car Rental Portal</title>

<style>

body{
    font-family:Arial, sans-serif;
    background:#f4f4f4;
    margin:0;
    padding:0;
}

header{
    background:#1f4e79;
    color:white;
    text-align:center;
    padding:20px;
}

.container{
    width:60%;
    margin:40px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0px 0px 10px gray;
}

table{
    width:100%;
    border-collapse:collapse;
}

td{
    padding:12px;
    border-bottom:1px solid #ddd;
}

.label{
    font-weight:bold;
    width:35%;
}

.btn{
    display:inline-block;
    padding:10px 20px;
    background:#1f4e79;
    color:white;
    text-decoration:none;
    border-radius:5px;
    margin-top:20px;
}

.btn:hover{
    background:#0d6efd;
}

.center{
    text-align:center;
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

<header>

<h1>Car Details</h1>

</header>

<div class="container">

<table>

<tr>
<td class="label">Car ID</td>
<td>1</td>
</tr>

<tr>
<td class="label">Car Name</td>
<td>Swift</td>
</tr>

<tr>
<td class="label">Brand</td>
<td>Maruti Suzuki</td>
</tr>

<tr>
<td class="label">Model</td>
<td>2024</td>
</tr>

<tr>
<td class="label">Fuel Type</td>
<td>Petrol</td>
</tr>

<tr>
<td class="label">Transmission</td>
<td>Manual</td>
</tr>

<tr>
<td class="label">Seats</td>
<td>5</td>
</tr>

<tr>
<td class="label">Price Per Day</td>
<td>₹1500</td>
</tr>

<tr>
<td class="label">Status</td>
<td>Available</td>
</tr>

</table>

<div class="center">

<a href="booking.jsp" class="btn">Book This Car</a>

&nbsp;&nbsp;

<a href="cars.jsp" class="btn">Back to Cars</a>

</div>

</div>

</body>
</html>