package model;

public class Admin {

    private int adminId;
    private String username;
    private String email;
    private String password;

    // Default Constructor
    public Admin() {

    }

    // Parameterized Constructor
    public Admin(int adminId, String username, String email, String password) {

        this.adminId = adminId;
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // Getter and Setter for adminId
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    // Getter and Setter for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getter and Setter for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and Setter for password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}