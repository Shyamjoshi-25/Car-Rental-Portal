package controller;

import dao.BookingDAO;
import dao.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;
import model.Payment;
import model.User;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final double BOOKING_PERCENT = 0.20; // 20% advance at booking

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s=req.getSession(false);
        User u=s==null?null:(User)s.getAttribute("user");
        if(u==null){resp.sendRedirect(req.getContextPath()+"/login.jsp");return;}
        try {
            int bookingId=Integer.parseInt(req.getParameter("bookingId"));
            String method=req.getParameter("paymentMethod");
            Booking b=new BookingDAO().getBookingById(bookingId);
            PaymentDAO pdao=new PaymentDAO();
            if(b==null || b.getUserId()!=u.getUserId() || method==null || method.isBlank()) throw new IllegalArgumentException();

            double paid=pdao.getPaidTotal(bookingId);
            double total=b.getTotalAmount();
            double amount;
            String newStatus=b.getBookingStatus();

            if("Pending".equalsIgnoreCase(b.getBookingStatus()) && paid < 0.01) {
                amount=Math.round(total*BOOKING_PERCENT*100.0)/100.0;
                if(amount<=0) amount=total;
                newStatus="Booked";
            } else if("Delivered".equalsIgnoreCase(b.getBookingStatus())) {
                amount=Math.round((total-paid)*100.0)/100.0;
                if(amount<=0.01) throw new IllegalArgumentException("Nothing remains to pay");
                newStatus="Completed";
            } else {
                throw new IllegalArgumentException("Payment is not currently due");
            }

            Payment payment=new Payment();
            payment.setBookingId(bookingId); payment.setAmount(amount); payment.setPaymentMethod(method); payment.setPaymentStatus("Paid");
            payment.setTransactionId("TXN-" + UUID.randomUUID().toString().replace("-", "").substring(0, 12).toUpperCase());
            if(!pdao.recordPaymentAndUpdateBooking(payment, newStatus)) throw new IllegalArgumentException();
            String paymentType = "Booked".equalsIgnoreCase(newStatus) ? "advance" : "final";
            resp.sendRedirect(req.getContextPath()+"/payment-success.jsp?paymentId=" + payment.getPaymentId() + "&type=" + paymentType);
        } catch(Exception e) {
            e.printStackTrace();
            req.setAttribute("error","Payment failed. Please select a booking with a payment currently due.");
            req.getRequestDispatcher("payment.jsp").forward(req,resp);
        }
    }
}
