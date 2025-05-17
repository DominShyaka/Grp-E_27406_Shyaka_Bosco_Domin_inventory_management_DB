CREATE OR REPLACE FUNCTION VerifyLogin(p_username VARCHAR2, p_password VARCHAR2)
RETURN BOOLEAN
AS
    v_stored RAW(2000);
BEGIN
    SELECT Password INTO v_stored FROM Users WHERE Username = p_username;
    RETURN v_stored = UTL_I18N.STRING_TO_RAW(p_password, 'AL32UTF8');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/
CREATE OR REPLACE FUNCTION GetLowStockProducts
RETURN SYS_REFCURSOR
AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT ProductName, QuantityInStock, ReorderLevel
    FROM Products
    WHERE QuantityInStock <= ReorderLevel;
    RETURN v_cursor;
END;
/
