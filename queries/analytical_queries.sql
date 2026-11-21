USE pharmacy_db;

-- 1. Revenue Breakdown by Medication (Top Performing Products)
SELECT 
    m.m_name AS medication,
    c.c_name AS category,
    SUM(si.quantity) AS total_units_sold,
    SUM(si.subtotal) AS total_revenue
FROM medications AS m
JOIN categories AS c ON m.category_id = c.category_id
JOIN sale_items AS si ON m.medication_id = si.medication_id
GROUP BY m.medication_id, m.m_name, c.c_name
ORDER BY total_revenue DESC;

-- 2. Employee Sales Performance (Including Staff Without Direct Sales)
SELECT 
    CONCAT(e.employee_name, ' ', e.employee_surname) AS employee_full_name,
    e.role,
    COUNT(s.sale_id) AS total_transactions,
    COALESCE(SUM(s.total_amount), 0) AS total_sales_generated
FROM employees AS e
LEFT JOIN sales AS s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, employee_full_name, e.role
ORDER BY total_sales_generated DESC;

-- 3. Inventory Health Check (Low Stock & Expiration Monitoring)
SELECT 
    m_name,
    stock_quantity,
    min_stock_level,
    check_stock_status(medication_id) AS stock_status,
    expiry_date,
    DATEDIFF(expiry_date, CURDATE()) AS days_until_expiry
FROM medications
ORDER BY days_until_expiry ASC;

-- 4. Customer Purchase History & Lifetime Value
SELECT 
    c.customer_id,
    CONCAT(c.customer_name, ' ', c.customer_surname) AS customer_name,
    COUNT(s.sale_id) AS visit_count,
    get_customer_total(c.customer_id) AS total_spent
FROM customers AS c
LEFT JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC;

-- 5. Prescription-Linked Sales Audit
SELECT 
    p.prescription_id,
    p.doctor_name,
    s.sale_id,
    s.sale_date,
    CONCAT(c.customer_name, ' ', c.customer_surname) AS patient_name,
    s.total_amount
FROM prescriptions AS p
JOIN sales AS s ON p.sale_id = s.sale_id
LEFT JOIN customers AS c ON s.customer_id = c.customer_id;

-- 6. Average Salary by Role
SELECT 
    role,
    COUNT(employee_id) AS staff_count,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees
GROUP BY role
ORDER BY average_salary DESC;