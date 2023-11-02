DROP DATABASE IF EXISTS quanlybanhang;
create database quanlybanhang;
USE quanlybanhang;

create table ProductType
(
    id        varchar(4) PRIMARY KEY,
    type_name varchar(255) NOT NULL,
    note      text         NOT NULL
);
create table Product
(
    id              varchar(4) PRIMARY KEY,
    product_type_id varchar(4)   NOT NULL,
    name            varchar(255) NOT NULL,
    unit            varchar(255) NOT NULL,
    image           longblob     NOT NULL,
    note            text
);
create table Customer
(
    id        varchar(4) PRIMARY KEY,
    full_name varchar(30) NOT NULL,
    address   varchar(30),
    dob       date,
    phone     varchar(15)
);
create table Employee
(
    id             varchar(4) PRIMARY KEY,
    full_name      varchar(30)                      NOT NULL,
    gender         ENUM ('Male', 'Female', 'Other') NOT NULL,
    address        varchar(255)                     NOT NULL,
    dob            date                             NOT NULL,
    place_of_birth varchar(20)                      NOT NULL,

    phone          varchar(15),
    email          varchar(255),
    start_date     datetime,
    manager_id     varchar(4)
);
create table Provider
(
    id      varchar(5) PRIMARY KEY,
    name    varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    phone   varchar(15) NOT NULL,
    email   varchar(30) NOT NULL,
    website varchar(30)
);
create table ImportForm
(
    id          varchar(5) PRIMARY KEY,
    employee_id varchar(4) NOT NULL,
    provider_id varchar(5) NOT NULL,
    import_date datetime   NOT NULL,
    note        varchar(100)
);
create table ImportFormDetail
(
    product_id     varchar(4),
    import_form_id varchar(5),
    quantity       smallint       NOT NULL default 0,
    import_price   DECIMAL(10, 2) NOT NULL check ( import_price > 0 ),
    primary key (product_id, import_form_id)

);
create table ExportForm
(
    id          varchar(5) PRIMARY KEY,
    employee_id varchar(4) NOT NULL,
    customer_id varchar(4) NOT NULL,
    date        datetime   NOT NULL,
    note        text
);
create table ExportFormDetail
(
    export_form_id varchar(5),
    product_id     varchar(4),
    quantity       smallint       NOT NULL check ( ExportFormDetail.quantity > 0 ),
    export_price   DECIMAL(10, 2) NOT NULL check ( export_price > 0 ),
    primary key (product_id, export_form_id)
);

ALTER TABLE Product
    ADD CONSTRAINT fk_product_type_id
        FOREIGN KEY (product_type_id) REFERENCES ProductType (id);

ALTER TABLE ImportForm
    ADD CONSTRAINT fk_import_form_employee_id
        FOREIGN KEY (employee_id) REFERENCES Employee (id);
ALTER TABLE ImportForm
    ADD CONSTRAINT fk_provider_id
        FOREIGN KEY (provider_id) REFERENCES Provider (id);

ALTER TABLE ExportForm
    ADD CONSTRAINT fk_export_form_employee_id
        FOREIGN KEY (employee_id) REFERENCES Employee (id);
ALTER TABLE ExportForm
    ADD CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) REFERENCES Customer (id);

ALTER TABLE ExportFormDetail
    ADD CONSTRAINT fk_export_form_id
        FOREIGN KEY (export_form_id) REFERENCES ExportForm (id);
ALTER TABLE ExportFormDetail
    ADD CONSTRAINT fk_EFD_product_id
        FOREIGN KEY (product_id) REFERENCES Product (id);

ALTER TABLE ImportFormDetail
    ADD CONSTRAINT fk_import_form_id
        FOREIGN KEY (import_form_id) REFERENCES ImportForm (id);
ALTER TABLE ImportFormDetail
    ADD CONSTRAINT fk_IFD_product_id
        FOREIGN KEY (product_id) REFERENCES Product (id);
