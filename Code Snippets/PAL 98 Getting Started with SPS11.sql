-- CHECK AFL PAL FUNCTIONS ARE INSTALLED
SELECT * FROM SYS.AFL_FUNCTIONS WHERE PACKAGE_NAME='PAL';

-- START SCRIPT SERVER
ALTER SYSTEM ALTER CONFIGURATION ('daemon.ini', 'SYSTEM') SET ('scriptserver', 'instances') = '1' WITH RECONFIGURE;

-- CREATE USER FOR AFL DEVELOPMENT
CREATE USER DEVUSER PASSWORD Password1;

-- AUTHORIZE CREATION & REMOVAL OF PAL PROCEDURES
GRANT AFLPM_CREATOR_ERASER_EXECUTE TO DEVUSER;

-- AUTHORIZE EXECUTION OF PAL PROCEDURES
GRANT AFL__SYS_AFL_AFLPAL_EXECUTE TO DEVUSER;

-- AUTHORIZE READ ACCESS TO INPUT DATA
GRANT SELECT ON SCHEMA PAL TO DEVUSER;
