DECLARE
    v_cursor SYS_REFCURSOR;
    v_name   VARCHAR2(100);
    v_qty    NUMBER;
BEGIN
    -- Get cursor from function (package or standalone)
    v_cursor := GetLowStockProducts;

    -- Loop through result set
    LOOP
        FETCH v_cursor INTO v_name, v_qty;
        EXIT WHEN v_cursor%NOTFOUND;

        -- Print product name and quantity with arrow replaced by '->'
        DBMS_OUTPUT.PUT_LINE('Product: ' || v_name || ' -> Stock: ' || v_qty);
    END LOOP;

    CLOSE v_cursor;
END;
/
