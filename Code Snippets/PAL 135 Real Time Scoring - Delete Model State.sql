-- cleanup
DROP TYPE "T_MESSAGE";
DROP TABLE "SIGNATURE";
CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_DROP"('DEVUSER', 'P_DMS');
DROP TABLE "MESSAGE";

-- procedure setup
CREATE TYPE "T_MESSAGE" AS TABLE ("ID" VARCHAR(50), "TIMESTAMP" VARCHAR(100), "ERROR_CODE" INTEGER, "MESSAGE" VARCHAR(200));
CREATE COLUMN TABLE "SIGNATURE" ("POSITION" INTEGER, "SCHEMA_NAME" NVARCHAR(256), "TYPE_NAME" NVARCHAR(256), "PARAMETER_TYPE" VARCHAR(7));
INSERT INTO "SIGNATURE" VALUES (1, 'DEVUSER', 'T_STATE', 'IN');
INSERT INTO "SIGNATURE" VALUES (2, 'DEVUSER', 'T_PARAMS', 'IN');
INSERT INTO "SIGNATURE" VALUES (3, 'DEVUSER', 'T_MESSAGE', 'OUT');
CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_CREATE"('AFLPAL', 'DELETE_PAL_MODEL_STATE', 'DEVUSER', 'P_DMS', "SIGNATURE");

-- table setup
CREATE COLUMN TABLE "MESSAGE" LIKE "T_MESSAGE";

-- runtime
DROP TABLE "#PARAMS";
CREATE LOCAL TEMPORARY COLUMN TABLE "#PARAMS" LIKE "T_PARAMS";
-- NO PARAMETERS

TRUNCATE TABLE "MESSAGE";

CALL "P_DMS" ("STATE", "#PARAMS", "MESSAGE") WITH OVERVIEW;

SELECT * FROM "MESSAGE";

SELECT * FROM "SYS"."M_AFL_STATES";
SELECT * FROM "SYS"."M_AFL_FUNCTIONS";
