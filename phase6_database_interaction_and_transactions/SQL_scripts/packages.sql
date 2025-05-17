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
