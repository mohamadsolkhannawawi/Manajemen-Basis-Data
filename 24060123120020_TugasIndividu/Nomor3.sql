-- 3. View: ProjectEmployeeSummary
DROP VIEW IF EXISTS ProjectEmployeeSummary;
CREATE VIEW ProjectEmployeeSummary AS
SELECT 
    P.Pnumber AS Project_ID,
    P.Pname AS Project_Name,
    E.Ssn AS Employee_ID,
    CONCAT(E.Fname, ' ', E.Lname) AS Employee_Name,
    D.Dname AS Department_Name
FROM PROJECT P
JOIN WORKS_ON W ON P.Pnumber = W.Pno
JOIN EMPLOYEE E ON W.Essn = E.Ssn
JOIN DEPARTMENT D ON E.Dno = D.Dnumber;

-- Pemanggilan View
SELECT * FROM ProjectEmployeeSummary;
