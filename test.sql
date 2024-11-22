USE dealership;

-- get all dealerships
SELECT * FROM dealerships;

-- find all vehicles for a specific dealership
SELECT * FROM dealerships WHERE name = 'gen motors';

-- find car by vin
SELECT * FROM vehicles WHERE vin = '1HGCM82633A123456';

-- find the dealership where a certain car is located by VIN.
SELECT * FROM dealerships INNER JOIN inventory on dealerships.dealership_id = inventory.dealership_id WHERE vin = '1HGCM82633A123456';

-- find all dealerships that have a certain car type 
SELECT dealerships.name, dealerships.address,vehicles.vin, vehicles.make, vehicles.model FROM inventory 
INNER JOIN vehicles ON inventory.vin = vehicles.vin 
INNER JOIN dealerships ON inventory.dealership_id = dealerships.dealership_id
 WHERE vehicles.vehicleType = 'coupe';
 
 -- get all sales information for a specific dealer for a specific date range
 SELECT sales_contract.*, vehicles.*, dealerships.*
FROM sales_contract
INNER JOIN inventory ON sales_contract.vin = inventory.vin
INNER JOIN vehicles ON sales_contract.vin = vehicles.vin
INNER JOIN dealerships ON inventory.dealership_id = dealerships.dealership_id
WHERE dealerships.name = 'adrian motors' -- specify dealership name or use dealership_id
AND sales_contract.sale_date BETWEEN '2024-11-01' AND '2024-11-30' -- specify your desired date range
ORDER BY sales_contract.sale_date;

