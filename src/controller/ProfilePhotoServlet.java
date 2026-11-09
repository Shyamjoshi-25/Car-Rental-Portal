package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile-photo")
public class ProfilePhotoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        model.User user = (model.User) session.getAttribute("user");
        byte[] photo = new UserDAO().getProfilePhoto(user.getUserId());

        if (photo == null || photo.length == 0) {
            response.sendRedirect(request.getContextPath() + "/images/user.jpeg");
            return;
        }

        response.setContentType(detectImageType(photo));
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.getOutputStream().write(photo);
    }

    private String detectImageType(byte[] data) {
        if (data.length >= 8 && data[0] == (byte)0x89 && data[1] == 0x50 && data[2] == 0x4E && data[3] == 0x47)
            return "image/png";
        if (data.length >= 3 && (data[0] & 0xFF) == 0xFF && (data[1] & 0xFF) == 0xD8 && (data[2] & 0xFF) == 0xFF)
            return "image/jpeg";
        if (data.length >= 6 && data[0] == 'G' && data[1] == 'I' && data[2] == 'F')
            return "image/gif";
        if (data.length >= 12 && data[0] == 'R' && data[1] == 'I' && data[2] == 'F' && data[8] == 'W' && data[9] == 'E' && data[10] == 'B' && data[11] == 'P')
            return "image/webp";
        return "application/octet-stream";
    }
}
