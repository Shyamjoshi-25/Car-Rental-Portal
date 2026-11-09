# Car Rental Portal — Feature Update

## Included
1. Change Password page and servlet; validates the current password and hashes the replacement.
2. Customer Support query submission and personal query/reply history.
3. Admin Support Inbox to respond to submitted queries and set Open/In Progress/Answered/Closed status.
4. Add to Cart, Remove, and Book Now. Cart is stored in the logged-in session; availability is rechecked when booking.
5. Modify booking dates for Pending or Booked bookings only. Date conflicts are checked and total price recalculated.
6. Payment History and per-booking downloadable invoice. Invoice output is an HTML file, printable or savable as PDF in a browser.

## Before testing
- Apply `database/feature_migration.sql` to the current database.
- Rebuild with `docker compose up -d --build`.
- Test with a customer account and an administrator account.

## Notes
- The current payment implementation and its status records remain the source of truth; invoices reflect recorded paid totals.
- Modifying dates can change the booking total. If payment has already been made, review payment/refund policy before allowing changes in a production deployment.
- Cart contents are session-only and are not a confirmed reservation. A booking is only created after the customer submits the booking form.

## 2026-10-11 UI Consistency and Customer Care Update
- Added `WebContent/css/portal-unified.css` and included it from all JSP pages as a shared responsive styling layer.
- Refreshed customer support and admin support inbox pages to use the portal's shared visual system and responsive layouts.
- Added quick-help guidance, request status tracking, support replies, empty states, and clearer success/error feedback.
- Escaped customer-submitted support subjects/messages and admin replies when rendering them to reduce stored HTML/script injection risk.
- Allowed the admin support handler to save the `Open` status as well as In Progress, Answered, and Closed.
- Existing `support_queries` database table is retained; no database volume reset is required.
