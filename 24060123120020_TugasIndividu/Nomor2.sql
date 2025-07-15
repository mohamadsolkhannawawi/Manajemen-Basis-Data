-- 2. Trigger: PreventDeptDeletion
DROP TRIGGER IF EXISTS PreventDeptDeletion;
DELIMITER $$
CREATE TRIGGER PreventDeptDeletion
BEFORE DELETE ON DEPARTMENT
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM EMPLOYEE WHERE Dno = OLD.Dnumber) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Penghapusan gagal: Masih ada karyawan di departemen ini';
    END IF;
END $$
DELIMITER ;

-- Pemanggilan Trigger (Contoh penghapusan departemen)
DELETE FROM DEPARTMENT WHERE Dnumber = 4;