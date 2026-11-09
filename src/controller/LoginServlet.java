package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get email and password from login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check empty fields
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Email and password are required!"
            );

            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);

            return;
        }

        // Create UserDAO
        UserDAO userDAO = new UserDAO();

        // Check login credentials
        User user = userDAO.getUser(
                email.trim(),
                password
        );

        // Login successful
        if (user != null) {

            // Create session
            HttpSession session = request.getSession(true);
            session.invalidate();
            session = request.getSession(true);
            session.setAttribute("role", "USER");

            // Store complete user object
            session.setAttribute("user", user);

            // Store email
            session.setAttribute("email", user.getEmail());

            // Redirect to dashboard
            response.sendRedirect(
                    request.getContextPath() + "/dashboard.jsp"
            );

        } else {

            // Login failed
            request.setAttribute(
                    "error",
                    "Invalid email or password!"
            );

            // Return to login page
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // If someone opens /LoginServlet directly,
        // redirect them to the login page.
        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );
    }
}