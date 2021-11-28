#########################################################################################################
# Final Project - Data Migration (DDL & DML Script)                                                     #
# Name: Ashraf Mamun                                                                                    #
#Student ID: W0425052                                                                                   #
#########################################################################################################

#########################################################################################################

# Part - 2: DDL & DML Script

#########################################################################################################

# Create the database  northwind_Enhanced
DROP DATABASE IF EXISTS northwind_Enhanced;
CREATE DATABASE IF NOT EXISTS northwind_Enhanced;


# Create table categories
DROP TABLE IF EXISTS northwind_Enhanced.categories;
CREATE TABLE northwind_Enhanced.categories
(
    `CategoryID`   int(5)      NOT NULL AUTO_INCREMENT,
    `CategoryName` varchar(15) NOT NULL DEFAULT '' UNIQUE,
    `Description`  mediumtext  NOT NULL,
    `Picture`      varchar(50) NOT NULL DEFAULT '',
    PRIMARY KEY (`CategoryID`)
);

# Insert data from northwind_Orig
INSERT INTO northwind_Enhanced.categories (SELECT * FROM northwind_Orig.categories);



# Create a temporary table table categories
DROP TABLE IF EXISTS northwind_Enhanced.Temp_country;

CREATE TABLE northwind_Enhanced.Temp_country
(
    Name varchar(60) NOT NULL DEFAULT ''
);

# Insert all the country names from 4 tables of northwind_Orig database
INSERT INTO northwind_Enhanced.Temp_country (Name)
SELECT customers.Country
FROM northwind_Orig.customers;
INSERT INTO northwind_Enhanced.Temp_country (Name)
SELECT orders.shipcountry
FROM northwind_Orig.orders;
INSERT INTO northwind_Enhanced.Temp_country (Name)
SELECT suppliers.country
FROM northwind_Orig.suppliers;
INSERT INTO northwind_Enhanced.Temp_country (Name)
SELECT Employees.country
FROM northwind_Orig.employees;


# Create table Country
DROP TABLE IF EXISTS northwind_Enhanced.Country;

CREATE TABLE northwind_Enhanced.Country
(
    CountryID    int(10) PRIMARY KEY AUTO_INCREMENT,
    Name         varchar(60) NOT NULL UNIQUE DEFAULT '',
    Abbreviation varchar(5)
);


# Insert data into the country table from Temp_Country table
INSERT INTO northwind_Enhanced.Country (Name) (SELECT DISTINCT Name FROM northwind_Enhanced.Temp_country ORDER BY Name);



# Create table customers
DROP TABLE IF EXISTS northwind_Enhanced.customers;

CREATE TABLE northwind_Enhanced.customers
(
    CustomerID  varchar(5) PRIMARY KEY,
    CompanyName varchar(40),
    ContactName varchar(30) NOT NULL DEFAULT '',
    Address     varchar(60) NOT NULL DEFAULT '',
    city        varchar(15) NOT NULL DEFAULT '',
    Region      varchar(15),
    PostalCode  varchar(10) NOT NULL,
    Country     varchar(15) NOT NULL,
    Phone       varchar(24) NOT NULL DEFAULT '',
    Fax         varchar(24),
    CountryID   int(10)
);

# Insert data into customers table from northwind_Orig customers table
INSERT INTO northwind_Enhanced.customers (CustomerID, CompanyName, ContactName, Address, city, Region, PostalCode,
                                          Phone, Fax)
    (SELECT CustomerID,
            CompanyName,
            ContactName,
            Address,
            city,
            Region,
            PostalCode,
            Phone,
            Fax
     FROM northwind_Orig.customers);


# Create a table employees
DROP TABLE IF EXISTS northwind_Enhanced.employees;
CREATE TABLE northwind_Enhanced.employees
(
    EmployeeID      int(10) PRIMARY KEY AUTO_INCREMENT,
    LastName        varchar(20) NOT NULL DEFAULT '',
    FirstName       varchar(20) NOT NULL DEFAULT '',
    FullName        varchar(60),
    Title           varchar(10),
    TitleOfCourtesy varchar(20),
    BirthDate       date,
    HireDate        date        NOT NULL,
    Address         varchar(60) NOT NULL,
    city            varchar(15) NOT NULL,
    Region          varchar(15),
    PostalCode      varchar(10) NOT NULL,
    Country         varchar(30) NOT NULL,
    HomePhone       varchar(15),
    Extension       varchar(4),
    Notes           varchar(500),
    ReportsTo       int(10),
    CountryID       int(10)
);


# Insert data into employees table from employees of northwind_Orig database
INSERT INTO northwind_Enhanced.employees (EmployeeID, LastName, FirstName, FullName, Title, TitleOfCourtesy, BirthDate,
                                          HireDate, Address, city, Region, PostalCode,
                                          HomePhone, Extension, Notes, ReportsTo)
    (SELECT EmployeeID,
            LastName,
            FirstName,
            CONCAT(TitleOfCourtesy, FirstName, ' ', LastName),
            Title,
            TitleOfCourtesy,
            BirthDate,
            HireDate,
            Address,
            city,
            Region,
            PostalCode,
            HomePhone,
            Extension,
            Notes,
            ReportsTo
     FROM northwind_Orig.employees);



# Create table orders
DROP TABLE IF EXISTS northwind_Enhanced.orders;
CREATE TABLE northwind_Enhanced.orders
(
    `OrderID`        int(10)     NOT NULL AUTO_INCREMENT,
    `CustomerID`     varchar(5)  NOT NULL DEFAULT '',
    `EmployeeID`     int(10)     NOT NULL,
    `OrderDate`      datetime    NOT NULL,
    `RequiredDate`   datetime             DEFAULT NULL,
    `ShippedDate`    datetime             DEFAULT NULL,
    `ShipVia`        int(10)     NOT NULL,
    `Freight`        double      NOT NULL DEFAULT '0',
    `ShipName`       varchar(40) NOT NULL DEFAULT '',
    `ShipAddress`    varchar(60) NOT NULL DEFAULT '',
    `ShipCity`       varchar(15) NOT NULL DEFAULT '',
    `ShipRegion`     varchar(15) NOT NULL DEFAULT '',
    `ShipPostalCode` varchar(10) NOT NULL DEFAULT '',
    `ShipCountry`    varchar(15) NOT NULL,
    CountryID        int(10),
    PRIMARY KEY (`OrderID`)
);

# Insert data into orders table from northwind_Orig orders table
INSERT INTO northwind_Enhanced.orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia,
                                       Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode)
    (SELECT OrderID,
            CustomerID,
            EmployeeID,
            OrderDate,
            RequiredDate,
            ShippedDate,
            ShipVia,
            Freight,
            ShipName,
            ShipAddress,
            ShipCity,
            ShipRegion,
            ShipPostalCode
     FROM northwind_Orig.orders);



# Create a table suppliers
DROP TABLE IF EXISTS northwind_Enhanced.suppliers;
CREATE TABLE northwind_Enhanced.suppliers
(
    `SupplierID`   int(10)      NOT NULL AUTO_INCREMENT,
    `CompanyName`  varchar(40)  NOT NULL DEFAULT '',
    `ContactName`  varchar(30)  NOT NULL DEFAULT '',
    `ContactTitle` varchar(30)  NOT NULL DEFAULT '',
    `Address`      varchar(60)  NOT NULL DEFAULT '',
    `City`         varchar(15)  NOT NULL DEFAULT '',
    `Region`       varchar(15)  NOT NULL DEFAULT '',
    `PostalCode`   varchar(10)  NOT NULL DEFAULT '',
    `Country`      varchar(15)  NOT NULL,
    `Phone`        varchar(24)  NOT NULL DEFAULT '',
    `Fax`          varchar(24)  NOT NULL DEFAULT '',
    `HomePage`     varchar(255) NOT NULL DEFAULT '',
    CountryID      int(10),
    PRIMARY KEY (`SupplierID`)
);

# Insert data into suppliers table from northwind_Orig suppliers table
INSERT INTO northwind_Enhanced.suppliers (supplierid, companyname, contactname, contacttitle, address, city, region,
                                          postalcode, phone, fax, homepage)
    (SELECT supplierid,
            companyname,
            contactname,
            contacttitle,
            address,
            city,
            region,
            postalcode,
            phone,
            fax,
            homepage
     FROM northwind_Orig.suppliers);


# Create a table products
DROP TABLE IF EXISTS northwind_Enhanced.products;
CREATE TABLE northwind_Enhanced.products
(
    `ProductID`       int(10)        NOT NULL AUTO_INCREMENT,
    `ProductName`     varchar(40)    NOT NULL DEFAULT '',
    `SupplierID`      int(10)        NOT NULL,
    `CategoryID`      int(5)         NOT NULL,
    `QuantityPerUnit` varchar(20)    NOT NULL DEFAULT '',
    `UnitPrice`       double         NOT NULL DEFAULT '0',
    `Discontinued`    enum ('y','n') NOT NULL DEFAULT 'n',
    PRIMARY KEY (`ProductID`)
);

# Insert data into products table from northwind_Orig products table
INSERT INTO northwind_Enhanced.products (productid, productname, supplierid, categoryid, quantityperunit, unitprice,
                                         discontinued)
    (SELECT productid, productname, supplierid, categoryid, quantityperunit, unitprice, discontinued
     FROM northwind_Orig.products);


# Create a table shippers
DROP TABLE IF EXISTS northwind_Enhanced.shippers;
CREATE TABLE northwind_Enhanced.shippers
(
    `ShipperID`   int(10)     NOT NULL AUTO_INCREMENT,
    `CompanyName` varchar(40) NOT NULL DEFAULT '',
    `Phone`       varchar(24) NOT NULL DEFAULT '',
    PRIMARY KEY (`ShipperID`)
);

# Insert data into shippers table from northwind_Orig shippers table
INSERT INTO northwind_Enhanced.shippers (shipperID, CompanyName, Phone) (SELECT shipperID, CompanyName, Phone FROM northwind_Orig.shippers);


# Create a table warehouses
DROP TABLE IF EXISTS northwind_Enhanced.warehouses;
CREATE TABLE northwind_Enhanced.warehouses
(
    WarehouseID int(10)     NOT NULL AUTO_INCREMENT,
    Name        varchar(40) NOT NULL DEFAULT '',
    Address     varchar(60) NOT NULL DEFAULT '',
    PRIMARY KEY (`WarehouseID`)
);

# Insert data into warehouses table
INSERT INTO northwind_Enhanced.warehouses (name, address)
VALUES ('The Dockside warehouse', '123 Robie Street, Halifax, NS'),
       ('The Airport warehouse ', '456 Robie Street, Halifax, NS'),
       ('The Central warehouse', '789 Robie Street, Halifax, NS');


# Create a table products_warehouses
DROP TABLE IF EXISTS northwind_Enhanced.products_warehouses;
CREATE TABLE northwind_Enhanced.products_warehouses
(
    ProductID    int(10),
    WarehouseID  int(10),
    UnitsinStock int(10) NOT NULL DEFAULT '0',
    UnitsOnOrder int(10) NOT NULL DEFAULT '0',
    ReorderLevel int(10) NOT NULL DEFAULT '0'
);

# Insert data into products_warehouses table from products table
INSERT INTO northwind_Enhanced.products_warehouses (productid, UnitsinStock, UnitsOnOrder, ReorderLevel)
    (SELECT productid, UnitsinStock, UnitsOnOrder, ReorderLevel FROM northwind_Orig.products);


# Create a table order_details
DROP TABLE IF EXISTS northwind_Enhanced.order_details;
CREATE TABLE northwind_Enhanced.order_details
(
    `ID`        int(10) NOT NULL AUTO_INCREMENT,
    `OrderID`   int(10) NOT NULL,
    `ProductID` int(10) NOT NULL,
    `UnitPrice` double  NOT NULL DEFAULT '0' CHECK ( UnitPrice > -1),
    `Quantity`  int(5)  NOT NULL DEFAULT '1',
    `Discount`  float   NOT NULL DEFAULT '0' CHECK ( Discount > -1),
    PRIMARY KEY (`ID`)
);

# Insert data into order_details table from northwind_Orig order_details table
INSERT INTO northwind_Enhanced.order_details (ID, OrderID, ProductID, UnitPrice, Quantity, Discount)
    (SELECT ID, OrderID, ProductID, UnitPrice, Quantity, Discount FROM northwind_Orig.order_details);


# Inserting countryID to the suppliers table
UPDATE northwind_Enhanced.suppliers, northwind_Enhanced.Country, northwind_Orig.suppliers
SET northwind_Enhanced.suppliers.CountryID = northwind_Enhanced.country.CountryID
WHERE northwind_Orig.suppliers.Country = northwind_Enhanced.Country.Name
  AND northwind_Enhanced.suppliers.SupplierID = northwind_Orig.suppliers.SupplierID;


# Inserting countryID to the customers table
UPDATE northwind_Enhanced.customers, northwind_Enhanced.Country, northwind_Orig.customers
SET northwind_Enhanced.customers.CountryID = northwind_Enhanced.country.CountryID
WHERE northwind_Orig.customers.Country = northwind_Enhanced.Country.Name
  AND northwind_Enhanced.customers.CustomerID = northwind_Orig.customers.CustomerID;


# Inserting countryID to the employees table
UPDATE northwind_Enhanced.employees, northwind_Enhanced.Country, northwind_Orig.employees
SET northwind_Enhanced.employees.CountryID = northwind_Enhanced.country.CountryID
WHERE northwind_Orig.employees.Country = northwind_Enhanced.Country.Name
  AND northwind_Enhanced.employees.EmployeeID = northwind_Orig.employees.EmployeeID;


# Inserting countryID to the orders table
UPDATE northwind_Enhanced.orders, northwind_Enhanced.Country, northwind_Orig.orders
SET northwind_Enhanced.orders.CountryID = northwind_Enhanced.country.CountryID
WHERE northwind_Orig.orders.Shipcountry = northwind_Enhanced.Country.Name
  AND northwind_Enhanced.orders.OrderID = northwind_Orig.orders.OrderID;


# Assign productID to warehouses
UPDATE northwind_Enhanced.products_warehouses
SET products_warehouses.WarehouseID = 1
WHERE northwind_Enhanced.products_warehouses.productid <= 25;


# Assign productID to warehouses
UPDATE northwind_Enhanced.products_warehouses
SET products_warehouses.WarehouseID = 2
WHERE northwind_Enhanced.products_warehouses.productid > 25
  AND northwind_Enhanced.products_warehouses.productid < 55;


# Assign productID to warehouses
UPDATE northwind_Enhanced.products_warehouses
SET products_warehouses.WarehouseID = 3
WHERE northwind_Enhanced.products_warehouses.productid >= 55
  AND northwind_Enhanced.products_warehouses.productid <= 77;


# Drop country/shipcountry column from employees, customers, orders and suppliers tables after adding countryID
# column to these tables

ALTER TABLE northwind_Enhanced.orders
    DROP COLUMN ShipCountry;

ALTER TABLE northwind_Enhanced.customers
    DROP COLUMN Country;

ALTER TABLE northwind_Enhanced.employees
    DROP COLUMN Country;

ALTER TABLE northwind_Enhanced.suppliers
    DROP COLUMN Country;


# Drop Temp_Country table
DROP TABLE northwind_Enhanced.Temp_country;


#####################################################################################################################

# Add Constraints

#####################################################################################################################


# Add foreign key to employees table

ALTER TABLE northwind_Enhanced.employees
    ADD CONSTRAINT `FK_employees_reports_to` FOREIGN KEY (`ReportsTo`) REFERENCES northwind_Enhanced.employees (`EmployeeID`);
ALTER TABLE northwind_Enhanced.employees
    ADD CONSTRAINT FK_employees_countryid FOREIGN KEY (CountryID) REFERENCES northwind_Enhanced.country (CountryID);


# Add foreign keys to products_warehouses table
ALTER TABLE northwind_Enhanced.products_warehouses
    ADD CONSTRAINT FK_products_warehouses_productid FOREIGN KEY (ProductID) REFERENCES northwind_Enhanced.products (`ProductID`);
ALTER TABLE northwind_Enhanced.products_warehouses
    ADD CONSTRAINT FK_products_warehouses_warehouseid FOREIGN KEY (WarehouseID) REFERENCES northwind_Enhanced.warehouses (`WarehouseID`);


# Add foreign key to order_details table
ALTER TABLE northwind_Enhanced.order_details
    ADD CONSTRAINT `FK_order_details_orderid` FOREIGN KEY (`OrderID`) REFERENCES northwind_Enhanced.orders (`OrderID`);
ALTER TABLE northwind_Enhanced.order_details
    ADD CONSTRAINT `FK_order_details_productid` FOREIGN KEY (`ProductID`) REFERENCES northwind_Enhanced.products_warehouses (`ProductID`);


# Add foreign keys to orders table
ALTER TABLE northwind_Enhanced.orders
    ADD CONSTRAINT `FK_orders_customer_id` FOREIGN KEY (`CustomerID`) REFERENCES northwind_Enhanced.customers (`CustomerID`);
ALTER TABLE northwind_Enhanced.orders
    ADD CONSTRAINT `FK_orders_employeeid` FOREIGN KEY (`EmployeeID`) REFERENCES northwind_Enhanced.employees (`EmployeeID`);
ALTER TABLE northwind_Enhanced.orders
    ADD CONSTRAINT `FK_orders_shipvia` FOREIGN KEY (`ShipVia`) REFERENCES northwind_Enhanced.shippers (`ShipperID`);
ALTER TABLE northwind_Enhanced.orders
    ADD CONSTRAINT FK_orders_countryid FOREIGN KEY (CountryID) REFERENCES northwind_Enhanced.country (CountryID);


# Add foreign keys to products table
ALTER TABLE northwind_Enhanced.products
    ADD CONSTRAINT `FK_products_categoryid` FOREIGN KEY (`CategoryID`) REFERENCES northwind_Enhanced.categories (`CategoryID`);
ALTER TABLE northwind_Enhanced.products
    ADD CONSTRAINT `FK_products_supplierid` FOREIGN KEY (`SupplierID`) REFERENCES northwind_Enhanced.suppliers (`SupplierID`);


# Add foreign keys to customers table
ALTER TABLE northwind_Enhanced.customers
    ADD CONSTRAINT FK_customers_countryid FOREIGN KEY (CountryID) REFERENCES northwind_Enhanced.country (CountryID);

# Add foreign keys to suppliers table
ALTER TABLE northwind_Enhanced.suppliers
    ADD CONSTRAINT FK_suppliers_countryid FOREIGN KEY (CountryID) REFERENCES northwind_Enhanced.country (CountryID);






