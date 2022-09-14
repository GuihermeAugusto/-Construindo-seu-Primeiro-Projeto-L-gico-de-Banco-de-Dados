-- criação do banco de dados para o cenário de E-Commerce
create database ecommerce;
use ecommerce;

-- Tabela Cliente
create table clients(
         idClient int auto_increment primary key,
         fname varchar(10),
         minit char(3),
         lname varchar(20),
         CPF char(11) not null,
         Adress varchar(30),
         constraint unique_cpf_client unique (CPF)
);

-- Tabela Produto
create table product(
        IdProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletronic','clothing','Fitness','Food & Beverage','Tools','Market','Personal Security','Automotive') not null,  
		evaluation float default 0,
        price float,
        dimensions varchar(15)
);

-- Tabela de pedidos
create table orders(
		IdOrder int auto_increment primary key,
        IdOrdClient int,
        orderStatus enum('Confirmed','Canceled','In Process') default 'In Process',
        orderDescription varchar(255),
        shipping float default 0,
        paymentType enum('Ticket','Creditcard','Bank Transfer','Pix','Cash'),
        constraint fk_odr_client foreign key(idOrdClient) references clients (idClient)
        on update cascade
);

-- Tabela pagamento
create table payments(
        idPayment int auto_increment primary key,
        IdPayClient int,
        amount float,
        PayStatus enum('Confirmed', 'In Process', 'Canceled'),
        constraint fk_payment_client foreign key (idPayClient) references clients(idClient),
        constraint fk_payment_order foreign key (idPayOrder) references orders(idOrder)
        on update cascade
);

-- Tabela Forma de pagamento
create table payment_type(
		idPayment_type int,
        Creditcard float,
        ticket float,
        Bank_transfer float,
        Pix float,
        constraint fk_payment_type foreign key (idPayment_type) references payment(idPayment)
);

-- Tabela Estoque
create table product_storage(
        idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        amount int default 0
);

-- Tabela Fornecedor	
create table supplier(
		idSupplier int auto_increment primary key,
        corpName varchar(255) not null,
        CNPJ char(14) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

-- Tabela Vendedor
create table supplier(
		idSeller int auto_increment primary key,
        companyName varchar(255) not null,
        tradingName varchar(255),
        CNPJ char(14) not null,
        CPF char(9),
        localization varchar(100),
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ),
        constraint unique_cp_seller unique (CPF)
);

-- Tabela Produtos/vendedor
create table product_seller(
		idPseller int,
        idProduct int,
        prodAmount int default 1,
        primary key (idPseller, idProduct),
        constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
        constraint fk_product_product foreign key (idProduct) references product(idProduct)
);
    
 -- Tabela Produto/Fornecedor
CREATE TABLE product_supplier (
		idPsupplier	INT,
        idPproduct	INT,
        quantity	INT NOT NULL,
        PRIMARY KEY	(idPsupplier, idPproduct),
        CONSTRAINT	fk_product_supplier_supplier FOREIGN KEY (idPsupplier) REFERENCES supplier (idSupplier),
        CONSTRAINT	fk_product_supplier_product FOREIGN KEY (idPproduct) REFERENCES product (idproduct)
);

-- Tabela Produtos/Pedidos
CREATE TABLE product_order (
		idPOproduct	INT,
        idPOorder	INT,
        prodAmount	INT DEFAULT 1,
        prodStatus	ENUM('Available', 'Unavailable') DEFAULT 'Available',
        PRIMARY KEY	(idPOproduct, idPOorder),
        CONSTRAINT 	fk_product_order_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
		CONSTRAINT 	fk_product_order_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- Tabela Produto em estóque
CREATE TABLE storage_location (
		idLproduct	INT,
        idLstorage	INT,
        location	VARCHAR(255) NOT NULL,
        PRIMARY KEY	(idLproduct, idLstorage),
        CONSTRAINT	fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
        CONSTRAINT	fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES product_storage(idPstorage)
);

-- SHOW TABLES;
-- SHOW DATABASES;
-- USE information_schema;
-- SHOW TABLES;
-- DESC table_constraints;
-- DESC referential_constraints;
-- SELECT * FROM referential_constraints WHERE constraint_schema = 'ecommerce';   
    

