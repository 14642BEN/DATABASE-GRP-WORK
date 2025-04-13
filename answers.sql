-- Create database 
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;
-- Create table publisher A list of publishers for books

 CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Website VARCHAR(100)
);

-- create table book_language
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50)
);
-- create table book
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    publisher_id INT,
    language_id INT,
    publish_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);
-- insert data into table book
INSERT INTO book (title,  publisher_id, language_id, publish_date, price)
VALUES
('ECHOES OF WAR', 2345, 1, 2024-010-01, 19.99),

-- create table author
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    bio TEXT
);
-- Create table book_author
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
-- insert data into table author
('BEN', 'RUTH', 'Author of 2025 and Shamba la Wanyama.'),
('Zablon', 'Kioko', 'Author of Echoes of war.'),
('Henry', 'Okambo', 'Author of When the sun goes down.'),
('Akoko', 'Obanda', 'Author of The River and the source.');

-- query to show all authors
SELECT author_id, first_name, last_name, bio FROM author;

-- insert data into table book_language
INSERT INTO book_language (language_name) VALUES
('English'),
('Swahili'),
('French'),
('Kikamba'),
('kikuyu');

-- query to show all book languages
SELECT * FROM book_language;
-- insert data into table publisher
INSERT INTO publisher (publisher_id, name, website) VALUES
('2345', 'BEN RUTH ', 'https://www. benruth.com'),
('4009', 'ZABLOB KIOKO', 'https://www.zabkiosh.com');

-- view all publishers
SELECT * FROM publisher;
 -- create table customer  A list of the bookstore's customers.
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- insert data into table customer
INSERT INTO customer (first_name, last_name, email, phone)
VALUES ('BENSON', 'MUIA', 'kilonzoben007.com', '0719836479')
, ('RUTH', 'SHAMIM', 'ruthgitungo.com', '0725277661');
-- view all customer
SELECT * FROM customer;

CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) -- e.g., 'current', 'old'
);

-- create table country A list of countries where the addresses are located
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL
);
-- insert data into table country where the addresses are located 
INSERT INTO country (country_name)
VALUES 
('KENYA'),
('SOUTH AFRICA'),
('NIGERIA'),
('ZIBAMBWE'),
('ZAMBIA'),
('Egypt');
-- create table address A list of all addresses in the system
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
-- insert data into table address
INSERT INTO address (street, city, state, postal_code, country_id)
VALUES 
('210', 'MASII', 'MACHAKOS', '90101', 1),  -- Kenya
('456 ', 'lagos', 'abuja', 'LA 1A1', 2),  -- Nigeria
('789 ', 'petrolia', 'Durban', 'D1 6D4', 3);  -- South Africa
-- create table customer_address A list of addresses for customers. Each customer can have multiple addresses.
CREATE TABLE customer_address (
    customer_address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    address_status_id INT,
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

-- insert data into table country
INSERT INTO country (country_name)
VALUES ('KENYA'), ('NIGERIA'), ('SOUTH AFRICA');

-- insert data into table customer
INSERT INTO customer (first_name, last_name, email, phone)
VALUES
('Ben', 'Muia', 'kilonzoben007@gmail.com', '0719836479'),
('Ann', 'Musili', 'annabel10@gmail.com', '2547 92645876'),
('RUTH', 'GITUNGO', 'ruthgitungo@gmail.com', '0725277661');
-- insert data into table customer_address each customer can have multiple addresses
INSERT INTO customer_address (customer_id, address_id, address_status_id)
VALUES
(1, 1, 1),  -- Ben muia, Address 1, status ID 1 (e.g., current)
(1, 2, 1),  -- ben muia, Address 2, status ID 1 (e.g., current)
(2, 3, 2);  -- Ruth Gitungo, Address 3, status ID 2 (e.g., old)
-- create table address_status A list of statuses for an address (e.g., current, old)
CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);
--insert data into table address_status for an address (eg. current, old)
INSERT INTO address_status (status_name)
VALUES 
('current'),
('old');
-- query for customer RUTH (ID=2)
SELECT 
    c.first_name, 
    c.last_name, 
    a.street, 
    a.city, 
    a.state, 
    a.postal_code, 
    co.country_name, 
    ca.added_on 
FROM 
    customer_address ca
JOIN 
    customer c ON ca.customer_id = c.customer_id
JOIN 
    address a ON ca.address_id = a.address_id
JOIN 
    country co ON a.country_id = co.country_id
WHERE 
    ca.customer_id = 2 AND ca.address_status_id = 2;
-- insert into table country a list of countries where the addresses are located
INSERT INTO country (country_name)
VALUES 
('Kenya'),
('south africa'),
('Egypt'),
('Zambia'),
('Zibambwe');

-- create table shipping method a list of possible shipping methods
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) DEFAULT 0.00
);
-- insert data into table shipping method
INSERT INTO shipping_method (method_name, cost)
VALUES 
('Standard Shipping', 3.29),
('Express Shipping', 10.78),
('In-Store Pickup', 0.00);
-- create table order_status A list of possible statuses for an order (e.g., pending, shipped, delivered)
CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);
-- insert data into table order_status
INSERT INTO order_status (status_name)
VALUES ('pending'), ('shipped'), ('delivered'), ('cancelled');
-- create table cust_order  A list of orders placed by customers
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
-- inserting data into table cust_order to make an order
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id, total_amount)
VALUES 
(1, 1, 1, 36.97),  -- Ben
(2, 2, 1, 25.00);  -- Muia

-- create table order_line A list of books that are part of each order
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
-- insering data into table order_line 
INSERT INTO order_line (order_id, book_id, quantity, price_per_unit)
VALUES
(1, 101, 2, 10.99),  -- BEN ordered 2 copies of "The Great Gatsby"
(1, 102, 1, 14.99),  -- Gitungo also ordered "1984"
(2, 103, 2, 12.50);  -- Bob ordered 2 copies of "To Kill a Mockingbird"

-- create table oreder_history A record of the history of an order (e.g., ordered, cancelled, delivered)
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);
-- insert data into order_history to show order status
INSERT INTO order_history (order_id, status_id, notes)
VALUES 
(1, 1, 'Order placed'),
(1, 2, 'Shipped via DHL'),
(1, 3, 'Delivered to customer');
 -- create table user to add user/admins who log changes
 CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    role ENUM('admin', 'staff') DEFAULT 'staff',
    email VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- inserting sample users into table user
INSERT INTO user (username, full_name, role, email)
VALUES 
('admin1', 'BEN', 'admin', 'kilonzoben007@gmail.com'),
('staff1', 'RUTH', 'staff', 'ruthgitungo@gmail.com');


-- alter table order_history
ALTER TABLE order_history
ADD COLUMN user_id INT,
ADD FOREIGN KEY (user_id) REFERENCES user(user_id);

-- insert status change with user login
INSERT INTO order_history (order_id, status_id, notes, user_id)
VALUES 
(1, 2, 'Order shipped via DHL', 1);
 -- query history with user info
 SELECT 
    oh.history_id,
    oh.status_date,
    os.status_name,
    oh.notes,
    u.full_name AS updated_by,
    u.role
FROM order_history oh
JOIN order_status os ON oh.status_id = os.order_status_id
LEFT JOIN user u ON oh.user_id = u.user_id
ORDER BY oh.status_date DESC;

--create readonly user
mysql -u root -p
CREATE USER 'ANN'@'localhost' IDENTIFIED BY 'Sijui12345';

GRANT SELECT ON bookstore_db.* TO 'ANN'@'localhost';
-- grant read+write (SELECT,INSERT,UPDATE,DELETE) access to a user
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.* TO 'username'@'localhost';
FLASH PRIVILEGES;
-- login as the readonly user created
mysql -u ANN -p
USE bookstore_db;
--  view data from tables (select)

SELECT * FROM book;
INSERT INTO book (title, , publisher_id, language_id, publish_date, price)
VALUES ('New Book Title',  2345, 1, 2024-01-01, 19.99);


--create an admin
CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'Test@123';
-- grant all privileges to admin
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'Admin'@'localhost';
-- login as admin
mysql -u Admin -p
use bookstore_db;
-- view all tables
SHOW TABLES;
-- view all data from book table
SELECT * FROM book;
 EXIT.




