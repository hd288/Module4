-- Chèn dữ liệu vào bảng Provider
INSERT INTO Provider (id, name, address, phone, email, website)
VALUES ('PROV1', 'Nhà cung cấp 1', 'Địa chỉ 1', '0123456789', 'prov1@example.com', 'www.prov1.com'),
       ('PROV2', 'Nhà cung cấp 2', 'Địa chỉ 2', '0987654321', 'prov2@example.com', 'www.prov2.com');

-- Thêm dữ liệu vào bảng ProductType
INSERT INTO ProductType (id, type_name, note)
VALUES ('T1', 'Loại sản phẩm 1', 'Ghi chú cho loại sản phẩm 1'),
       ('T2', 'Loại sản phẩm 2', 'Ghi chú cho loại sản phẩm 2'),
       ('T3', 'Quần Áo', 'Ghi chú cho loại sản phẩm 3'),
       ('T4', 'Mỹ Phẩm', 'Ghi chú cho loại sản phẩm 4');

-- Thêm dữ liệu vào bảng Product
INSERT INTO Product (id, product_type_id, name, unit, image, note)
VALUES ('P1', 'T1', 'Sản phẩm 1', 'chai', 'NULL', 'Ghi chú cho sản phẩm 1'),
       ('P2', 'T2', 'Sản phẩm 2', 'cái', 'NULL', 'Ghi chú cho sản phẩm 2');

INSERT INTO Employee (id, full_name, gender, address, dob, place_of_birth, phone, email, start_date, manager_id)
VALUES ('EMP1', 'Nguyễn Văn C', 'Male', '123 Đường ABC, Thành phố XYZ', '1990-05-15', 'Thành phố XYZ', '0987654321',
        'abc@example.com', NOW(), 'EMP1');

-- Thêm Phiếu nhập 1
INSERT INTO ImportForm (id, employee_id, provider_id, import_date, note)
VALUES ('IN1', 'EMP1', 'PROV1', '2023-11-03', 'Ghi chú cho Phiếu nhập 1');

-- Thêm chi tiết Phiếu nhập 1 (2 sản phẩm)
INSERT INTO ImportFormDetail (import_form_id, product_id, quantity, import_price)
VALUES ('IN1', 'P1', 5, 10.99),
       ('IN1', 'P2', 3, 8.99);

-- Thêm Phiếu nhập 2
INSERT INTO ImportForm (id, employee_id, provider_id, import_date, note)
VALUES ('IN2', 'EMP1', 'PROV2', '2023-11-01', 'Ghi chú cho Phiếu nhập 2');

-- Thêm chi tiết Phiếu nhập 2 (2 sản phẩm)
INSERT INTO ImportFormDetail (import_form_id, product_id, quantity, import_price)
VALUES ('IN2', 'P1', 2, 15.99),
       ('IN2', 'P2', 4, 12.99);

INSERT INTO ImportForm (id, employee_id, provider_id, import_date, note)
VALUES ('IN3', 'EMP1', 'PROV2', '2023-11-04', 'Ghi chú cho Phiếu nhập 3');
INSERT INTO ImportFormDetail (import_form_id, product_id, quantity, import_price)
VALUES ('IN3', 'P1', 2, 16.99),
       ('IN3', 'P2', 4, 10.99);

-- Chèn dữ liệu vào bảng Customer
INSERT INTO Customer (id, full_name, address, dob, phone)
VALUES ('CUS1', 'Khách hàng 1', 'Địa chỉ 1', '1990-01-15', '0123456789'),
       ('CUS2', 'Khách hàng 2', 'Địa chỉ 2', '1985-05-20', '0987654321');


-- Thêm Phiếu xuất 1
INSERT INTO ExportForm (id, employee_id, customer_id, date, note)
VALUES ('EX1', 'EMP1', 'CUS1', NOW(), 'Ghi chú cho Phiếu xuất 1');

-- Thêm chi tiết Phiếu xuất 1 (3 sản phẩm)
INSERT INTO ExportFormDetail (export_form_id, product_id, quantity, export_price)
VALUES ('EX1', 'P1', 2, 18.99);

-- Thêm Phiếu xuất 2
INSERT INTO ExportForm (id, employee_id, customer_id, date, note)
VALUES ('EX2', 'EMP1', 'CUS2', NOW(), 'Ghi chú cho Phiếu xuất 2');

-- Thêm chi tiết Phiếu xuất 2 (3 sản phẩm)
INSERT INTO ExportFormDetail (export_form_id, product_id, quantity, export_price)
VALUES ('EX2', 'P2', 3, 21.99);

INSERT INTO ExportForm (id, employee_id, customer_id, date, note)
VALUES ('EX3', 'EMP1', 'CUS2', '2023-10-20', 'Ghi chú cho Phiếu xuất 3');
INSERT INTO ExportFormDetail (export_form_id, product_id, quantity, export_price)
VALUES ('EX3', 'P2', 2, 21.99);

INSERT INTO Employee (id, full_name, gender, address, dob, place_of_birth, phone, email, start_date, manager_id)
VALUES ('NV05', 'Nguyễn Văn D', 'Male', '123 Đường ABC, Thành phố XYZ', '1999-05-15', 'Thành phố XYZ', '0987654321',
        'abc@example.com', NOW(), 'EMP1'),
       ('EMP2', 'Nguyễn Linh Tinh', 'Male', '123 Đường ABC, Thành phố XYZ', '1989-07-25', 'Thành phố XYZ', '0987654321',
        'abc@example.com', NOW(), 'EMP1'),
       ('EMP3', 'Quả Đào Cà Tím', 'Female', '123 Đường ABC, Thành phố XYZ', '1998-04-30', 'Thành phố XYZ', '0987654321',
        'abc@example.com', NOW(), 'EMP1');
INSERT INTO Customer (id, full_name, address, dob, phone)
VALUES ('KH10', 'Khách hàng 4', 'Địa chỉ 1', '1999-01-15', '0123456789'),
       ('KH02', 'Khách hàng 3', 'Địa chỉ 2', '1989-05-20', '0987654321'),
       ('KH06', 'Khách hàng 6', 'Địa chỉ 2', '1989-11-20', '0987654321');
insert into product (id, product_type_id, name, unit, image, note)
    VALUE ('SP15', 'T2', 'demo 1', 'cái', 'null', 'ghi chú demo');

INSERT INTO Employee (id, full_name, gender, address, dob, place_of_birth, phone, email, start_date, manager_id)
VALUES ('EMP6', 'thâm niên 1', 'male', '123 Đường ABC, Thành phố XYZ', '1980-04-30', 'Thành phố XYZ', '0987654321',
        'abc@example.com', '2021-04-30', 'EMP1'),
       ('EMP7', 'thâm niên 1', 'male', '123 Đường ABC, Thành phố XYZ', '1980-04-30', 'Thành phố XYZ', '0987654321',
        'abc@example.com', '2021-04-30', 'EMP1'),
       ('EMP4', 'thâm niên 2', 'female', '123 Đường ABC, Thành phố XYZ', '1998-04-30', 'Thành phố XYZ', '0987654321',
        'abc@example.com', '2022-04-30', 'EMP1'),
       ('EMP5', 'thâm niên 3', 'female', '123 Đường ABC, Thành phố XYZ', '1999-04-30', 'Thành phố XYZ', '0987654321',
        'abc@example.com', '2020-04-30', 'EMP1');