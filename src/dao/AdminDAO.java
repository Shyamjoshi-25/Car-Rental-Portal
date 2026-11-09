package dao;

import model.Admin;
import util.DBConnection;
import util.PasswordHash;
import java.sql.*;

public class AdminDAO {
    public Admin login(String username, String password) {
        String sql = "SELECT admin_id, username, email, password FROM admin WHERE username=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, username);
            try (ResultSet r = p.executeQuery()) {
                if (!r.next()) return null;
                String stored = r.getString("password");
                boolean valid = PasswordHash.isHashed(stored)
                        ? PasswordHash.verify(password, stored)
                        : password.equals(stored); // one-time migration for older demo data
                if (!valid) return null;

                if (!PasswordHash.isHashed(stored)) {
                    try (PreparedStatement upgrade = c.prepareStatement(
                            "UPDATE admin SET password=? WHERE admin_id=?")) {
                        upgrade.setString(1, PasswordHash.hash(password));
                        upgrade.setInt(2, r.getInt("admin_id"));
                        upgrade.executeUpdate();
                    }
                }

                Admin a = new Admin();
                a.setAdminId(r.getInt("admin_id"));
                a.setUsername(r.getString("username"));
                a.setEmail(r.getString("email"));
                a.setPassword(null);
                return a;
            }
        } catch (SQLException e) { e.printStackTrace(); return null; }
    }

    public int countUsers() { return count("SELECT COUNT(*) FROM users"); }
    public int countCars() { return count("SELECT COUNT(*) FROM cars"); }
    public int countBookings() { return count("SELECT COUNT(*) FROM bookings"); }
    public int countAvailableCars() { return count("SELECT COUNT(*) FROM cars WHERE status='Available'"); }
    public int countNotAvailableCars() { return count("SELECT COUNT(*) FROM cars WHERE status='Not Available'"); }
    public int countCompletedBookings() { return count("SELECT COUNT(*) FROM bookings WHERE booking_status='Completed'"); }
    public int countCancelledBookings() { return count("SELECT COUNT(*) FROM bookings WHERE booking_status='Cancelled'"); }

    public double totalRevenue() {
        String sql = "SELECT COALESCE(SUM(amount),0) FROM payments WHERE payment_status='Paid'";
        try (Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql); ResultSet r=p.executeQuery()) {
            return r.next() ? r.getDouble(1) : 0.0;
        } catch (SQLException e) { e.printStackTrace(); return 0.0; }
    }

    private int count(String sql) {
        try (Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql); ResultSet r=p.executeQuery()) {
            return r.next() ? r.getInt(1) : 0;
        } catch (SQLException e) { e.printStackTrace(); return 0; }
    }
}
