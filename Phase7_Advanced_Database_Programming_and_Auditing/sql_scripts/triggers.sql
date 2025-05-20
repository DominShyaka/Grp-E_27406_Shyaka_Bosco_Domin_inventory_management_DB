CREATE OR REPLACE TRIGGER trg_block_on_holiday
BEFORE INSERT OR UPDATE OR DELETE ON Products
FOR EACH ROW
DECLARE
    v_today DATE := TRUNC(SYSDATE);
    v_day   VARCHAR2(10);
    v_count NUMBER;
BEGIN
    v_day := TO_CHAR(v_today, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');
    
    -- Check for weekday (Mon–Fri)
    IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Action blocked: No DML allowed on weekdays.');
    END IF;

    -- Check for public holiday
    SELECT COUNT(*) INTO v_count
    FROM HolidayDates
    WHERE HolidayDate = v_today;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Action blocked: Today is a holiday.');
    END IF;
END;
/
