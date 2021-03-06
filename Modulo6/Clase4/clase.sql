col STATUS format a9
col hrs format 999.99
Select SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi') end_time,
elapsed_seconds/3600 hrs
from 
desc V$RMAN_BACKUP_JOB_DETAILS order by session_key;

SELECT log_mode FROM v$database;


SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;
--Forzar el logueo de operaciones
ALTER DATABASE FORCE LOGGING;
--Reiniciar el modo de proteccion Maximum Availability
ALTER SYSTEM SET LOG_ARCHIVE_CONFIG='DG_CONFIG=(HR,HRDG)';

ALTER SYSTEM SET LOG_ARCHIVE_DEST_2 = 'SERVICE=HR SYNC AFFIRM VALID_FOR=(ONLINE_LOGFILES, PRIMARY_ROLE) DB_UNIQUE_NAME=HR' SCOPE=BOTH;

ALTER SYSTEM SET LOG_ARCHIVE_DEST_2 = 'SERVICE=HR AFFIRM SYNC VALID_FOR=(ONLINE_LOGFILES, PRIMARY_ROLE) DB_UNIQUE_NAME=HR' SCOPE=BOTH;

ALTER DATABASE SET STANDBY DATABASE TO MAXIMIZE AVAILABILITY;

ALTER SYSTEM SET LOG_ARCHIVE_MAX_PROCESSES = 30 SCOPE=BOTH;

ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT=AUTO;


STARTUP MOUNT;

conn SYSTEM/oracle123

CREATE PROFILE godinez LIMIT
PASSWORD_REUSE_MAX 2
PASSWORD_REUSE_TIME 3;

CREATE PROFILE aplicados LIMIT
SESSIONS_PER_USER UNLIMITED
CPU_PER_SESSION UNLIMITED
CPU_PER_CALL 3000
CONNECT_TIME 45
LOGICAL_READS_PER_SESSION DEFAULT
LOGICAL_READS_PER_CALL 1000
PRIVATE_SGA 15K
COMPOSITE_LIMIT 5000000;

CREATE PROFILE vaqueros LIMIT
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LIFE_TIME 60
PASSWORD_REUSE_TIME 60
PASSWORD_REUSE_MAX 5
--PASSWORD_VERIFY_FUNTION verify_funtion
PASSWORD_LOCK_TIME 1/24
PASSWORD_GRACE_TIME 10;

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT';

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE = 'RESOURCE';

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DBA';

CREATE USER sonya
IDENTIFIED BY Street_fgt1
DEFAULT TABLESPACE usuaurios
QUOTA 100K ON usuaurios
TEMPORARY TABLESPACE temp
QUOTA 50K ON system
PASSWORD EXPIRE;

GRANT CREATE ANY INDEX TO sonya;
GRANT CREATE ANY TABLE TO sonya WITH ADMIN OPTION;

SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('SONYA');

CREATE USER chunli
IDENTIFIED BY Street_fgt2
DEFAULT TABLESPACE usuaurios
QUOTA 100K ON usuaurios
TEMPORARY TABLESPACE temp
QUOTA 50K ON system
PASSWORD EXPIRE;

CONNECT sonya/Street_fgt1 --STREET
GRANT CREATE ANY TABLE TO chunli; --YES
GRANT CREATE ANY INDEX TO chunli; --NO

SELECT NAME
FROM SYSTEM_PRIVILEGE_MAP;