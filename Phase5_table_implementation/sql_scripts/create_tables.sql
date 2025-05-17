-- Categories Table
CREATE TABLE Categories (
    CategoryID NUMBER PRIMARY KEY,
    CategoryName VARCHAR2(100) NOT NULL
);

-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID NUMBER PRIMARY KEY,
    SupplierName VARCHAR2(100) NOT NULL,
    ContactInfo VARCHAR2(255)
);

-- Users Table
CREATE TABLE Users (
    UserID NUMBER PRIMARY KEY,
    Username VARCHAR2(50) UNIQUE NOT NULL,
    Password RAW(2000) NOT NULL,
    Role VARCHAR2(20) CHECK (Role IN ('admin', 'staff')) NOT NULL
);

-- Products Table
CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100) NOT NULL,
    CategoryID NUMBER REFERENCES Categories(CategoryID),
    SupplierID NUMBER REFERENCES Suppliers(SupplierID),
    QuantityInStock NUMBER DEFAULT 0,
    ReorderLevel NUMBER DEFAULT 5
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    ProductID NUMBER REFERENCES Products(ProductID),
    Quantity NUMBER NOT NULL,
    TransactionType VARCHAR2(10) CHECK (TransactionType IN ('IN', 'OUT')),
    TransactionDate DATE DEFAULT SYSDATE,
    UserID NUMBER REFERENCES Users(UserID)
);

