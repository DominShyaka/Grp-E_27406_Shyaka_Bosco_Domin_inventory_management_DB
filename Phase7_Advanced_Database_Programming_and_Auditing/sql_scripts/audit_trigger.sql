CREATE OR REPLACE TRIGGER trg_audit_on_products
AFTER INSERT OR UPDATE OR DELETE ON Products
FOR EACH ROW
DECLARE
    v_status VARCHAR2(20) := 'Allowed';
BEGIN
    INSERT INTO User_Audit (Username, Operation, TableName, Status)
    VALUES (USER, CASE
        WHEN INSERTING THEN 'INSERT'
        WHEN UPDATING THEN 'UPDATE'
        WHEN DELETING THEN 'DELETE'
    END, 'Products', v_status);
END;
/
