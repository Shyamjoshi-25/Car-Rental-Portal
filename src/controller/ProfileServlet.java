package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/profile")
@MultipartConfig(maxFileSize = 2 * 1024 * 1024, maxRequestSize = 3 * 1024 * 1024)
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ==========================================
    // DISPLAY PROFILE
    // ==========================================
    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user = (User) session.getAttribute("user");

        // Send user to JSP
        request.setAttribute("user", user);

        request.getRequestDispatcher("profile.jsp")
               .forward(request, response);
    }


    // ==========================================
    // UPDATE PROFILE
    // ==========================================
    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Optional profile photo upload
        Part photoPart = request.getPart("profilePhoto");
        if (photoPart != null && photoPart.getSize() > 0) {
            String contentType = photoPart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                request.setAttribute("error", "Please select a valid image file.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
                return;
            }
            byte[] photoBytes = photoPart.getInputStream().readAllBytes();
            if (!userDAO.updateProfilePhoto(user.getUserId(), photoBytes)) {
                request.setAttribute("error", "Profile photo could not be saved.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
                return;
            }
            user.setProfilePhoto(photoBytes);
        }

        // Get form values
        String fullName = request.getParameter("full_name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        if (!util.Validation.isSafeText(fullName, 100)
                || !util.Validation.isValidPhone(phone)
                || !util.Validation.isSafeText(address, 255)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid profile data.");
            return;
        }

        // Remove unnecessary spaces
        if (fullName != null) {
            fullName = fullName.trim();
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

        if (fullName == null || fullName.isEmpty()) {

            request.setAttribute(
                "error",
                "Full name cannot be empty."
            );

            request.setAttribute("user", user);

            request.getRequestDispatcher("edit-profile.jsp")
                   .forward(request, response);

            return;
        }

        // ==========================================
        // UPDATE USER OBJECT
        // ==========================================

        user.setFullName(fullName);
        user.setPhone(phone);
        user.setAddress(address);

        // ==========================================
        // SAVE CHANGES TO DATABASE
        // ==========================================

        boolean updated = userDAO.updateProfile(user);

        if (updated) {

            // Update session with new information
            session.setAttribute("user", user);

            // Success message
            request.setAttribute(
                "success",
                "Profile updated successfully!"
            );

            request.setAttribute("user", user);

            // Show profile page
            request.getRequestDispatcher("profile.jsp")
                   .forward(request, response);

        } else {

            // Database update failed
            request.setAttribute(
                "error",
                "Profile update failed. Please try again."
            );

            request.setAttribute("user", user);

            request.getRequestDispatcher("edit-profile.jsp")
                   .forward(request, response);
        }
    }
}     