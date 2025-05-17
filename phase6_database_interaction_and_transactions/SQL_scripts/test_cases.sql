BEGIN
    AddProduct('Desk Chair', 2, 2, 15);
    RecordTransaction(1, 5, 'OUT', 1);
    IF VerifyLogin('admin', 'admin123') THEN
        DBMS_OUTPUT.PUT_LINE('Login Success');
    END IF;
END;
/
