package model;

public class Booking {

    private int bookingId;
    private int userId;
    private int carId;
    private String pickupDate;
    private String returnDate;
    private double totalAmount;
    private String bookingStatus;

    // Default Constructor
    public Booking() {

    }

    // Parameterized Constructor
    public Booking(int bookingId, int userId, int carId,
                   String pickupDate, String returnDate,
                   double totalAmount, String bookingStatus) {

        this.bookingId = bookingId;
        this.userId = userId;
        this.carId = carId;
        this.pickupDate = pickupDate;
        this.returnDate = returnDate;
        this.totalAmount = totalAmount;
        this.bookingStatus = bookingStatus;
    }

    // Getter and Setter for bookingId
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    // Getter and Setter for userId
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getter and Setter for carId
    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    // Getter and Setter for pickupDate
    public String getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(String pickupDate) {
        this.pickupDate = pickupDate;
    }

    // Getter and Setter for returnDate
    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    // Getter and Setter for totalAmount
    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    // Getter and Setter for bookingStatus
    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
}