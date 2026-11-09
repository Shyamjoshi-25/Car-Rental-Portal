# Security changes

This version includes:

1. PBKDF2-HMAC-SHA256 password hashing with per-password random salt.
2. One-time migration of older plaintext passwords after successful login.
3. CSRF tokens for admin state-changing actions.
4. 30-minute sessions, HttpOnly + Secure cookies, and cookie-only tracking.
5. Admin authorization in both admin servlets and direct `/admin/*` JSP access.
6. Input length/type checks and output-oriented CSP hardening.
7. Database credentials are read only from environment variables; `.env` is gitignored.
8. HTTPS on Tomcat port 8443 in Docker. The demo certificate is self-signed, so a browser warning is expected.
9. Security headers: CSP, X-Content-Type-Options, X-Frame-Options and Referrer-Policy.

## Docker

Copy `.env.example` to `.env` and set the passwords. Then run:

`docker compose up --build`

Open:

`https://localhost:8443/`

The HTTP connector remains available for Tomcat's HTTPS redirect handling, but the application requires HTTPS.

## Demo credentials

Admin: `admin` / `admin123`

Sample users retain the original demo password `123456`, but it is stored as a PBKDF2 hash in the sample database. For a real deployment, use stronger passwords.
