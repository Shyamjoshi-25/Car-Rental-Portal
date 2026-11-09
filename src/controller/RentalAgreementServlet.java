package controller;

import java.io.IOException;

import dao.BookingDAO;
import dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.Car;
import model.User;

@WebServlet("/rental-agreement")
public class RentalAgreementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // ==========================================
    // SHOW RENTAL AGREEMENT
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ==========================================
        // CHECK LOGIN
        // ==========================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");

            return;
        }


        // ==========================================
        // GET USER
        // ==========================================

        User user =
                (User) session.getAttribute("user");


        // ==========================================
        // GET BOOKING ID
        // ==========================================

        String bookingIdParameter =
                request.getParameter("bookingId");


        if (bookingIdParameter == null ||
            bookingIdParameter.trim().isEmpty()) {

            response.sendRedirect("dashboard.jsp");

            return;
        }


        int bookingId;


        try {

            bookingId =
                    Integer.parseInt(
                            bookingIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect("dashboard.jsp");

            return;
        }


        // ==========================================
        // GET BOOKING
        // ==========================================

        BookingDAO bookingDAO =
                new BookingDAO();


        Booking booking =
                bookingDAO.getBookingById(
                        bookingId);


        if (booking == null) {

            response.sendRedirect("dashboard.jsp");

            return;
        }


        // ==========================================
        // SECURITY CHECK
        //
        // Make sure the booking belongs
        // to the logged-in user.
        // ==========================================

        if (booking.getUserId()
                != user.getUserId()) {

            response.sendRedirect("dashboard.jsp");

            return;
        }


        // ==========================================
        // GET CAR
        // ==========================================

        CarDAO carDAO =
                new CarDAO();


        Car car =
                carDAO.getCarById(
                        booking.getCarId());


        if (car == null) {

            response.sendRedirect("dashboard.jsp");

            return;
        }


        // ==========================================
        // SEND DATA TO JSP
        // ==========================================

        request.setAttribute(
                "user",
                user);


        request.setAttribute(
                "booking",
                booking);


        request.setAttribute(
                "car",
                car);


        // ==========================================
        // OPEN RENTAL AGREEMENT
        // ==========================================

        request.getRequestDispatcher(
                "rental-agreement.jsp")
               .forward(
                       request,
                       response);
    }
}