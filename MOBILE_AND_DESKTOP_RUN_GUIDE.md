# Car Rental Portal - Cross-Device Run Guide

## Local PC

1. Start Docker Desktop.
2. Open CMD.
3. Run:
   `cd /d C:\CarRentalPortal`
4. Rebuild and start:
   `docker compose down`
   `docker compose build --no-cache`
   `docker compose up -d`
5. Check:
   `docker compose ps`
6. PC URL:
   `http://localhost:8081`

## Android / iPhone / iPad on the same Wi-Fi

1. Find the PC Wi-Fi IPv4 address with:
   `ipconfig`
2. Use the Wi-Fi IPv4 address, for example:
   `http://10.15.105.106:8081`
3. Do not use `localhost` on the phone.
4. The phone/tablet and PC must be on the same Wi-Fi.
5. If Windows blocks access, run Administrator CMD:
   `netsh advfirewall firewall add rule name="Car Rental Portal 8081" dir=in action=allow protocol=TCP localport=8081`

## Login troubleshooting

Watch the application log:
`docker compose logs -f app`

Then submit the login form from the phone.

If the browser stays on the login page, check the log for a database or servlet exception.

## Database check

Open PostgreSQL:
`docker exec -it car-rental-db psql -U postgres -d car_rental`

Registered emails:
`SELECT user_id, full_name, email FROM users;`

Passwords are stored as hashes and cannot be read back as plain text. Use a password reset if a test password is forgotten.

## Final responsive version

The home hero uses the new `hero-car-wide.jpg` on larger screens and `hero-car-mobile.jpg` on phones. The old `hero-modern.jpg` image with the empty panel is no longer used. The home page does not contain a separate hero image box.

## Responsive targets

The UI includes responsive behavior for:
- Android Chrome/Edge
- iPhone/iPad Safari
- Windows/macOS browsers
- Phones around 360px wide and larger
- Tablets
- Laptops/desktops
- Portrait and landscape phone layouts

## Important local HTTP note

The local Docker URL uses HTTP on port 8081. The session cookie is therefore configured without the Secure-only flag so that login sessions can work during local HTTP testing. For production, serve the application over HTTPS.
