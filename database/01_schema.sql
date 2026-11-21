#### Fayl 2: `database/01_schema.sql` (Struktur və View)
```sql
CREATE DATABASE IF NOT EXISTS pharmacy_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE pharmacy_db;

-- 1. Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories Table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    c_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 3. Medications Table
CREATE TABLE medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    m_name VARCHAR(150) NOT NULL,
    category_id INT,
    supplier_id INT,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    min_stock_level INT NOT NULL DEFAULT 10,
    expiry_date DATE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

-- 4. Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_surname VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- 5. Employees Table
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_surname VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2)
);

-- 6. Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT NOT NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 7. Sale Items Table
CREATE TABLE sale_items (
    sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    medication_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

-- 8. Prescriptions Table
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    doctor_name VARCHAR(150),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE
);

-- Reporting View: Consolidated Sale Details
CREATE OR REPLACE VIEW SaleDetails AS
SELECT
    s.sale_id,
    s.sale_date,
    c.customer_name,
    c.customer_surname,
    m.m_name AS medication_name,
    si.quantity,
    si.unit_price,
    si.subtotal
FROM sales AS s
LEFT JOIN customers AS c ON s.customer_id = c.customer_id
JOIN sale_items AS si ON s.sale_id = si.sale_id
JOIN medications AS m ON si.medication_id = m.medication_id;