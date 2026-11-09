package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.UserDAO;
import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s != null && "ADMIN".equals(s.getAttribute("role")) && s.getAttribute("admin") != null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }
        req.getRequestDispatcher("admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
            return;
        }
        String action = req.getParameter("action");
        if ("deleteUser".equals(action)) {
            try { new UserDAO().deleteUser(Integer.parseInt(req.getParameter("userId"))); } catch (Exception e) { e.printStackTrace(); }
            resp.sendRedirect(req.getContextPath() + "/admin/manageUsers.jsp");
            return;
        }
        String target = switch (action == null ? "" : action) {
            case "cars" -> "admin/manageCars.jsp";
            case "bookings" -> "admin/manageBookings.jsp";
            case "users" -> "admin/manageUsers.jsp";
            case "reports" -> "admin/reports.jsp";
            default -> "admin/dashboard.jsp";
        };
        resp.sendRedirect(req.getContextPath() + "/" + target);
    }
}
