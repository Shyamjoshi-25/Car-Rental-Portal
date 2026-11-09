package util;

public class Validation {
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    private static final String PHONE_PATTERN = "^[0-9]{10}$";

    public static boolean isValidEmail(String email) {
        return email != null && email.length() <= 100 && email.matches(EMAIL_PATTERN);
    }

    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches(PHONE_PATTERN);
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 8 && password.length() <= 72;
    }

    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isSafeText(String value, int maxLength) {
        if (value == null || value.length() > maxLength) return false;
        // Reject HTML/script markup at input boundaries; output encoding remains the primary XSS defense.
        return !value.contains("<") && !value.contains(">");
    }
}
