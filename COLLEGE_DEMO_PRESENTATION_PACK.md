# College Demo Presentation Pack

## 1. Recommended demo sequence
1. Open the customer login/registration page.
2. Login and show the dashboard.
3. Open **View Cars** and explain availability.
4. Select an available car and create a booking.
5. Open **My Bookings** and show the 20% advance due.
6. Complete the simulated payment and show the generated Transaction ID.
7. Open Payment Details and Rental Agreement/Invoice.
8. Open Admin Login and show the Admin Dashboard statistics.
9. Demonstrate car/booking/user management.

## 2. Features to mention in viva
- Java Servlets + JSP MVC-style separation
- PostgreSQL relational database
- JDBC DAOs for database operations
- PBKDF2-HMAC-SHA256 password hashing with salt
- CSRF protection for sensitive POST actions
- Session and admin authorization checks
- Input validation and security headers
- Database credentials supplied through environment variables
- HTTPS for transport security in the Docker demo
- Docker Compose for repeatable deployment
- Simulated payment flow with unique transaction ID (no real gateway)

## 3. Database points
The database uses primary keys, foreign keys, UNIQUE constraints, CHECK constraints and indexes.

Main relationships:
- `users` 1 → many `bookings`
- `cars` 1 → many `bookings`
- `bookings` 1 → many `payments`

## 4. Screenshots checklist
Capture these screenshots after starting the project:
- `01-login.png` — Login page
- `02-dashboard.png` — Customer dashboard
- `03-cars.png` — Cars and availability
- `04-booking.png` — Booking form
- `05-my-bookings.png` — Booking history
- `06-payment.png` — Advance/final payment page
- `07-payment-success.png` — Transaction ID / successful payment
- `08-payment-details.png` — Payment details
- `09-rental-agreement.png` — Rental agreement/invoice
- `10-admin-dashboard.png` — Admin statistics

## 5. Payment explanation
This is a **college-demo simulated payment**. The application records the payment in PostgreSQL and generates a transaction ID; it does not charge a real bank account or connect to a live payment gateway.

## 6. Suggested project title
**Car Rental Portal — Java Servlet, JSP, PostgreSQL & Docker**
