-- Procedure to Add a Product
CREATE OR REPLACE PROCEDURE AddProduct (
    p_ProductName IN VARCHAR2,
    p_CategoryID IN NUMBER,
    p_SupplierID IN NUMBER,
    p_Quantity IN NUMBER
)
AS
BEGIN
    INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, QuantityInStock)
    VALUES (Products_seq.NEXTVAL, p_ProductName, p_CategoryID, p_SupplierID, p_Quantity);
    COMMIT;
END;
/

-- Procedure to Update a Product

CREATE OR REPLACE PROCEDURE UpdateProduct (
    p_ProductID IN NUMBER,
    p_ProductName IN VARCHAR2,
    p_CategoryID IN NUMBER,
    p_SupplierID IN NUMBER,
    p_Quantity IN NUMBER
)
AS
BEGIN
    UPDATE Products
    SET ProductName = p_ProductName,
        CategoryID = p_CategoryID,
        SupplierID = p_SupplierID,
        QuantityInStock = p_Quantity
    WHERE ProductID = p_ProductID;
    COMMIT;
END;
/

-- Procedure to Delete a Product

CREATE OR REPLACE PROCEDURE DeleteProduct (
    p_ProductID IN NUMBER
)
AS
BEGIN
    DELETE FROM Products WHERE ProductID = p_ProductID;
    COMMIT;
END;
/

-- Procedure to Record an Inventory Transaction

CREATE OR REPLACE PROCEDURE RecordTransaction (
    p_ProductID IN NUMBER,
    p_Quantity IN NUMBER,
    p_TransactionType IN VARCHAR2,
    p_UserID IN NUMBER
)
AS
BEGIN
    INSERT INTO Transactions (TransactionID, ProductID, Quantity, TransactionType, TransactionDate, UserID)
    VALUES (Transactions_seq.NEXTVAL, p_ProductID, p_Quantity, p_TransactionType, SYSDATE, p_UserID);

    IF p_TransactionType = 'IN' THEN
        UPDATE Products
        SET QuantityInStock = QuantityInStock + p_Quantity
        WHERE ProductID = p_ProductID;
    ELSIF p_TransactionType = 'OUT' THEN
        UPDATE Products
        SET QuantityInStock = QuantityInStock - p_Quantity
        WHERE ProductID = p_ProductID;
    END IF;

    COMMIT;
END;
/

-- Procedure to Generate Low Stock Report

CREATE OR REPLACE PROCEDURE GenerateLowStockReport (
    p_ReorderLevel IN NUMBER
)
AS
BEGIN
    FOR rec IN (
        SELECT ProductID, ProductName, QuantityInStock
        FROM Products
        WHERE QuantityInStock < p_ReorderLevel
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || rec.ProductID || ' | Name: ' || rec.ProductName || ' | Stock: ' || rec.QuantityInStock);
    END LOOP;
END;
/
