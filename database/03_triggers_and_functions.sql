USE pharmacy_db;

DELIMITER $$

-- 1. Trigger: Automatically reduce medication stock after a sale item is recorded
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON sale_items
FOR EACH ROW
BEGIN
    UPDATE medications
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE medication_id = NEW.medication_id;
END$$

-- 2. Function: Calculate total spending of a specific customer
CREATE FUNCTION get_customer_total(p_customer_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT COALESCE(SUM(total_amount), 0)
    INTO total
    FROM sales
    WHERE customer_id = p_customer_id;
    RETURN total;
END$$

-- 3. Function: Evaluate stock level against minimum threshold
CREATE FUNCTION check_stock_status(p_medication_id INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE current_stock INT;
    DECLARE min_stock INT;
    
    SELECT stock_quantity, min_stock_level
    INTO current_stock, min_stock
    FROM medications
    WHERE medication_id = p_medication_id;
    
    IF current_stock <= min_stock THEN
        RETURN 'Low Stock';
    ELSE
        RETURN 'Sufficient';
    END IF;
END$$

DELIMITER ;