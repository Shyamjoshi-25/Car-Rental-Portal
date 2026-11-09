package model;

public class Car {

    private int carId;
    private String carName;
    private String brand;
    private String model;
    private String fuelType;
    private double pricePerDay;
    private String status;
    private byte[] imageData;
    private String imageContentType;

    // Default Constructor
    public Car() {

    }

    // Parameterized Constructor
    public Car(int carId, String carName, String brand,
               String model, String fuelType,
               double pricePerDay, String status) {

        this.carId = carId;
        this.carName = carName;
        this.brand = brand;
        this.model = model;
        this.fuelType = fuelType;
        this.pricePerDay = pricePerDay;
        this.status = status;
    }

    public byte[] getImageData() { return imageData; }
    public void setImageData(byte[] imageData) { this.imageData = imageData; }
    public String getImageContentType() { return imageContentType; }
    public void setImageContentType(String imageContentType) { this.imageContentType = imageContentType; }

    // Getter and Setter for carId
    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    // Getter and Setter for carName
    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    // Getter and Setter for brand
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    // Getter and Setter for model
    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    // Getter and Setter for fuelType
    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    // Getter and Setter for pricePerDay
    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    // Getter and Setter for status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}