package controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

/** HTTP hardening, secure sessions, admin authorization and CSRF protection. */
@WebFilter("/*")
public class SecurityFilter implements Filter {
    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);

        if (session != null && session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", newToken());
        }

        // Never expose admin JSPs directly to unauthenticated users.
        String path = req.getRequestURI().substring(req.getContextPath().length());
        if (path.startsWith("/admin/")) {
            boolean admin = session != null
                    && "ADMIN".equals(session.getAttribute("role"))
                    && session.getAttribute("admin") != null;
            if (!admin) {
                resp.sendRedirect(req.getContextPath() + "/admin-login.jsp");
                return;
            }
        }

        // CSRF protection for state-changing admin endpoints.
        if ("POST".equalsIgnoreCase(req.getMethod())
                && ("/AdminServlet".equals(path)
                    || "/BookingAdminServlet".equals(path)
                    || "/CarServlet".equals(path))) {
            String expected = session == null ? null : (String) session.getAttribute("csrfToken");
            String supplied = req.getParameter("csrfToken");
            if (expected == null || supplied == null || !constantTimeEquals(expected, supplied)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token.");
                return;
            }
        }

        resp.setHeader("X-Content-Type-Options", "nosniff");
        resp.setHeader("X-Frame-Options", "SAMEORIGIN");
        resp.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        resp.setHeader("Content-Security-Policy",
                "default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; "
                + "script-src 'self' 'unsafe-inline'; object-src 'none'; base-uri 'self'; "
                + "form-action 'self'");
        resp.setHeader("Cache-Control", "no-store");

        chain.doFilter(request, response);
    }

    private static String newToken() {
        byte[] bytes = new byte[32];
        RANDOM.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private static boolean constantTimeEquals(String a, String b) {
        byte[] x = a.getBytes(java.nio.charset.StandardCharsets.UTF_8);
        byte[] y = b.getBytes(java.nio.charset.StandardCharsets.UTF_8);
        if (x.length != y.length) return false;
        int result = 0;
        for (int i = 0; i < x.length; i++) result |= x[i] ^ y[i];
        return result == 0;
    }
}
