use mydb;


-- 1
SELECT od.*, (SELECT customer_id FROM orders as o WHERE od.order_id = o.id) as orders_customer_id
FROM order_details AS od;

-- 2
SELECT *
FROM order_details
WHERE order_id IN (SELECT id FROM orders WHERE shipper_id = 3);

-- 3
SELECT order_id, AVG(quantity) as avg_quantity
FROM (SELECT order_id, quantity FROM order_details WHERE quantity > 10) AS temp_table
GROUP BY temp_table.order_id;

-- 4
WITH OrderDetailsWithQuantity AS (SELECT order_id, quantity
                                  FROM order_details
                                  WHERE quantity > 10)

SELECT order_id, AVG(quantity) as avg_quantity
FROM OrderDetailsWithQuantity
GROUP BY order_id;

-- 5
DROP FUNCTION IF EXISTS DivideFloatValue;

DELIMITER //
CREATE FUNCTION DivideFloatValue(input_value FLOAT, divide_value INT)
    RETURNS FLOAT
    DETERMINISTIC
    NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = input_value / divide_value;
    RETURN result;
END //

DELIMITER ;

SELECT id, order_id, product_id, DivideFloatValue(quantity, 3) AS divided_quantity
FROM order_details;


