package controller;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String csrf = request.getParameter("csrfToken");
        HttpSession existing = request.getSession(false);
        String expectedCsrf = existing == null ? null : (String) existing.getAttribute("csrfToken");
        if (expectedCsrf != null && (csrf == null || !expectedCsrf.equals(csrf))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token.");
            return;
        }

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        Admin admin = new AdminDAO().login(username.trim(), password);
        if (admin != null) {
            HttpSession session = request.getSession(true);
            session.invalidate();
            session = request.getSession(true);
            session.setAttribute("admin", admin);
            session.setAttribute("role", "ADMIN");
            session.removeAttribute("user");
            session.removeAttribute("email");
            response.sendRedirect(request.getContextPath() + "/AdminServlet");
        } else {
            request.setAttribute("error", "Invalid admin username or password.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
    }
}
