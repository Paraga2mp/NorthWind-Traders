# NorthWind-Traders
Database Project - populate database, redesign and implement changes, migrate all existing data from the original database to the newly-enhanced database

I analyzed and designed of an Entity Relationship Diagram (ERD), implemented both Data Definition Language (DDL) and Data Manipulation Language (DML) scripts, 
as well as used queries in a variety of ways to help transform, populate, and test the validity of the work.

PROJECT SCENARIO & REQUIREMENTS
A fictional company named NorthWind Traders has hired you to make some enhancements to their existing order-tracking database. You will be required to analyze their existing 
database, design a solution to meet their requirements, create the new database according to the new design, and then migrate all data from their existing database into the 
new one. They would also like some basic query scripts to verify the success of the data migration.

ENHANCEMENT #1 – BETTER INVENTORY TRACKING
The existing database has three fields in the Products table that are currently used to track inventory stock (UnitsInStock, UnitsOnOrder, ReorderLevel). However, the company 
owns three different warehouses, and currently has no way of tracking stock levels for each product in each warehouse. Inventory for any product could be stored at any of the 
three warehouse locations. Each warehouse has a name and a street address that should be stored in the new database. The warehouses are commonly known by their location within 
the city: The Dockside warehouse, the Airport warehouse and the Central warehouse. The new scheme should be able to record the same basic data as the existing database 
(UnitsInStock, UnitsOnOrder, ReorderLevel), but also reference the warehouse in which the products are currently being stored in, or re-ordered from. Note: Your script should 
distribute existing products amongst the three warehouses. Feel free to make up the distribution.

ENHANCEMENT #2 – CENTRALIZATION OF COUNTRY DATA
The accounting team often uses country-related data from the database when generating reports based on financial, supply chain or human resources data tracked in the system. 
The current database records this country data in several tables (Customers, Orders, Suppliers, & Employees). However, frequent report errors are being encountered due to problems
with the country data. For example, if a country name is misspelled, it shows up as a separate report item, even though it is obviously the same country with a typo in the name.
The accounting team has proposed a centralized list of countries in the database. Each of the tables that currently record Country data should no longer allow user-entered country
names, but should instead “look up” the desired country from the new central Country table. During data entry via the website, the country will be selected from a dropdown list 
instead of being typed manually. The software dev team will implement that change on the website, but the new database design should support a centralized Country table.

ENHANCEMENT #3 – FULL NAMES WITH TITLE
The HR department has requested a database change to help integration with the new HR software program. The new software does not work well when importing separate values for first/last names and the title of courtesy. They propose adding a new field that contains a combined value in the following format: <Courtesy Title> <First Name> <Last Name>. Examples: Mr. John Doe or Dr. Jane Smith. The proposed field will not replace the usage of the existing separate fields; it will simply be a redundant field containing the full value from the three other fields, for use only with the new HR software program.

