DROP DATABASE IF EXISTS quan_ly_ban_hang;
CREATE DATABASE IF NOT EXISTS quan_ly_ban_hang;
USE quan_ly_ban_hang;

CREATE TABLE product
(
    pID    INT AUTO_INCREMENT PRIMARY KEY,
    pName  VARCHAR(25) NOT NULL,
    pPrice INT UNSIGNED
);

CREATE TABLE Customer
(
    cID   INT AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(25) NOT NULL,
    age   TINYINT UNSIGNED
);

CREATE TABLE Orders
(
    oID         INT AUTO_INCREMENT PRIMARY KEY,
    cID         INT,
    oDate       DATETIME,
    oTotalPrice INT UNSIGNED,
    CONSTRAINT FK_PersonOrder FOREIGN KEY (cID) REFERENCES customer (cID)
);

CREATE TABLE orderDetail
(
    oID   INT,
    pID   INT,
    odQTY INT UNSIGNED,
    PRIMARY KEY (oID, pID),
    CONSTRAINT FK_PersonOrderDetail FOREIGN KEY (oID) REFERENCES orders (oID),
    CONSTRAINT FK_ProductOrderDetail FOREIGN KEY (pID) REFERENCES product (pID)
);

INSERT INTO Customer (cName, age)
VALUES ("Minh Quan", 10),
       ("Ngoc Oanh", 20),
       ("Hong Ha", 50);

INSERT INTO Orders (cID, oDate)
VALUES (1, '2006-03-21'),
       (2, '2006-03-23'),
       (1, '2006-03-16');


INSERT INTO Product (pName, pPrice)
VALUES ("May Giat", 3),
       ("Tu Lanh", 5),
       ("Dieu Hoa", 7),
       ("Quat", 1),
       ("Bep Dien", 2);

INSERT INTO orderDetail(oID, pID, odQTY)
VALUES (1, 1, 3),
       (1, 3, 7),
       (1, 4, 2),
       (2, 1, 1),
       (3, 1, 8),
       (2, 5, 4),
       (2, 3, 3);

SELECT *
FROM orders
ORDER BY oDate DESC;

SELECT pName, pPrice
FROM product
WHERE pPrice = (SELECT max(pPrice) FROM product);

SELECT c.cName, p.pName
FROM orders o
         INNER JOIN customer c USING (cID)
         INNER JOIN orderdetail od USING (oID)
         INNER JOIN product p USING (pID);

SELECT cName
FROM customer
WHERE cName
          NOT IN (SELECT DISTINCT cName
                  FROM orders o
                           INNER JOIN customer c USING (cID));

SELECT o.oID, o.oDate, od.odQTY, p.pName, p.pPrice
FROM orders o
         INNER JOIN orderdetail od USING (oID)
         INNER JOIN product p USING (pID);

CREATE VIEW Sales
AS
SELECT sum((od.odQTY * p.pPrice)) sales
FROM orders o
         INNER JOIN orderdetail od USING (oID)
         INNER JOIN product p USING (pID);

ALTER TABLE customer
    DROP PRIMARY KEY;

ALTER TABLE product
    DROP PRIMARY KEY;

ALTER TABLE orders
    DROP PRIMARY KEY;

ALTER TABLE orders
    DROP FOREIGN KEY FK_PersonOrder;

ALTER TABLE orderdetail
    DROP PRIMARY KEY;

ALTER TABLE orderdetail
    DROP FOREIGN KEY FK_PersonOrderDetail;

ALTER TABLE orderdetail
    DROP FOREIGN KEY FK_ProductOrderDetail;

DELIMITER //
CREATE TRIGGER cusUpdate
    AFTER UPDATE
    ON Customer
    FOR EACH ROW
BEGIN
    IF NEW.cID <> OLD.cID THEN
        UPDATE Orders
        SET cID = NEW.cID
        WHERE cID = OLD.cID;
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delProduct(IN productName VARCHAR(100))
BEGIN
    DECLARE productId INT;

    SELECT ID INTO productId FROM Product WHERE ProductName = productName;

    DELETE FROM Product WHERE ProductName = productName;

    DELETE FROM OrderDetail WHERE ProductID = productId;
END //
DELIMITER ;
