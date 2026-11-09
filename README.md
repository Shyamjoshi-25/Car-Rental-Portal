# Car Rental Portal - Final Demo Version

Java/JSP/Servlet + PostgreSQL car rental project for Apache Tomcat 10.1.

## Technology
- Java 17+
- Maven
- Apache Tomcat 10.1
- Jakarta Servlet 6.0
- PostgreSQL 16
- Docker Desktop

## Recommended: full Docker mode
Open PowerShell in this project folder.

If this is an old database from an earlier version, reset it once:

    docker compose down -v

Then build and start everything:

    docker compose up --build

Open:

    http://localhost:8081/

The Docker build runs Maven inside the builder image, so Maven does not need to be installed separately for this mode.

## Customer demo flow
1. Login with `rahul@gmail.com` / `123456`.
2. Dashboard/Home shows the navigation.
3. View Cars shows exactly 10 cars: 6 Available and 4 Not Available.
4. Select an available car and dates.
5. The Estimated Total Amount is displayed.
6. Create the booking.
7. Payment page asks only for the 20% booking advance.
8. Admin logs in with `admin` / `admin123`.
9. In Manage Bookings, after the customer receives the car, click `Mark Delivered`.
10. Customer opens Payment and pays the remaining balance.
11. Booking becomes `Completed` and `Fully Paid`.

## Local Tomcat mode
Start PostgreSQL:

    docker compose up -d db

Build the application on Windows:

    mvn clean package -DskipTests

Deploy:

    copy /Y target\CarRentalPortal.war "C:\apache-tomcat-10.1.57-windows-x64\apache-tomcat-10.1.57\webapps\ROOT.war"

Start Tomcat:

    cd "C:\apache-tomcat-10.1.57-windows-x64\apache-tomcat-10.1.57\bin"
    .\startup.bat

Open:

    http://localhost:8080/

## PostgreSQL
Docker PostgreSQL credentials:

    Database: car_rental
    User: postgres
    Password: postgres
    Port: 5432

Use this if you need psql:

    docker exec -it car-rental-db psql -U postgres -d car_rental

## Existing database
If you do not want to delete existing data, run `database/update_changes.sql` once inside PostgreSQL instead of `docker compose down -v`.


## Payment receipt demo
After a successful advance or final payment, the portal opens `payment-success.jsp` and shows:
- Payment Successful confirmation
- Booking ID and car
- Advance/final payment type
- Amount paid
- Payment method and status
- Payment date
- Unique transaction ID
- Total paid and remaining balance

`payment-details.jsp` lists all successful payments for a customer's booking.

## Demo-ready improvements

The current version includes a polished shared UI layer, stronger database constraints/indexes, transactional booking/payment operations, HTTP security headers, session-ID rotation after login, and server-side registration validation. See `COLLEGE_DEMO_IMPROVEMENTS.md` for details.

## Customer Feature Update (October 2026)

New customer features in this package:
- Change Password (`/change-password`) with current-password validation and PBKDF2 password hashing.
- Customer Support (`/support`) for submitting queries and checking replies.
- Admin Support Inbox (`/admin-support`) for staff to reply and update query status.
- Session-based car cart (`/cart`) with Add to Cart, Remove, and Book Now links. Cart entries are temporary until a booking is made.
- Modify dates for Pending/Booked reservations (`/modify-booking`) with date-overlap validation and recalculated rental total.
- Payment History (`/payment-history`) and downloadable invoice (`/invoice?bookingId=ID`). The invoice is an HTML document that can be printed or saved as PDF from the browser; the existing rental agreement remains separate.

### Apply database migration to an existing database

Run `database/feature_migration.sql` once against the existing `car_rental` database. This creates the support-query table without dropping existing customer, car, booking, or payment data.

Docker example from the project root (use the same environment values as your compose file):

```powershell
docker compose exec -T db psql -U postgres -d car_rental < database/feature_migration.sql
```

If your database user is not `postgres`, replace it with the configured `POSTGRES_USER`. In PowerShell, if input redirection is unsupported by your shell, run:

```powershell
Get-Content .\database\feature_migration.sql | docker compose exec -T db psql -U postgres -d car_rental
```

Rebuild and restart the application after migration:

```powershell
docker compose up -d --build
```

Important: only apply the feature migration to an existing database. `database/car_rental.sql` is the clean-install schema and begins by dropping tables.

## Customer Care Support
- Customers can open **Customer Support** from the portal navigation, submit a support request, and track its status and reply at `/support`.
- Administrators can review requests, reply, and update status at `/admin-support` (admin login required).
- The support table is defined in `database/car_rental.sql` and `database/feature_migration.sql` for existing databases.
- A shared responsive stylesheet, `WebContent/css/portal-unified.css`, is included across the JSP pages to help keep the UI consistent.


## Add or change car photos
The Admin Dashboard > Manage Cars page now lets an admin upload a car image (JPG, PNG, or WEBP, up to 5 MB) while adding a car, or choose a replacement image beside an existing car. Uploaded images are saved in PostgreSQL and shown on the View Cars page.

For an existing Docker database, apply the new columns once from the project folder:
```powershell
docker compose exec -T db sh -c 'psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"' < database/feature_migration.sql
docker compose up -d --build
```
