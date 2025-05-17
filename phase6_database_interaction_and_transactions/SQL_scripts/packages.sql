CREATE OR REPLACE PACKAGE InventoryPkg AS
    PROCEDURE AddProduct(
        p_name VARCHAR2,
        p_cat  NUMBER,
        p_sup  NUMBER,
        p_qty  NUMBER
    );

    PROCEDURE RecordTransaction(
        p_pid   NUMBER,
        p_qty   NUMBER,
        p_type  VARCHAR2,
        p_uid   NUMBER
    );

    FUNCTION VerifyLogin(p_username VARCHAR2, p_password VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION GetLowStockProducts RETURN SYS_REFCURSOR;
END InventoryPkg;
/
CREATE OR REPLACE PACKAGE BODY InventoryPkg AS

    PROCEDURE AddProduct(
        p_name VARCHAR2,
        p_cat  NUMBER,
        p_sup  NUMBER,
        p_qty  NUMBER
    ) IS
    BEGIN
        INSERT INTO Products (ProductID, ProductName, CategoryID, SupplierID, QuantityInStock)
        VALUES (Products_seq.NEXTVAL, p_name, p_cat, p_sup, p_qty);
    END AddProduct;

    PROCEDURE RecordTransaction(
        p_pid   NUMBER,
        p_qty   NUMBER,
        p_type  VARCHAR2,
        p_uid   NUMBER
    ) IS
    BEGIN
        INSERT INTO Transactions (TransactionID, ProductID, Quantity, TransactionType, TransactionDate, UserID)
        VALUES (Transactions_seq.NEXTVAL, p_pid, p_qty, p_type, SYSDATE, p_uid);

        IF p_type = 'IN' THEN
            UPDATE Products SET QuantityInStock = QuantityInStock + p_qty WHERE ProductID = p_pid;
        ELSIF p_type = 'OUT' THEN
            UPDATE Products SET QuantityInStock = QuantityInStock - p_qty WHERE ProductID = p_pid;
        END IF;
    END RecordTransaction;

    FUNCTION VerifyLogin(p_username VARCHAR2, p_password VARCHAR2)
        RETURN BOOLEAN IS
        v_stored RAW(2000);
    BEGIN
        SELECT Password INTO v_stored FROM Users WHERE Username = p_username;
        RETURN v_stored = UTL_I18N.STRING_TO_RAW(p_password, 'AL32UTF8');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RETURN FALSE;
    END VerifyLogin;

    FUNCTION GetLowStockProducts RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT ProductName, QuantityInStock FROM Products WHERE QuantityInStock <= ReorderLevel;
        RETURN v_cursor;
    END GetLowStockProducts;

END InventoryPkg;
/

