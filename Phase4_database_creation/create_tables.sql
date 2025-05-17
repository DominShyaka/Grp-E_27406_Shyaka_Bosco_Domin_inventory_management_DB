-- Create Tables
CREATE TABLE Categories (
    CategoryID NUMBER PRIMARY KEY,
    CategoryName VARCHAR2(100) NOT NULL
);

CREATE TABLE Suppliers (
    SupplierID NUMBER PRIMARY KEY,
    SupplierName VARCHAR2(100),
    ContactInfo VARCHAR2(255)
);

CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100) NOT NULL,
    CategoryID NUMBER REFERENCES Categories(CategoryID),
    SupplierID NUMBER REFERENCES Suppliers(SupplierID),
    QuantityInStock NUMBER DEFAULT 0,
    ReorderLevel NUMBER DEFAULT 5
);

CREATE TABLE Users (
    UserID NUMBER PRIMARY KEY,
    Username VARCHAR2(50) UNIQUE NOT NULL,
    Password VARCHAR2(100) NOT NULL,
    Role VARCHAR2(20) CHECK (Role IN ('admin', 'staff')) NOT NULL
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    ProductID NUMBER REFERENCES Products(ProductID),
    QuantityChanged NUMBER,
    TransactionType VARCHAR2(10) CHECK (TransactionType IN ('IN', 'OUT')),
    TransactionDate DATE DEFAULT SYSDATE,
    DoneBy NUMBER REFERENCES Users(UserID)
);

