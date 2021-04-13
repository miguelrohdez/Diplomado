DESC EMPLOYEES

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE
FROM EMPLOYEES
ORDER BY 1;


SELECT COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL

DESC JOB_ID

DESC JOBS

SELECT *
FROM JOBS
WHERE JOB_ID LIKE ‘%PRES’;

L

C/%PRES/AD%

L

/

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID=101;

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID=(101,103,104,106,109);

L1

C/SELECT/SELECT EMPLOYEE_ID,

L

/

SELECT * FROM REGIONS;

--Da formato a la columna *
COLUMN LAST_NAME FORMAT A15

--Da formato a la columna *
COLUMN FIRST_NAME FORMAT A15

--Igual que un | more en linux
SET PAUSE ON

--Dar formado de moneda con 2 decimales
COLUMN SALARY FORMAT $999,999.99

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, MANAGER_ID
FROM EMPLOYEES
ORDER BY SALARY DESC, LAST_NAME, HIRE_DATE DESC, MANAGER_ID;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, MANAGER_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (111, 178, 124, 186, 202, 194)
ORDER BY SALARY DESC, LAST_NAME, HIRE_DATE DESC, MANAGER_ID;

----
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, MANAGER_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (111, 178, 124, 186, 202, 194)
ORDER BY SALARY DESC, LAST_NAME, HIRE_DATE DESC, MANAGER_ID;

L3

DEL

L2

i

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE, MANAGER_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (
		SELECT EMPLOYEE_ID
		FROM EMPLOYEES
		WHERE SALARY BETWEEN 2000 AND 3000)
ORDER BY SALARY DESC, LAST_NAME, HIRE_DATE DESC, MANAGER_ID;