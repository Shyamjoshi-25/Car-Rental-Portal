package controller;

import dao.BookingDAO;
import dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;
import model.Car;
import model.User;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }

        if ("cancel".equalsIgnoreCase(req.getParameter("action"))) {
            try { new BookingDAO().cancelBooking(Integer.parseInt(req.getParameter("bookingId")), user.getUserId()); }
            catch(Exception e){e.printStackTrace();}
            resp.sendRedirect(req.getContextPath()+"/bookingHistory.jsp?cancel=success"); return;
        }

        try {
            int carId=Integer.parseInt(req.getParameter("carId"));
            LocalDate pickup=LocalDate.parse(req.getParameter("pickupDate"));
            LocalDate ret=LocalDate.parse(req.getParameter("returnDate"));
            if(pickup.isBefore(LocalDate.now()) || !ret.isAfter(pickup)) throw new IllegalArgumentException();

            Car car=new CarDAO().getCarById(carId);
            if(car==null || !"Available".equalsIgnoreCase(car.getStatus())) throw new IllegalArgumentException("Car not available");

            long days=Math.max(1,ChronoUnit.DAYS.between(pickup,ret));
            double total=days*car.getPricePerDay();
            Booking booking=new Booking();
            booking.setUserId(user.getUserId()); booking.setCarId(carId);
            booking.setPickupDate(pickup.toString()); booking.setReturnDate(ret.toString());
            booking.setTotalAmount(total);
            // Booking stays Pending until the booking/advance payment is made.
            booking.setBookingStatus("Pending");

            if(new BookingDAO().addBooking(booking)) resp.sendRedirect(req.getContextPath()+"/bookingHistory.jsp");
            else { req.setAttribute("error","The car is not available for the selected dates."); req.getRequestDispatcher("booking.jsp").forward(req,resp); }
        } catch(Exception e) {
            e.printStackTrace(); req.setAttribute("error","Please enter valid booking details."); req.getRequestDispatcher("booking.jsp").forward(req,resp);
        }
    }
}
