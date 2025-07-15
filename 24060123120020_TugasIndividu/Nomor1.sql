USE company_database;

-- 1. Stored Procedure: GetEmployeeDetails
DROP PROCEDURE IF EXISTS GetEmployeeDetails;
DELIMITER $$
CREATE PROCEDURE GetEmployeeDetails(
    IN emp_id CHAR(9),
    OUT name_out VARCHAR(30),
    OUT dept_out VARCHAR(15)
)
BEGIN
    -- Cek apakah karyawan ada
    IF EXISTS (SELECT 1 FROM EMPLOYEE WHERE Ssn = emp_id) THEN
        -- Ambil nama karyawan
        SELECT CONCAT(Fname, ' ', Lname) INTO name_out
        FROM EMPLOYEE
        WHERE Ssn = emp_id;
        
        -- Ambil nama departemen
        SELECT Dname INTO dept_out
        FROM DEPARTMENT
        WHERE Dnumber = (SELECT Dno FROM EMPLOYEE WHERE Ssn = emp_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Karyawan tidak ditemukan';
    END IF;
END $$
DELIMITER ;

-- Pemanggilan Stored Procedure
SET @emp_id = '123456789';
SET @name_out = '';
SET @dept_out = '';

CALL GetEmployeeDetails(@emp_id, @name_out, @dept_out);

-- Menampilkan hasil
SELECT @name_out AS 'Nama Karyawan', @dept_out AS 'Nama Departemen';