<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Profile - Car Rental Portal</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
        }

        .card {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        h1 {
            margin-bottom: 8px;
            color: #1f2937;
        }

        .subtitle {
            color: #6b7280;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #374151;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        input:focus,
        textarea:focus {
            border-color: #2563eb;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .email-note {
            margin-top: 6px;
            font-size: 13px;
            color: #6b7280;
        }

        .error {
            background: #fee2e2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .btn {
            text-decoration: none;
            border: none;
            cursor: pointer;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 15px;
        }

        .save-btn {
            background: #2563eb;
            color: white;
            flex: 1;
        }

        .save-btn:hover {
            background: #1d4ed8;
        }

        .cancel-btn {
            background: #e5e7eb;
            color: #374151;
        }

        .cancel-btn:hover {
            background: #d1d5db;
        }

        @media (max-width: 600px) {

            body {
                padding: 20px 12px;
            }

            .card {
                padding: 25px 20px;
            }

            .buttons {
                flex-direction: column;
            }

            .save-btn {
                width: 100%;
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

<div class="container">

    <div class="card">

        <h1>✏️ Edit Profile</h1>

        <p class="subtitle">
            Update your personal information
        </p>

        <% if (error != null) { %>

            <div class="error">
                <%= error %>
            </div>

        <% } %>

        <form action="profile" method="post" enctype="multipart/form-data">

            <!-- Full Name -->
            <div class="form-group">

                <label for="name">
                    Full Name
                </label>

                <input
                    type="text"
                    id="name"
                    name="full_name"
                    value="<%= user.getFullName() != null ? user.getFullName() : "" %>"
                    required>

            </div>

            <!-- Email -->
            <div class="form-group">

                <label for="email">
                    Email
                </label>

                <input
                    type="email"
                    id="email"
                    value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                    readonly>

                <div class="email-note">
                    Email cannot be changed.
                </div>

            </div>

            <!-- Phone -->
            <div class="form-group">

                <label for="phone">
                    Phone
                </label>

                <input
                    type="text"
                    id="phone"
                    name="phone"
                    value="<%= user.getPhone() != null ? user.getPhone() : "" %>">

            </div>

            <!-- Profile Photo -->
            <div class="form-group">
                <label for="profilePhoto">Profile Photo</label>
                <input type="file" id="profilePhoto" name="profilePhoto" accept="image/*">
                <div class="email-note">JPG, PNG, GIF or WebP. Maximum 2 MB.</div>
            </div>

            <!-- Address -->
            <div class="form-group">

                <label for="address">
                    Address
                </label>

                <textarea
                    id="address"
                    name="address"
                    placeholder="Enter your address"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>

            </div>

            <div class="buttons">

                <button type="submit"
                        class="btn save-btn">
                        Save Changes
                </button>

                <a href="profile"
                   class="btn cancel-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</div>

</body>
</html>