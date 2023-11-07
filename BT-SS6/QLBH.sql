DROP DATABASE IF EXISTS quan_ly_ban_hang;
CREATE DATABASE IF NOT EXISTS quan_ly_ban_hang;
USE quan_ly_ban_hang;

CREATE TABLE product(
	pID 	INT AUTO_INCREMENT PRIMARY KEY,
    pName 	VARCHAR(25) NOT NULL,
    pPrice 	INT UNSIGNED 
);

CREATE TABLE Customer (
	cID 	INT AUTO_INCREMENT PRIMARY KEY,
    cName 	VARCHAR(25) NOT NULL,
    age 	TINYINT UNSIGNED 
);

CREATE TABLE Orders (
	oID 	INT AUTO_INCREMENT PRIMARY KEY,
    cID 	INT,
    oDate	DATETIME,
    oTotalPrice INT UNSIGNED,
    CONSTRAINT FK_PersonOrder FOREIGN KEY (cID) REFERENCES customer(cID)
);

CREATE TABLE orderDetail(
	oID 		INT,
    pID 		INT,
    odQTY 	INT UNSIGNED,
	PRIMARY KEY (oID, pID),
    CONSTRAINT FK_PersonOrderDetail FOREIGN KEY (oID) REFERENCES orders(oID),
	CONSTRAINT FK_ProductOrderDetail FOREIGN KEY (pID) REFERENCES product(pID)
);

INSERT INTO Customer (cName, age	)
VALUES 				("Minh Quan", 10),
					("Ngoc Oanh", 20),
					("Hong Ha", 50);

INSERT INTO Orders  (cID , oDate 	)
VALUES 				(1, '2006-03-21'),
					(2, '2006-03-23'),
					(1, '2006-03-16');
                    
                    
INSERT INTO Product (pName , pPrice 	)
VALUES 				("May Giat", 3),
					("Tu Lanh", 5),
                    ("Dieu Hoa", 7),
					("Quat", 1),
					("Bep Dien", 2);
                    
INSERT INTO orderDetail(oID , pID, odQTY  )
VALUES 				(1,1,3),
					(1,3,7),
                    (1,4,2),
					(2,1,1),
                    (3,1,8),
					(2,5,4),
                    (2,3,3);

-- Hiển thị các thông tin  gồm oID,cID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Orders,
SELECT * FROM orders ORDER BY oDate DESC;

-- Hiển thị tên và giá của các sản phẩm có giá cao nhất như sau:
SELECT pName, pPrice 
FROM product
WHERE pPrice = (SELECT max(pPrice)  FROM product);
                    
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó
SELECT c.cName, p.pName
FROM orders o
INNER JOIN customer c USING(cID)
INNER JOIN orderdetail od USING(oID)
INNER JOIN product p USING(pID);

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT cName FROM customer
WHERE cName 
	NOT IN (SELECT DISTINCT cName
			FROM orders o
			INNER JOIN customer c USING(cID));
            
-- Hiển thị chi tiết của từng hóa đơn như sau :
SELECT o.oID, o.oDate, od.odQTY, p.pName, p.pPrice
FROM orders o
INNER JOIN orderdetail od USING(oID)
INNER JOIN product p USING(pID);

-- Tạo một view tên là Sales để hiển thị tổng doanh thu của siêu thị như sau:
CREATE VIEW Sales 
AS
SELECT  sum((od.odQTY * p.pPrice)) sales
FROM orders o
INNER JOIN orderdetail od USING(oID)
INNER JOIN product p USING(pID);

-- Xóa tất cả các ràng buộc khóa ngoại, khóa chính của tất cả các bảng.
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
DROP FOREIGN KEY FK_PersonOrderDetail ;
                 
ALTER TABLE orderdetail
DROP FOREIGN KEY FK_ProductOrderDetail;

--  Tạo một trigger tên là cusUpdate trên bảng Customer, sao cho khi sửa mã khách (cID) thì mã khách trong bảng Order cũng được sửa theo:
DELIMITER //
CREATE TRIGGER cusUpdate AFTER UPDATE ON Customer
FOR EACH ROW
BEGIN
    IF NEW.cID <> OLD.cID THEN
        UPDATE Orders
        SET cID = NEW.cID
        WHERE cID = OLD.cID;
    END IF;
END//

DELIMITER ;

--  Tạo một stored procedure tên là delProduct nhận vào 1 tham số là tên của một sản phẩm, 
-- strored procedure này sẽ xóa sản phẩm có tên được truyên vào thông qua tham số, 
-- và các thông tin liên quan đến sản phẩm đó ở trong bảng OrderDetail
DELIMITER //

CREATE PROCEDURE delProduct(IN productName VARCHAR(100))
BEGIN
    DECLARE productId INT;

    -- Lấy ID của sản phẩm dựa trên tên
    SELECT ID INTO productId FROM Product WHERE ProductName = productName;

    -- Xóa sản phẩm trong bảng Product
    DELETE FROM Product WHERE ProductName = productName;

    -- Xóa các thông tin liên quan trong bảng OrderDetail
    DELETE FROM OrderDetail WHERE ProductID = productId;
END //
DELIMITER ;
