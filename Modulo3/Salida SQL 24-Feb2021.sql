SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO, SALARY SALARIO   
FROM EMPLOYEES
ORDER BY 2 DESC

SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO,   
	CASE SALARY 
	WHEN 3100 THEN 'Bajo'   
	WHEN 10000 THEN 'Alto'   
	ELSE 'Medio Medio' END   
	EMPLOYEES;

SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO,   
	CASE SALARY WHEN 3100 THEN 'Bajo'
	WHEN 10000 THEN 'Alto'
	ELSE 'Medio Medio' END   
	FROM EMPLOYEES;

SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO, 
	   SALARY SALARIO   
FROM EMPLOYEES;

SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO,
       SALARY SUELDOS,   
	   CASE SALARY 
	   WHEN 2100 THEN 'Bajo'   
	   WHEN 24000 THEN 'Alto'   
	   ELSE 'Medio' END
FROM EMPLOYEES;

SELECT FIRST_NAME||' '||LAST_NAME EMPLEADO,
       SALARY SUELDOS,
	   CASE SALARY 
	   WHEN 2100 THEN 'Bajo'
	   WHEN 24000 THEN 'Alto'
	   ELSE 'Medio' END
FROM EMPLOYEES;

SELECT AVG(CASE WHEN e.salary > 2000 
		   THEN e.salary
		   ELSE 2000 END) "Salario Promedio"
FROM employees e;

SELECT AVG(CASE WHEN e.salary > 2000 
		   THEN e.salary
		   ELSE 2000 END) "Salario Promedio"
FROM employees e;

SELECT AVG(SALARY) PROMEDIO FROM EMPLOYEES;

SELECT AVG(SALARY) PROMEDIO FROM EMPLOYEES   WHERE SALARY > 5000;

SELECT COUNT(SALARY) FROM EMPLOYEES   WHERE SALARY > 5000;

SELECT COUNT(SALARY) FROM EMPLOYEES   WHERE SALARY <= 5000;

SELECT COUNT(SALARY) FROM EMPLOYEES   WHERE SALARY > 5000;

SELECT COUNT(SALARY) FROM EMPLOYEES   WHERE SALARY > 5000;

SELECT COUNT(SALARY) FROM EMPLOYEES   WHERE SALARY <= 5000;

SELECT AVG(SUM(SALARY)+(49*2000))   FROM EMPLOYEES   WHERE SALARY > 5000;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = 30;

SELECT FIRST_NAME||' '||LAST_NAME TRABAJADOR,
	   SALARY SALARIO,
       NVL(COMMISSION_PCT, 0)*(SALARY*12) COMISION
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30
ORDER BY 3 DESC;

SELECT FIRST_NAME||' '||LAST_NAME TRABAJADOR,
	   SALARY SALARIO,
       NVL(COMMISSION_PCT, 0)*(SALARY*12) COMISION
FROM EMPLOYEES
ORDER BY 3 DESC;

COLUMN SALARIO FORMAT $999,999.99

COLUMN COMISION FORMAT $999,999.99

COLUMN TRABAJADOR FORMAT A18

SELECT SUM(SALARY) FROM EMPLOYEES;

SELECT SUM(NVL(COMMISSION_PCT, 0)*(SALARY*12))
FROM EMPLOYEES;

SELECT FIRST_NAME, SUM(SALARY)
FROM EMPLOYEES;

SELECT DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY 1;

SELECT DEPARTMENT_ID,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT JOB_ID,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY 1;

SELECT MANAGER_ID,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS
FROM EMPLOYEES
GROUP BY MANAGER_ID
ORDER BY 1;

SELECT SALARY,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS,
       COUNT(EMPLOYEE_ID) TRABAJADORES
FROM EMPLOYEES
GROUP BY SALARY
ORDER BY 1;

SELECT MANAGER_ID,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS,
      COUNT(EMPLOYEE_ID) TRABAJADORES
FROM EMPLOYEES
GROUP BY MANAGER_ID
ORDER BY 1;

SELECT MANAGER_ID,
       SUM(SALARY) TOTAL_SALARIOS,
       AVG(SALARY) PROMEDIO_SALARIOS,
       COUNT(EMPLOYEE_ID) TRABAJADORES
FROM EMPLOYEES
GROUP BY MANAGER_ID
ORDER BY 4 DESC;

SELECT DEPARTMENT_ID, JOB_ID, COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY 1, 2;

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) > 90,000
ORDER BY 1;

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) > 40,000
ORDER BY 1;

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM  EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 5,000
ORDER BY 1;

SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE JOB_ID != 'IT_PROG'
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) > 30000
ORDER BY SUM(SALARY);
