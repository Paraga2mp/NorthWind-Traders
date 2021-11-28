
#########################################################################################################
# Final Project - Data Migration (Test Script)                                                          #
# Name: Ashraf Mamun                                                                                    #
#Student ID: W0425052                                                                                   #
#########################################################################################################

#########################################################################################################

# Part -3: Testing

##########################################################################################################


# Testing for count of records on new database tables and old database tables


# Count of Products table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(ProductID) AS "Num_Of_Products"
FROM northwind_Enhanced.products;

SELECT COUNT(ProductID) AS "Num_Of_Products"
FROM northwind_orig.products;


# Count of Customers table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(CustomerID) AS "Num_Of_Customers"
FROM northwind_Enhanced.customers;

SELECT COUNT(CustomerID) AS "Num_Of_Customers"
FROM northwind_orig.customers;


# Count of Orders table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(OrderID) AS "Num_Of_Orders"
FROM northwind_Enhanced.orders;

SELECT COUNT(OrderID) AS "Num_Of_Orders"
FROM northwind_orig.orders;


# Count of Order_Details table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(OrderID) AS "Num_Of_Order_Details"
FROM northwind_Enhanced.order_details;

SELECT COUNT(OrderID) AS "Num_Of_Order_Details"
FROM northwind_orig.order_details;



# Count of Suppliers table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(SupplierID) AS "Num_Of_Suppliers"
FROM northwind_Enhanced.suppliers;

SELECT COUNT(SupplierID) AS "Num_Of_Suppliers"
FROM northwind_orig.suppliers;


# Count of Employees table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(EmployeeID) AS "Num_Of_Employees"
FROM northwind_Enhanced.employees;

SELECT COUNT(EmployeeID) AS "Num_Of_Employees"
FROM northwind_orig.employees;


# Count of Shippers table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(ShipperID) AS "Num_Of_Shippers"
FROM northwind_Enhanced.shippers;

SELECT COUNT(ShipperID) AS "Num_Of_Shippers"
FROM northwind_orig.shippers;


# Count of Categories table, new table record count should be exactly same as northwind_orig database table
SELECT COUNT(CategoryID) AS "Num_Of_Categories"
FROM northwind_Enhanced.categories;

SELECT COUNT(CategoryID) AS "Num_Of_Categories"
FROM northwind_orig.categories;



# Count of Products table of northwind_orig database and Products_Warehouses of northwind_Enhanced database
SELECT COUNT(ProductID) AS "Num_Of_Products"
FROM northwind_Enhanced.products_warehouses;

SELECT COUNT(ProductID) AS "Num_Of_Products"
FROM northwind_orig.products;



# Record checking of product table, by changing productID numbers we can check the whole table
# 3 columns UnitsInStock, UnitsOnOrder, ReorderLevel were shiftted to a  new created junction table Products_Warehouses
# Both tables result should be same, except 3 columns

SELECT *
FROM northwind_Enhanced.products
WHERE ProductID >= 20 AND ProductID <=40;

SELECT *
FROM northwind_orig.products
WHERE ProductID >= 20 AND ProductID <=40;


# Check columns of Products_Warehouses table of northwind_Enhanced. We can test more by changing the where clause and quantity
# Both queries result should be same except 3 shifted columns

SELECT *
FROM northwind_orig.products
WHERE UnitsInStock > 50;

SELECT *
FROM northwind_Enhanced.products_warehouses
WHERE UnitsinStock > 50;


# Check Products and Warehouses table of northwind_Enhanced. We can test more by changing the where clause and quantity
# Both queries result should be same except 3 shifted columns

SELECT *
FROM northwind_orig.products
WHERE ProductID < 20;


SELECT *
FROM northwind_Enhanced.products_warehouses
INNER JOIN northwind_Enhanced.warehouses ON warehouses.WarehouseID = products_warehouses.WarehouseID
WHERE products_warehouses.ProductID < 20;


# Check UnitsInStock values in products_warehouses table after shifting from product table of northwind_Enhanced.
# We can test more by changing the where clause and quantity. Both queries result should be same.

SELECT SUM(UnitsInStock)
FROM northwind_orig.products
WHERE ProductID < 20;

SELECT SUM(UnitsInStock)
FROM northwind_Enhanced.products_warehouses
INNER JOIN northwind_Enhanced.warehouses ON warehouses.WarehouseID = products_warehouses.WarehouseID
WHERE products_warehouses.ProductID < 20;



# Check UnitsOnOrder values in products_warehouses table after shifting from product table of northwind_Enhanced.
# We can test more by changing the where clause and quantity. Both queries result should be same.

SELECT SUM(UnitsOnOrder)
FROM northwind_orig.products
WHERE ProductID > 30;

SELECT SUM(UnitsOnOrder)
FROM northwind_Enhanced.products_warehouses
INNER JOIN northwind_Enhanced.warehouses ON warehouses.WarehouseID = products_warehouses.WarehouseID
WHERE products_warehouses.ProductID > 30;



# Check ReorderLeve values in products_warehouses table after shifting from product table of northwind_Enhanced.
# We can test more by adding where clause and quantity. Both queries result should be same.



SELECT SUM(ReorderLevel)
FROM northwind_orig.products;


SELECT SUM(ReorderLevel)
FROM northwind_Enhanced.products_warehouses
INNER JOIN northwind_Enhanced.warehouses ON warehouses.WarehouseID = products_warehouses.WarehouseID;




# Check the Country names from the northwind_orig database and new created Country table of northwind_Enhanced database.
# Number of records should be same. By changing where clause we can check more Customer table

SELECT *
FROM northwind_orig.customers
WHERE customers.Country = 'UK';


SELECT *
FROM northwind_Enhanced.customers
INNER JOIN northwind_Enhanced.Country ON customers.CountryID = country.CountryID
WHERE northwind_Enhanced.Country.Name = 'UK';



# Check the Country names from the northwind_orig database and new created Country table of northwind_Enhanced database.
# Number of records should be same.By changing where clause we can check more with Employees table


SELECT *
FROM northwind_orig.employees
WHERE employees.Country = 'USA';


SELECT *
FROM northwind_Enhanced.employees
INNER JOIN northwind_Enhanced.Country ON employees.CountryID = country.CountryID
WHERE northwind_Enhanced.Country.Name = 'USA';



# Check the Country names from the northwind_orig database and new created Country table of northwind_Enhanced database.
# Number of records should be same. By changing where clause we can check more with Orders table


SELECT *
FROM northwind_orig.orders
WHERE orders.ShipCountry = 'Canada';


SELECT *
FROM northwind_Enhanced.orders
INNER JOIN northwind_Enhanced.Country ON orders.countryID = country.CountryID
WHERE northwind_Enhanced.Country.Name = 'Canada';




# Check the Country names from the northwind_orig database and new created Country table of northwind_Enhanced database.
# Number of records should be same. By changing where clause we can check more with Suppliers table


SELECT *
FROM northwind_orig.suppliers
WHERE Suppliers.Country = 'Sweden';


SELECT *
FROM northwind_Enhanced.suppliers
INNER JOIN northwind_Enhanced.Country ON suppliers.countryID = country.CountryID
WHERE northwind_Enhanced.Country.Name = 'Sweden';



