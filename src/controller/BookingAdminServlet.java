package controller;

import dao.BookingDAO;
import dao.PaymentDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;
import java.io.IOException;

@WebServlet("/BookingAdminServlet")
public class BookingAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession s=req.getSession(false);
        return s!=null && "ADMIN".equals(s.getAttribute("role")) && s.getAttribute("admin")!=null;
    }

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        if(!isAdmin(req)){resp.sendRedirect(req.getContextPath()+"/admin-login.jsp");return;}
        try {
            int bookingId=Integer.parseInt(req.getParameter("bookingId"));
            String action=req.getParameter("action");
            BookingDAO dao=new BookingDAO(); Booking b=dao.getBookingById(bookingId);
            if(b==null) throw new IllegalArgumentException();

            if("approve".equalsIgnoreCase(action) && "Pending".equalsIgnoreCase(b.getBookingStatus())) {
                // Kept for compatibility; customer payment is still required before the booking is Booked.
            } else if("cancel".equalsIgnoreCase(action) && ("Pending".equalsIgnoreCase(b.getBookingStatus()) || "Booked".equalsIgnoreCase(b.getBookingStatus()))) {
                dao.updateBookingStatus(bookingId,"Cancelled");
            } else if("deliver".equalsIgnoreCase(action) && "Booked".equalsIgnoreCase(b.getBookingStatus())) {
                if(new PaymentDAO().getPaidTotal(bookingId) > 0.009) dao.updateBookingStatus(bookingId,"Delivered");
            } else if("complete".equalsIgnoreCase(action) && "Delivered".equalsIgnoreCase(b.getBookingStatus())) {
                // Completion is normally automatic after final payment; retain this action for admin compatibility.
            }
        } catch(Exception e){e.printStackTrace();}
        resp.sendRedirect(req.getContextPath()+"/admin/manageBookings.jsp");
    }
}
