package dao;

import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/** Database access for customer bookings. Keeps date-overlap validation in one place. */
public class BookingDAO {
    private Booking map(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setCarId(rs.getInt("car_id"));
        b.setPickupDate(rs.getString("pickup_date"));
        b.setReturnDate(rs.getString("return_date"));
        b.setTotalAmount(rs.getDouble("total_amount"));
        b.setBookingStatus(rs.getString("booking_status"));
        return b;
    }

    /**
     * Creates a booking atomically. The car row is locked during the overlap check,
     * preventing two simultaneous requests from booking the same car/date range.
     */
    public boolean addBooking(Booking b) {
        String check = "SELECT 1 FROM bookings " +
                "WHERE car_id=? AND booking_status IN ('Pending','Booked','Delivered') " +
                "AND pickup_date < ? AND return_date > ? LIMIT 1";
        String sql = "INSERT INTO bookings(user_id,car_id,pickup_date,return_date,total_amount,booking_status) VALUES(?,?,?,?,?,?)";

        try (Connection c = DBConnection.getConnection()) {
            c.setAutoCommit(false);
            try {
                // Serialize booking attempts for the same car.
                try (PreparedStatement lock = c.prepareStatement("SELECT car_id FROM cars WHERE car_id=? FOR UPDATE")) {
                    lock.setInt(1, b.getCarId());
                    try (ResultSet r = lock.executeQuery()) {
                        if (!r.next()) { c.rollback(); return false; }
                    }
                }

                try (PreparedStatement p = c.prepareStatement(check)) {
                    p.setInt(1, b.getCarId());
                    p.setDate(2, Date.valueOf(b.getReturnDate()));
                    p.setDate(3, Date.valueOf(b.getPickupDate()));
                    try (ResultSet r = p.executeQuery()) {
                        if (r.next()) { c.rollback(); return false; }
                    }
                }

                try (PreparedStatement p = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    p.setInt(1, b.getUserId());
                    p.setInt(2, b.getCarId());
                    p.setDate(3, Date.valueOf(b.getPickupDate()));
                    p.setDate(4, Date.valueOf(b.getReturnDate()));
                    p.setDouble(5, b.getTotalAmount());
                    p.setString(6, b.getBookingStatus());
                    if (p.executeUpdate() != 1) { c.rollback(); return false; }
                    try (ResultSet keys = p.getGeneratedKeys()) {
                        if (keys.next()) b.setBookingId(keys.getInt(1));
                    }
                }
                c.commit();
                return b.getBookingId() > 0;
            } catch (SQLException e) {
                c.rollback();
                throw e;
            } finally {
                c.setAutoCommit(true);
            }
        } catch (SQLException | IllegalArgumentException e) {
            System.err.println("Unable to create booking: " + e.getMessage());
            return false;
        }
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_id DESC";
        try (Connection c = DBConnection.getConnection(); PreparedStatement p = c.prepareStatement(sql); ResultSet r = p.executeQuery()) {
            while (r.next()) list.add(map(r));
        } catch (SQLException e) { System.err.println("Unable to load bookings: " + e.getMessage()); }
        return list;
    }

    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id=? ORDER BY booking_id DESC";
        try (Connection c = DBConnection.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, userId);
            try (ResultSet r = p.executeQuery()) { while (r.next()) list.add(map(r)); }
        } catch (SQLException e) { System.err.println("Unable to load user bookings: " + e.getMessage()); }
        return list;
    }

    public Booking getBookingById(int id) {
        String sql = "SELECT * FROM bookings WHERE booking_id=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, id);
            try (ResultSet r = p.executeQuery()) { return r.next() ? map(r) : null; }
        } catch (SQLException e) { System.err.println("Unable to load booking: " + e.getMessage()); return null; }
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE bookings SET booking_status=? WHERE booking_id=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, status); p.setInt(2, bookingId);
            return p.executeUpdate() == 1;
        } catch (SQLException e) { System.err.println("Unable to update booking: " + e.getMessage()); return false; }
    }

    public boolean cancelBooking(int bookingId, int userId) {
        String find = "SELECT booking_status FROM bookings WHERE booking_id=? AND user_id=?";
        try (Connection c = DBConnection.getConnection()) {
            String current;
            try (PreparedStatement p = c.prepareStatement(find)) {
                p.setInt(1, bookingId); p.setInt(2, userId);
                try (ResultSet r = p.executeQuery()) { if (!r.next()) return false; current = r.getString(1); }
            }
            if (!"Pending".equals(current) && !"Booked".equals(current)) return false;
            try (PreparedStatement p = c.prepareStatement("UPDATE bookings SET booking_status='Cancelled' WHERE booking_id=? AND user_id=?")) {
                p.setInt(1, bookingId); p.setInt(2, userId);
                return p.executeUpdate() == 1;
            }
        } catch (SQLException e) { System.err.println("Unable to cancel booking: " + e.getMessage()); return false; }
    }
}
