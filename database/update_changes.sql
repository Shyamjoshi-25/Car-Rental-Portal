-- Car Rental Portal - final requested changes
-- Run this once on an existing database.

ALTER TABLE users ADD COLUMN IF NOT EXISTS profile_photo BYTEA;

-- Keep exactly 10 demo cars with a fixed fleet status: 6 available + 4 unavailable.
UPDATE cars SET status = CASE
  WHEN LOWER(car_name) IN ('swift','baleno','creta','venue','nexon','harrier') THEN 'Available'
  WHEN LOWER(car_name) IN ('city','innova crysta','xuv700','fortuner') THEN 'Not Available'
  ELSE status END;

-- If an older database has fewer than 10 cars, add the missing demo cars.
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Swift','Maruti Suzuki','Swift VXI','Petrol',1500,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='swift');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Baleno','Maruti Suzuki','Baleno Delta','Petrol',1800,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='baleno');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Creta','Hyundai','Creta SX','Diesel',2800,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='creta');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Venue','Hyundai','Venue S','Petrol',2200,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='venue');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Nexon','Tata','Nexon XZ','Petrol',2000,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='nexon');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Harrier','Tata','Harrier XZA','Diesel',3200,'Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='harrier');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'City','Honda','City V','Petrol',2500,'Not Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='city');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Innova Crysta','Toyota','Innova Crysta GX','Diesel',3500,'Not Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='innova crysta');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'XUV700','Mahindra','XUV700 AX5','Diesel',3000,'Not Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='xuv700');
INSERT INTO cars (car_name,brand,model,fuel_type,price_per_day,status)
SELECT 'Fortuner','Toyota','Fortuner 4x4','Diesel',4500,'Not Available'
WHERE NOT EXISTS (SELECT 1 FROM cars WHERE LOWER(car_name)='fortuner');

UPDATE cars SET status = CASE
  WHEN LOWER(car_name) IN ('swift','baleno','creta','venue','nexon','harrier') THEN 'Available'
  WHEN LOWER(car_name) IN ('city','innova crysta','xuv700','fortuner') THEN 'Not Available'
  ELSE status END;

-- Payment receipt support
ALTER TABLE payments ADD COLUMN IF NOT EXISTS transaction_id VARCHAR(40);
UPDATE payments SET transaction_id = 'TXN-LEGACY-' || payment_id WHERE transaction_id IS NULL;
ALTER TABLE payments ALTER COLUMN transaction_id SET NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS idx_payments_transaction_id ON payments(transaction_id);


-- Data integrity and performance improvements
ALTER TABLE bookings DROP CONSTRAINT IF EXISTS chk_booking_dates;
ALTER TABLE bookings ADD CONSTRAINT chk_booking_dates CHECK (pickup_date < return_date);
ALTER TABLE bookings DROP CONSTRAINT IF EXISTS chk_booking_status;
ALTER TABLE bookings ADD CONSTRAINT chk_booking_status CHECK (booking_status IN ('Pending','Booked','Delivered','Completed','Cancelled'));
ALTER TABLE payments DROP CONSTRAINT IF EXISTS chk_payment_status;
ALTER TABLE payments ADD CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending','Paid','Failed','Refunded'));
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_car_dates ON bookings(car_id, pickup_date, return_date);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(booking_status);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(payment_status);
