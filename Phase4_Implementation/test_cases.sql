-- Test Case 1: Add a Product
BEGIN
    AddProduct('Laptop', 1, 1, 20);
END;
/

-- Test Case 2: Update Product Details
BEGIN
    UpdateProduct(1, 'Gaming Laptop', 1, 1, 25);
END;
/

-- Test Case 3: Record Stock IN Transaction
BEGIN
    RecordTransaction(1, 5, 'IN', 1);
END;
/

-- Test Case 4: Record Stock OUT Transaction
BEGIN
    RecordTransaction(1, 3, 'OUT', 1);
END;
/

-- Test Case 5: Delete a Product
BEGIN
    DeleteProduct(1);
END;
/

-- Test Case 6: Generate Low Stock Report (Products below 10)
BEGIN
    GenerateLowStockReport(10);
END;
/

-- Test Case 7: Check login success (TRUE)
BEGIN
    IF VerifyLogin('admin', 'admin123') THEN
        DBMS_OUTPUT.PUT_LINE('Login successful');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Login failed');
    END IF;
END;
/

-- Test Case 8: Check login failure (FALSE)
BEGIN
    IF VerifyLogin('admin', 'wrongpassword') THEN
        DBMS_OUTPUT.PUT_LINE('Login successful');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Login failed');
    END IF;
END;
/
