DELIMITER //

CREATE TRIGGER check_product_quantity
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE available_count INT;

    -- получим доступное количество товара
    SELECT `count` INTO available_count
    FROM Product
    WHERE product_id = NEW.product_id;

    -- проверим, превышает ли количество заказа количество товара
    IF NEW.`count` > available_count THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Количество заказа превышает количество доступного товара';
    END IF;
END //

CREATE TRIGGER check_product_quantity_update
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
    DECLARE available_count INT;

    --получим доступное количество товара
    SELECT `count` INTO available_count
    FROM Product
    WHERE product_id = NEW.product_id;

    -- проверим, превышает ли количество заказа количество товара
    IF NEW.`count` > available_count THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Количество заказа превышает количество доступного товара';
    END IF;
END //

DELIMITER ;