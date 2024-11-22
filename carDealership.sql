-- drops database if it exists
DROP DATABASE IF EXISTS dealership;

-- creates database if exists
CREATE DATABASE IF NOT EXISTS dealership;

-- uses dealership database
USE dealership;

-- creates 'dealerships' table 
CREATE TABLE dealerships (
dealership_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each dealership 
name VARCHAR(50), -- dealership name (max 50 char)
address VARCHAR(50), -- dealership address (max 50 char)
phone VARCHAR(12) -- dealership address (max 12 char)
);

CREATE TABLE vehicles (
vin VARCHAR(20) PRIMARY KEY NOT NULL, -- vin number max 20 char (usually 17 long) 
year INT NOT NULL, 
make VARCHAR(50) NOT NULL,
model VARCHAR(50) NOT NULL,
vehicleType VARCHAR(50) NOT NULL,
color VARCHAR(50) NOT NULL,
odometer INT NOT NULL,
price DECIMAL(10, 2) NOT NULL, -- DECIMAL value on the left indicates max number of digits that can be stored both to the left and right of the decimal point. right number is for digits stored for decimal value
sold BOOLEAN DEFAULT FALSE -- sold status default to false for not sold

);

CREATE TABLE inventory (
dealership_id INT,
vin VARCHAR(20), 
PRIMARY KEY(dealership_id, vin),
FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id), -- Relationship to dealership
FOREIGN KEY (vin) REFERENCES vehicles(vin) -- relationship to vehicles
);

CREATE TABLE sales_contract (
id INT AUTO_INCREMENT PRIMARY KEY, -- id 
vin VARCHAR(20), -- foriegn key referencing vehicles
sale_date DATE NOT NULL, 
sale_price DECIMAL(10, 2) NOT NULL,
customer_name VARCHAR(100) NOT NULL,
customer_address TEXT,
sales_tax_amount DECIMAL(10, 2) DEFAULT 0.05,
recording_fee DECIMAL(10, 2) DEFAULT 100.00,
processing_fee DECIMAL (10,2) NOT NULL,
financing BOOLEAN DEFAULT FALSE,
vehicle_price DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (vin) REFERENCES vehicles(vin) -- foreign key referencing vehicles
);

CREATE TABLE lease_contracts (
    id INT AUTO_INCREMENT PRIMARY KEY,             -- id
    VIN VARCHAR(17),                               -- Foreign key referencing vehicles
    lease_fee_rate DECIMAL(10,2) DEFAULT 0.07,
    finance_rate DECIMAL(10,2) DEFAULT 0.04,
    lease_months INT NOT NULL,
    lease_start_date DATE NOT NULL,                 
    lease_end_date DATE NOT NULL,                   
    lease_monthly_payment DECIMAL(10, 2) NOT NULL,
    original_price DECIMAL(10,2) NOT NULL,
    expected_ending_value DECIMAL(10,2) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,            
    customer_address TEXT,                         
    FOREIGN KEY (vin) REFERENCES vehicles(vin)    -- Foreign key relationship to vehicles
    
);

INSERT INTO dealerships (name, address, phone)
VALUES 
	(' adrian motors', '123 main st, charlotte', '704-123-1234'),
	(' gen motors', '123 side st, charlotte', '704-123-1234');
    
INSERT INTO vehicles (vin, year, make, model, vehicleType, color, odometer, price, sold) 
VALUES 
	('1HGCM82633A123456', 2024, 'Honda', 'Civic', 'Sedan', 'Red', 15000, 22000.00, FALSE),
	('2T1BURHE9JC123456', 2024, 'Toyota', 'Corolla', 'Sedan', 'Blue', 12000, 18000.00, FALSE),
    ('1HGCM82633A987654', 2022, 'Honda', 'Accord', 'Sedan', 'Black', 22000, 25000.00, FALSE),
	('2T1BURHE9JC654321', 2023, 'Toyota', 'Camry', 'Sedan', 'White', 15000, 18000.00, FALSE);
    
INSERT INTO sales_contract 
(vin, sale_date, sale_price, customer_name, customer_address, sales_tax_amount, recording_fee, processing_fee, financing, vehicle_price) 
VALUES
('1HGCM82633A123456', '2024-11-01', 25000.00, 'John Doe', '456 Oak St, Charlotte, NC', 0.05, 100.00, 295.00, FALSE, 24000.00),
('2T1BURHE9JC123456', '2024-11-05', 18000.00, 'Jane Smith', '789 Pine St, Charlotte, NC', 0.05, 100.00, 295.00, TRUE, 17000.00);

INSERT INTO lease_contracts (VIN, lease_months, lease_start_date, lease_end_date, lease_monthly_payment, original_price, expected_ending_value, customer_name, customer_address)
VALUES
    ('1HGCM82633A987654', 36, '2024-12-01', '2027-12-01', 400.00, 25000.00, 15000.00, 'Alice Johnson', '321 Elm St, Charlotte, NC'),
	('2T1BURHE9JC654321', 48, '2024-12-10', '2028-12-10', 350.00, 18000.00, 12000.00, 'Bob Lee', '654 Maple St, Charlotte, NC');  

-- Adding Honda Civic (VIN: 1HGCM82633A123456) to the inventory of Adrian Motors (dealership_id = 1)
INSERT INTO inventory (dealership_id, vin)
VALUES 
    (1, '1HGCM82633A123456'),  -- Adrian Motors has Honda Civic

-- Adding Toyota Corolla (VIN: 2T1BURHE9JC123456) to the inventory of Gen Motors (dealership_id = 2)
    (2, '2T1BURHE9JC123456');  -- Gen Motors has Toyota Corolla






