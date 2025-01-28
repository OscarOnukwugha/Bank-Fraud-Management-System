CREATE DATABASE sales_database;
USE sales_database;

CREATE TABLE customers
(
	customer_id INT (10) PRIMARY KEY, 
    first_name VARCHAR (25),
    last_name VARCHAR (25),
    email VARCHAR (50),
    phone_number INT (11),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
CREATE TABLE orders
(
	order_id INT PRIMARY KEY,
    customer_id INT (10),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    item_id INT (10),
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    );
    
CREATE TABLE items
(
	item_id INT (10) PRIMARY KEY,
    sku VARCHAR (25),
    item_name VARCHAR (50),
    item_category VARCHAR (50),
    item_size INT(10),
    unit_price DECIMAL (10,2)
    );
    
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

    
CREATE TABLE address
(
	address_id INT (10) PRIMARY KEY,
    customer_id INT (10),
    delivery_address1 VARCHAR (50),
	delivery_address2 VARCHAR (50),
    city VARCHAR (25),
    state VARCHAR (25),
    zipcode INT(10),
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
	);

CREATE TABLE recipe
(	
    recipe_id INT (10) PRIMARY KEY,
    item_id INT,
    recipe_name VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
    );
    
CREATE TABLE Ingredients (
    ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    recipe_id INT,
    ingredient_name VARCHAR(100),
    quantity_required DECIMAL(10,2),
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id)
);
    
CREATE TABLE inventory
(
	inventory_id INT (10) PRIMARY KEY,
    item_id INT,
    stock_in INT,
    stock_out INT,
    stock_balance INT AS (stock_in - stock_out),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

CREATE TABLE staff
(
	staff_id INT (10) PRIMARY KEY,
    first_name VARCHAR (25),
    last_name VARCHAR (25),
    position VARCHAR (50),
    salary DECIMAL (10,2),
    hire_date DATE 
    );
    
CREATE TABLE Shift (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    shift_name VARCHAR(50),
    start_time TIME,
    end_time TIME
);

CREATE TABLE Rotation (
    rotation_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    shift_id INT,
    rotation_date DATE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (shift_id) REFERENCES Shift(shift_id)
);    