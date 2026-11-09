package model;

public class User {

    // ==========================================
    // FIELDS
    // ==========================================

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String password;
    private byte[] profilePhoto;


    // ==========================================
    // DEFAULT CONSTRUCTOR
    // ==========================================

    public User() {
    }


    // ==========================================
    // PARAMETERIZED CONSTRUCTOR
    // ==========================================

    public User(
            int userId,
            String fullName,
            String email,
            String phone,
            String address,
            String password) {

        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
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
    // FULL NAME
    // ==========================================

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }


    // ==========================================
    // EMAIL
    // ==========================================

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    // ==========================================
    // PHONE
    // ==========================================

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    // ==========================================
    // ADDRESS
    // ==========================================

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


    // ==========================================
    // PASSWORD
    // ==========================================

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte[] getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(byte[] profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
}