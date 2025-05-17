-- Function to Hash Passwords Using SHA-256
CREATE OR REPLACE FUNCTION HashPassword(p_password IN VARCHAR2)
RETURN RAW
AS
    v_hash RAW(2000);
BEGIN
    v_hash := DBMS_CRYPTO.HASH(
        UTL_I18N.STRING_TO_RAW(p_password, 'AL32UTF8'),
        DBMS_CRYPTO.HASH_SH256
    );
    RETURN v_hash;
END;
/

-- Function to Verify Login Credentials
CREATE OR REPLACE FUNCTION VerifyLogin(p_username VARCHAR2, p_password VARCHAR2)
RETURN BOOLEAN
AS
    v_stored RAW(2000);
BEGIN
    SELECT Password INTO v_stored
    FROM Users
    WHERE Username = p_username;

    RETURN v_stored = HashPassword(p_password);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

-- Sample INSERT with hashed password
INSERT INTO Users (UserID, Username, Password, Role)
VALUES (Users_seq.NEXTVAL, 'admin', HashPassword('admin123'), 'admin');

-- Grant Execute Permission to Roles (optional setup)
-- GRANT EXECUTE ON AddProduct TO inventory_admin;
-- GRANT EXECUTE ON RecordTransaction TO inventory_staff;
