BEGIN
ROLLBACK;
  FOR i IN 20..1000000 LOOP
  IF EXISTS SELECT SALARY FROM

  INSERT INTO PRUEBAS_LOCAS
  VALUES (i,'JUGADOR '||i, SYSDATE-i);
  END LOOP;
END;

INSERT INTO nominaNueva
SELECT EMPLOYEE_ID,  
     SALARY,
     SALARY/2 SAL_BRUTO,
     SALARY*0.052 IMSS,
     SALARY*0.04 INFONAVIT,
     SALARY*0.28 ISR,
     (SALARY-((SALARY*0.052)+(SALARY*0.04)+(SALARY*0.28)))/2 SAL_NETO
FROM EMPLOYEES
)

INSERT INTO nominaNueva
SELECT EMPLOYEE_ID,  
     SALARY,
     SALARY/2 SAL_BRUTO,
     SALARY*0.052 IMSS,
     SALARY*0.04 INFONAVIT,
     SALARY*0.28 ISR,
     (SALARY-((SALARY*0.052)+(SALARY*0.04)+(SALARY*0.28)))/2 SAL_NETO
FROM EMPLOYEES



CREATE TABLE Nomina AS (
SELECT EMPLOYEE_ID, 
     SALARY,
     SALARY/2 SAL_BRUTO,
     SALARY*0.052 IMSS,
     SALARY*0.04 INFONAVIT,
     SALARY*0.28 ISR,
     (SALARY-((SALARY*0.052)+(SALARY*0.04)+(SALARY*0.28)))/2 SAL_NETO
  FROM EMPLOYEES
);

CREATE TRIGGER nomina_sec
BEFORE INSERT ON nominanueva
FOR EACH ROW
BEGIN
  SELECT sec_nomina.nextval
  INTO :new.nomina_id
  FROM dual;
END;