-- Cập nhật số điện thoại mới cho khách hàng mã KH10
UPDATE Customer
SET phone = '0987654999'
WHERE id = 'KH10';
-- Cập nhật địa chỉ mới cho nhân viên mã NV05
UPDATE Employee
SET address = 'Địa chỉ mới của nhân viên NV05'
WHERE id = 'NV05';


-- Xóa nhân viên có mã NV3
DELETE
FROM Employee
WHERE id = 'NV05';
-- Xóa sản phẩm có mã SP15
DELETE
FROM Product
WHERE id = 'SP15';

#1
SELECT id,
       full_name,
       gender,
       dob,
       address,
       phone,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM Employee
ORDER BY age;

#2
SELECT i.id,
       i.employee_id,
       E.full_name AS employee_name,
       P.name      AS provider_name,
       i.import_date,
       i.note
FROM ImportForm i
         INNER JOIN Employee E ON i.employee_id = E.id
         INNER JOIN Provider P ON i.provider_id = P.id
WHERE DATE_FORMAT(i.import_date, '%Y-%m') = '2023-11';

#3
SELECT *
FROM Product
WHERE unit = 'chai';

#4
SELECT import_form_id,
       product_id,
       product.name,
       producttype.type_name,
       product.unit,
       ifd.quantity,
       ifd.import_price,
       ifd.quantity * ifd.import_price as total
FROM importformdetail as ifd
         INNER JOIN importform
                    on ifd.import_form_id = importform.id
         INNER JOIN product
                    on ifd.product_id = product.id
         INNER JOIN producttype
                    on product.product_type_id = producttype.id
ORDER BY DATE_FORMAT(ifd.import_form_id, '%Y-%m') = DATE_FORMAT(CURDATE(), '%Y-%m');

#5
select provider.id, name, address, phone, email, importform.import_date
from provider
         inner join importform on provider.id = importform.provider_id
order by import_date;

#6
SELECT EF.id                           AS export_form_id,
       E.full_name                     AS employee_name,
       EF.date                         AS sale_date,
       EFD.product_id,
       P.name                          AS product_name,
       P.unit                          AS product_unit,
       EFD.quantity                    AS product_quantity,
       EFD.export_price                AS product_price,
       EFD.quantity * EFD.export_price AS revenue
FROM ExportFormDetail EFD
         INNER JOIN ExportForm EF ON EFD.export_form_id = EF.id
         INNER JOIN Employee E ON EF.employee_id = E.id
         INNER JOIN Product P ON EFD.product_id = P.id
WHERE DATE_FORMAT(EF.date, '%Y-%m') BETWEEN '2018-01' AND '2018-06';

#7
SELECT *
FROM Customer
WHERE MONTH(dob) = MONTH(CURDATE());

#8
SELECT EF.id                           AS export_form_id,
       E.full_name                     AS employee_name,
       EF.date                         AS sale_date,
       EFD.product_id,
       P.name                          AS product_name,
       P.unit                          AS product_unit,
       EFD.quantity                    AS product_quantity,
       EFD.export_price                AS product_price,
       EFD.quantity * EFD.export_price AS revenue
FROM ExportFormDetail EFD
         INNER JOIN ExportForm EF ON EFD.export_form_id = EF.id
         INNER JOIN Employee E ON EF.employee_id = E.id
         INNER JOIN Product P ON EFD.product_id = P.id
WHERE EF.date BETWEEN '2018-04-15' AND '2018-05-15';

#9
SELECT EF.id                                AS export_form_id,
       EF.date                              AS sale_date,
       C.id                                 AS customer_id,
       C.full_name                          AS customer_name,
       SUM(EFD.quantity * EFD.export_price) AS total_value
FROM ExportForm EF
         INNER JOIN Customer C ON EF.customer_id = C.id
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
GROUP BY EF.id, EF.date, C.id, C.full_name;

#10
SELECT SUM(EFD.quantity) AS total_quantity
FROM ExportFormDetail EFD
         INNER JOIN ExportForm EF ON EFD.export_form_id = EF.id
         INNER JOIN Product P ON EFD.product_id = P.id
WHERE P.name = 'Sản phẩm 1'
  AND YEAR(EF.date) = 2023
  AND MONTH(EF.date) BETWEEN 6 AND 12;

#11
SELECT DATE_FORMAT(EF.date, '%Y-%m')        AS month,
       C.id                                 AS customer_id,
       C.full_name                          AS customer_name,
       C.address                            AS customer_address,
       SUM(EFD.quantity * EFD.export_price) AS total_amount
FROM ExportForm EF
         INNER JOIN Customer C ON EF.customer_id = C.id
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
GROUP BY month, C.id, C.full_name, C.address
ORDER BY month, C.id;

#12
SELECT YEAR(EF.date)     AS year,
       MONTH(EF.date)    AS month,
       P.id              AS product_id,
       P.name            AS product_name,
       P.unit            AS product_unit,
       SUM(EFD.quantity) AS total_quantity
FROM ExportForm EF
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
         INNER JOIN Product P ON EFD.product_id = P.id
GROUP BY year, month, P.id, P.name, P.unit
ORDER BY year, month, P.id;

#13
SELECT DATE_FORMAT(EF.date, '%Y-%m')        AS month,
       SUM(EFD.quantity * EFD.export_price) AS total_revenue
FROM ExportForm EF
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
WHERE EF.date BETWEEN '2023-06-01' AND '2023-12-31'
GROUP BY month
ORDER BY month;

#14
SELECT EF.id                                AS invoice_number,
       EF.date                              AS sale_date,
       E.full_name                          AS employee_name,
       C.full_name                          AS customer_name,
       SUM(EFD.quantity * EFD.export_price) AS total_value
FROM ExportForm EF
         INNER JOIN Employee E ON EF.employee_id = E.id
         INNER JOIN Customer C ON EF.customer_id = C.id
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
WHERE DATE_FORMAT(EF.date, '%Y-%m') IN ('2023-10', '2023-11')
GROUP BY EF.id, EF.date, E.full_name, C.full_name
ORDER BY EF.id;

#15
SELECT EF.id                                AS invoice_number,
       EF.customer_id                       AS customer_id,
       C.full_name                          AS customer_name,
       E.full_name                          AS employee_name,
       EF.date                              AS sale_date,
       SUM(EFD.quantity * EFD.export_price) AS total_value
FROM ExportForm EF
         INNER JOIN Customer C ON EF.customer_id = C.id
         INNER JOIN Employee E ON EF.employee_id = E.id
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
WHERE DATE(EF.date) = CURDATE()
GROUP BY EF.id, EF.customer_id, C.full_name, E.full_name, EF.date
ORDER BY EF.id;

#16
SELECT E.id              AS employee_id,
       E.full_name       AS employee_name,
       P.id              AS product_id,
       P.name            AS product_name,
       P.unit            AS product_unit,
       SUM(EFD.quantity) AS total_quantity
FROM Employee E
         INNER JOIN ExportForm EF ON E.id = EF.employee_id
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
         INNER JOIN Product P ON EFD.product_id = P.id
GROUP BY E.id, E.full_name, P.id, P.name, P.unit
ORDER BY E.id, P.id;

#17
SELECT EF.id                           AS invoice_number,
       EF.date                         AS sale_date,
       P.id                            AS product_id,
       P.name                          AS product_name,
       P.unit                          AS product_unit,
       EFD.quantity                    AS quantity,
       EFD.export_price                AS unit_price,
       EFD.quantity * EFD.export_price AS total_price
FROM ExportForm EF
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
         INNER JOIN Product P ON EFD.product_id = P.id
WHERE EF.customer_id = 'CUS1'
  AND EF.date BETWEEN '2023-10-01' AND '2023-12-31'
ORDER BY EF.id;

#18
SELECT P.id         AS product_id,
       P.name       AS product_name,
       PT.type_name AS product_type,
       P.unit       AS product_unit
FROM Product P
         INNER JOIN ProductType PT ON P.product_type_id = PT.id
WHERE P.id NOT IN (SELECT DISTINCT EFD.product_id
                   FROM ExportFormDetail EFD
                            INNER JOIN ExportForm EF ON EFD.export_form_id = EF.id
                   WHERE EF.date BETWEEN '2018-01-01' AND '2018-06-30')
ORDER BY P.id;

#19
SELECT P.id      AS provider_id,
       P.name    AS provider_name,
       P.address AS provider_address,
       P.phone   AS provider_phone
FROM Provider P
WHERE P.id NOT IN (SELECT DISTINCT importform.provider_id
                   FROM ImportForm
                   WHERE importform.import_date BETWEEN '2018-04-01' AND '2018-06-30')
ORDER BY P.id;

#20
SELECT EF.customer_id                       AS customer_id,
       C.full_name                          AS customer_name,
       SUM(EFD.quantity * EFD.export_price) AS total_order_value
FROM ExportForm EF
         INNER JOIN ExportFormDetail EFD ON EF.id = EFD.export_form_id
         INNER JOIN Customer C ON EF.customer_id = C.id
WHERE EF.date BETWEEN '2023-07-01' AND '2023-12-31'
GROUP BY EF.customer_id, C.full_name
ORDER BY total_order_value DESC
LIMIT 1;

#21
SELECT customer_id, COUNT(id) AS order_count
FROM ExportForm
GROUP BY customer_id;

#22
SELECT E.id AS employee_id, E.full_name AS employee_name, C.full_name AS customer_name
FROM ExportForm EF
         LEFT JOIN Employee E ON EF.employee_id = E.id
         LEFT JOIN Customer C ON EF.customer_id = C.id;

#23
SELECT gender, COUNT(*) AS employee_count
FROM Employee
GROUP BY gender;


#24
SELECT id                             AS employee_id,
       full_name                      AS employee_name,
       YEAR(NOW()) - YEAR(start_date) AS years_of_service
FROM Employee
ORDER BY years_of_service DESC
LIMIT 3;

#25
SELECT id                          AS employee_id,
       full_name,
       gender,
       YEAR(CURDATE()) - YEAR(dob) AS age
FROM Employee
WHERE (gender = 'Male' AND YEAR(CURDATE()) - YEAR(dob) >= 60)
   OR (gender = 'Female' AND YEAR(CURDATE()) - YEAR(dob) >= 55);

#26
SELECT full_name AS employee_name,
       CASE
           WHEN gender = 'Male' THEN YEAR(dob) + 60
           WHEN gender = 'Female' THEN YEAR(dob) + 55
           END   AS retirement_year
FROM Employee;

#27
SELECT id        AS employee_id,
       full_name AS employee_name,
       CASE
           WHEN YEAR(NOW()) - YEAR(start_date) < 1 THEN 200000
           WHEN YEAR(NOW()) - YEAR(start_date) < 3 THEN 400000
           WHEN YEAR(NOW()) - YEAR(start_date) < 5 THEN 600000
           WHEN YEAR(NOW()) - YEAR(start_date) < 10 THEN 800000
           ELSE 1000000
           END   AS tet_bonus
FROM Employee;

#28
SELECT p.id AS product_id, p.name AS product_name
FROM Product AS p
         INNER JOIN ProductType AS pt ON p.product_type_id = pt.id
WHERE pt.type_name = 'Mỹ Phẩm';

#29
SELECT p.id AS product_id, p.name AS product_name
FROM Product AS p
         INNER JOIN ProductType AS pt ON p.product_type_id = pt.id
WHERE pt.type_name = 'Quần Áo';

#30
SELECT COUNT(*) AS clothing_product_count
FROM Product AS p
         INNER JOIN ProductType AS pt ON p.product_type_id = pt.id
WHERE pt.type_name = 'Quần Áo';

#31
SELECT COUNT(*) AS cosmetic_product_count
FROM Product AS p
         INNER JOIN ProductType AS pt ON p.product_type_id = pt.id
WHERE pt.type_name = 'Mỹ Phẩm';

#32
SELECT pt.type_name, COUNT(p.id) AS product_count
FROM Product AS p
         INNER JOIN ProductType AS pt ON p.product_type_id = pt.id
GROUP BY pt.type_name;
