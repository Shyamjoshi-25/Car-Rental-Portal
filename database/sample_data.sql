-- ==========================================
-- CAR RENTAL PORTAL SAMPLE DATA
-- ==========================================

\c car_rental;


-- ==========================================
-- ADMIN DATA
-- ==========================================

INSERT INTO admin (username, password)
VALUES
('admin', 'pbkdf2_sha256$210000$K3RCAkuYauDEmxkvUVQZyw==$TmPdJK2P567IQsyUdXoj9i4IypQZQRka4/IwfOSGVqI=');


-- ==========================================
-- USERS DATA
-- ==========================================

INSERT INTO users
(full_name, email, phone, password)
VALUES
('Rahul Patil', 'rahul@gmail.com', '9876543210', 'pbkdf2_sha256$210000$iATVr0cvXJKQ+nlS+o3Kmg==$Z4piEULGi2OkXGUYUSskrSga3pSxxmhzjMjmZYoUgNc='),

('Priya Sharma', 'priya@gmail.com', '9876543211', 'pbkdf2_sha256$210000$+c+9nUnyIr79L93MPKN5FA==$HK455mlHduDMaJE4J35FUAVzjEYLtW2Y+s/yVw31pPM='),

('Amit Joshi', 'amit@gmail.com', '9876543212', 'pbkdf2_sha256$210000$KLWaN66L5CPpWmX+lCj7Vg==$d91+Dy/BfU5i/ur11T/z3uEcK1aOqRY4yRbaKhZ0eAs=');


-- ==========================================
-- CARS DATA
-- ==========================================

INSERT INTO cars
(car_name, brand, model, fuel_type, price_per_day, status)
VALUES

('Swift', 'Maruti Suzuki', 'Swift VXI', 'Petrol', 1500.00, 'Available'),

('Baleno', 'Maruti Suzuki', 'Baleno Delta', 'Petrol', 1800.00, 'Available'),

('Creta', 'Hyundai', 'Creta SX', 'Diesel', 2800.00, 'Available'),

('Venue', 'Hyundai', 'Venue S', 'Petrol', 2200.00, 'Available'),

('Nexon', 'Tata', 'Nexon XZ', 'Petrol', 2000.00, 'Available'),

('Harrier', 'Tata', 'Harrier XZA', 'Diesel', 3200.00, 'Available'),

('City', 'Honda', 'City V', 'Petrol', 2500.00, 'Not Available'),

('Innova Crysta', 'Toyota', 'Innova Crysta GX', 'Diesel', 3500.00, 'Not Available'),
('XUV700', 'Mahindra', 'XUV700 AX5', 'Diesel', 3000.00, 'Not Available'),
('Fortuner', 'Toyota', 'Fortuner 4x4', 'Diesel', 4500.00, 'Not Available');