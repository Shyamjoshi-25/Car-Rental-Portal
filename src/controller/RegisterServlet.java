package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // GET FORM DATA
        // ==========================================

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        // ==========================================
        // REMOVE EXTRA SPACES
        // ==========================================

        if (fullName != null) {
            fullName = fullName.trim();
        }

        if (email != null) {
            email = email.trim();
        }

        if (phone != null) {
            phone = phone.trim();
        }

        if (address != null) {
            address = address.trim();
        }

        // ==========================================
        // VALIDATION
        // ==========================================

        if (fullName != null && fullName.length() > 100) {
            request.setAttribute("error", "Full name must be 100 characters or less.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!util.Validation.isSafeText(fullName, 100) || !util.Validation.isSafeText(address, 255)) {
            request.setAttribute("error", "Name or address contains invalid characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!util.Validation.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.setAttribute("fullName", fullName); request.setAttribute("email", email);
            request.setAttribute("phone", phone); request.setAttribute("address", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!util.Validation.isValidPhone(phone)) {
            request.setAttribute("error", "Phone number must contain exactly 10 digits.");
            request.setAttribute("fullName", fullName); request.setAttribute("email", email);
            request.setAttribute("phone", phone); request.setAttribute("address", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!util.Validation.isValidPassword(password)) {
            request.setAttribute("error", "Password must contain 8 to 72 characters.");
            request.setAttribute("fullName", fullName); request.setAttribute("email", email);
            request.setAttribute("phone", phone); request.setAttribute("address", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (fullName == null || fullName.isEmpty()
                || email == null || email.isEmpty()
                || phone == null || phone.isEmpty()
                || address == null || address.isEmpty()
                || password == null || password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please fill all fields."
            );

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);

            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);

            return;
        }

        // ==========================================
        // CREATE USER OBJECT
        // ==========================================

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setPassword(password);

        // ==========================================
        // REGISTER USER
        // ==========================================

        UserDAO userDAO = new UserDAO();

        int userId = userDAO.register(user);

        // ==========================================
        // REGISTRATION SUCCESS
        // ==========================================

        if (userId > 0) {

            request.setAttribute("userId", userId);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);

            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);

        }

        // ==========================================
        // REGISTRATION FAILED
        // ==========================================

        else {
            String message = userId == -2
                    ? "Email already exists. Please use a different email."
                    : "Registration failed because the database could not save your details.";

            request.setAttribute("error", message);

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);

            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }
}