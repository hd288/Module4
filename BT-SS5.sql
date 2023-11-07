DROP DATABASE IF EXISTS demo;
CREATE DATABASE IF NOT EXISTS demo;
USE demo;

CREATE TABLE Products
(
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    productCode        VARCHAR(4)     NOT NULL,
    productName        VARCHAR(255)   NOT NULL,
    productPrice       DECIMAL(10, 2) NOT NULL,
    productAmount      INT     DEFAULT 0,
    productDescription VARCHAR(255)   NOT NULL,
    productStatus      BOOLEAN DEFAULT TRUE
);

INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES (1234, 'productName', 12.34, 5, 'productDescription', true),
       (5678, 'anotherProduct', 45.67, 3, 'anotherDescription', false),
       (9012, 'yetAnotherProduct', 89.01, 10, 'yetAnotherDescription', true);


CREATE UNIQUE INDEX unique_index
    ON Products (productCode);

CREATE INDEX composite_index
    ON Products (productName, productPrice);

EXPLAIN
SELECT *
FROM Products;

CREATE VIEW ViewProduct AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;
UPDATE Products
SET productName = '+33 14 723 5555'
WHERE id = 4;

DROP VIEW ViewProduct;

-- Procedure to get all products
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //

DELIMITER ;

-- Procedure to add a product
DELIMITER //

CREATE PROCEDURE AddProduct()
BEGIN
    INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES ("1234", "productName", 12.34, 5, "productDescription", true);
END //

DELIMITER ;

-- Procedure to update a product
DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN productId INT,
    IN productName VARCHAR(100),
    IN productPrice DECIMAL(10, 2)
)
BEGIN
    UPDATE Products
    SET productName  = productName,
        productPrice = productPrice
    WHERE id = productId;
END //

DELIMITER ;

-- Procedure to delete a product
DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN productId INT
)
BEGIN
    DELETE
    FROM Products
    WHERE id = productId;
END //

DELIMITER ;
