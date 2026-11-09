package dao;

import model.Payment;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/** Payment persistence. Payment + booking-status changes are committed together. */
public class PaymentDAO {
    public boolean addPayment(Payment p) {
        String sql="INSERT INTO payments(booking_id,amount,payment_method,payment_status,transaction_id) VALUES(?,?,?,?,?)";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1,p.getBookingId()); ps.setDouble(2,p.getAmount()); ps.setString(3,p.getPaymentMethod()); ps.setString(4,p.getPaymentStatus()); ps.setString(5,p.getTransactionId());
            if(ps.executeUpdate()!=1) return false;
            try(ResultSet keys=ps.getGeneratedKeys()){ if(keys.next()) p.setPaymentId(keys.getInt(1)); }
            return p.getPaymentId()>0;
        } catch(SQLException e){ System.err.println("Unable to save payment: " + e.getMessage()); return false; }
    }

    /** Atomically records a paid transaction and changes the booking status. */
    public boolean recordPaymentAndUpdateBooking(Payment payment, String newBookingStatus) {
        String paymentSql="INSERT INTO payments(booking_id,amount,payment_method,payment_status,transaction_id) VALUES(?,?,?,?,?)";
        String bookingSql="UPDATE bookings SET booking_status=? WHERE booking_id=?";
        try(Connection c=DBConnection.getConnection()) {
            c.setAutoCommit(false);
            try {
                try (PreparedStatement lock=c.prepareStatement("SELECT booking_id FROM bookings WHERE booking_id=? FOR UPDATE")) {
                    lock.setInt(1,payment.getBookingId());
                    try(ResultSet rs=lock.executeQuery()){ if(!rs.next()){c.rollback();return false;} }
                }
                try(PreparedStatement ps=c.prepareStatement(paymentSql,Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1,payment.getBookingId()); ps.setDouble(2,payment.getAmount()); ps.setString(3,payment.getPaymentMethod());
                    ps.setString(4,payment.getPaymentStatus()); ps.setString(5,payment.getTransactionId());
                    if(ps.executeUpdate()!=1){c.rollback();return false;}
                    try(ResultSet keys=ps.getGeneratedKeys()){if(keys.next())payment.setPaymentId(keys.getInt(1));}
                }
                try(PreparedStatement ps=c.prepareStatement(bookingSql)) {
                    ps.setString(1,newBookingStatus); ps.setInt(2,payment.getBookingId());
                    if(ps.executeUpdate()!=1){c.rollback();return false;}
                }
                c.commit();
                return payment.getPaymentId()>0;
            } catch(SQLException e){c.rollback();throw e;} finally {c.setAutoCommit(true);}
        } catch(SQLException e){System.err.println("Unable to complete payment transaction: " + e.getMessage());return false;}
    }

    public double getPaidTotal(int bookingId) {
        String sql="SELECT COALESCE(SUM(amount),0) FROM payments WHERE booking_id=? AND payment_status='Paid'";
        try(Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql)) {
            p.setInt(1,bookingId); try(ResultSet r=p.executeQuery()){return r.next()?r.getDouble(1):0.0;}
        } catch(SQLException e){System.err.println("Unable to calculate paid amount: " + e.getMessage());return 0.0;}
    }

    public boolean hasPaidPayment(int bookingId) { return getPaidTotal(bookingId) > 0.009; }

    public List<Payment> getPaymentsByBooking(int bookingId) {
        List<Payment> list=new ArrayList<>(); String sql="SELECT * FROM payments WHERE booking_id=? ORDER BY payment_id";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql)) {
            ps.setInt(1,bookingId); try(ResultSet rs=ps.executeQuery()) { while(rs.next()) list.add(map(rs)); }
        } catch(SQLException e){System.err.println("Unable to load booking payments: " + e.getMessage());}
        return list;
    }

    public List<Payment> getAllPayments() {
        List<Payment> list=new ArrayList<>(); String sql="SELECT * FROM payments ORDER BY payment_id DESC";
        try(Connection c=DBConnection.getConnection();PreparedStatement ps=c.prepareStatement(sql);ResultSet rs=ps.executeQuery()){
            while(rs.next())list.add(map(rs));
        } catch(SQLException e){System.err.println("Unable to load payments: " + e.getMessage());}
        return list;
    }

    public Payment getPaymentById(int paymentId) {
        String sql="SELECT * FROM payments WHERE payment_id=?";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql)) {
            ps.setInt(1,paymentId); try(ResultSet rs=ps.executeQuery()) { return rs.next()?map(rs):null; }
        } catch(SQLException e){System.err.println("Unable to load payment: " + e.getMessage()); return null;}
    }

    private Payment map(ResultSet rs) throws SQLException {
        Payment p=new Payment(); p.setPaymentId(rs.getInt("payment_id")); p.setBookingId(rs.getInt("booking_id"));
        p.setAmount(rs.getDouble("amount")); p.setPaymentMethod(rs.getString("payment_method")); p.setPaymentStatus(rs.getString("payment_status"));
        p.setTransactionId(rs.getString("transaction_id")); Date d=rs.getDate("payment_date"); p.setPaymentDate(d==null?"":d.toString()); return p;
    }
}
