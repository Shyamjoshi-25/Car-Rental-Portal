package model;

public class RentalAgreement {

    private int agreementId;
    private int bookingId;
    private int userId;
    private int carId;

    private String agreementNumber;
    private String agreementDate;

    private String pickupDate;
    private String returnDate;

    private double totalAmount;
    private String agreementStatus;


    // ==========================================
    // DEFAULT CONSTRUCTOR
    // ==========================================

    public RentalAgreement() {

    }


    // ==========================================
    // PARAMETERIZED CONSTRUCTOR
    // ==========================================

    public RentalAgreement(
            int agreementId,
            int bookingId,
            int userId,
            int carId,
            String agreementNumber,
            String agreementDate,
            String pickupDate,
            String returnDate,
            double totalAmount,
            String agreementStatus) {

        this.agreementId = agreementId;
        this.bookingId = bookingId;
        this.userId = userId;
        this.carId = carId;
        this.agreementNumber = agreementNumber;
        this.agreementDate = agreementDate;
        this.pickupDate = pickupDate;
        this.returnDate = returnDate;
        this.totalAmount = totalAmount;
        this.agreementStatus = agreementStatus;
    }


    // ==========================================
    // AGREEMENT ID
    // ==========================================

    public int getAgreementId() {
        return agreementId;
    }

    public void setAgreementId(int agreementId) {
        this.agreementId = agreementId;
    }


    // ==========================================
    // BOOKING ID
    // ==========================================

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }


    // ==========================================
    // USER ID
    // ==========================================

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    // ==========================================
    // CAR ID
    // ==========================================

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }


    // ==========================================
    // AGREEMENT NUMBER
    // ==========================================

    public String getAgreementNumber() {
        return agreementNumber;
    }

    public void setAgreementNumber(String agreementNumber) {
        this.agreementNumber = agreementNumber;
    }


    // ==========================================
    // AGREEMENT DATE
    // ==========================================

    public String getAgreementDate() {
        return agreementDate;
    }

    public void setAgreementDate(String agreementDate) {
        this.agreementDate = agreementDate;
    }


    // ==========================================
    // PICKUP DATE
    // ==========================================

    public String getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(String pickupDate) {
        this.pickupDate = pickupDate;
    }


    // ==========================================
    // RETURN DATE
    // ==========================================

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }


    // ==========================================
    // TOTAL AMOUNT
    // ==========================================

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }


    // ==========================================
    // AGREEMENT STATUS
    // ==========================================

    public String getAgreementStatus() {
        return agreementStatus;
    }

    public void setAgreementStatus(String agreementStatus) {
        this.agreementStatus = agreementStatus;
    }
}