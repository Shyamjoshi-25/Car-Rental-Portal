DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS cars CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS admin CASCADE;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    password VARCHAR(100) NOT NULL,
    profile_photo BYTEA
);

CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    car_name VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    model VARCHAR(50),
    fuel_type VARCHAR(30),
    price_per_day DECIMAL(10,2) NOT NULL CHECK (price_per_day >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'Available'
        CHECK (status IN ('Available','Not Available')),
    image_data BYTEA,
    image_content_type VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    car_id INT NOT NULL REFERENCES cars(car_id) ON DELETE RESTRICT,
    pickup_date DATE NOT NULL,
    return_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    booking_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    CONSTRAINT chk_booking_dates CHECK (pickup_date < return_date),
    CONSTRAINT chk_booking_status CHECK (booking_status IN ('Pending','Booked','Delivered','Completed','Cancelled'))
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    transaction_id VARCHAR(40) UNIQUE NOT NULL,
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending','Paid','Failed','Refunded'))
);

CREATE TABLE admin (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100) NOT NULL,
    profile_photo BYTEA
);

-- Performance indexes used by the booking, payment and admin screens.
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_car_dates ON bookings(car_id, pickup_date, return_date);
CREATE INDEX idx_bookings_status ON bookings(booking_status);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(payment_status);


CREATE TABLE IF NOT EXISTS support_queries (
    query_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    subject VARCHAR(120) NOT NULL,
    message VARCHAR(3000) NOT NULL,
    admin_reply TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'Open' CHECK (status IN ('Open','In Progress','Answered','Closed')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    replied_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_support_queries_user ON support_queries(user_id, created_at DESC);
