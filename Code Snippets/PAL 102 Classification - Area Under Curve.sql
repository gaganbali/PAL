-- cleanup
DROP TYPE "T_DATA";
DROP TYPE "T_PARAMS";
DROP TYPE "T_AUC";
DROP TYPE "T_ROC";
DROP TABLE "SIGNATURE";
CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_DROP"('DEVUSER', 'P_AUC');
DROP TABLE "DATA";
DROP TABLE "AUC";
DROP TABLE "ROC";

-- procedure setup
CREATE TYPE "T_DATA" AS TABLE ("ID" INTEGER, "ORIGINAL" INTEGER, "PROBABILITY" DOUBLE);
CREATE TYPE "T_PARAMS" AS TABLE ("NAME" VARCHAR(60), "INTARGS" INTEGER, "DOUBLEARGS" DOUBLE, "STRINGARGS" VARCHAR (100));
CREATE TYPE "T_AUC" AS TABLE ("NAME" VARCHAR(100), "VALUE" DOUBLE);
CREATE TYPE "T_ROC" AS TABLE ("ID" INTEGER, "FPR" DOUBLE, "TPR" DOUBLE);

CREATE COLUMN TABLE "SIGNATURE" ("POSITION" INTEGER, "SCHEMA_NAME" NVARCHAR(256), "TYPE_NAME" NVARCHAR(256), "PARAMETER_TYPE" VARCHAR(7));
INSERT INTO "SIGNATURE" VALUES (1, 'DEVUSER', 'T_DATA', 'IN');
INSERT INTO "SIGNATURE" VALUES (2, 'DEVUSER', 'T_PARAMS', 'IN');
INSERT INTO "SIGNATURE" VALUES (3, 'DEVUSER', 'T_AUC', 'OUT');
INSERT INTO "SIGNATURE" VALUES (4, 'DEVUSER', 'T_ROC', 'OUT');
CALL "SYS"."AFLLANG_WRAPPER_PROCEDURE_CREATE"('AFLPAL', 'AUC', 'DEVUSER', 'P_AUC', "SIGNATURE");

-- data setup
CREATE COLUMN TABLE "DATA" LIKE "T_DATA";
INSERT INTO "DATA" VALUES (1, 0, 0.2);
INSERT INTO "DATA" VALUES (2, 0, 0.5);
INSERT INTO "DATA" VALUES (3, 0, 0.9);
INSERT INTO "DATA" VALUES (4, 0, 0.2);
INSERT INTO "DATA" VALUES (5, 0, 0.4);
INSERT INTO "DATA" VALUES (6, 1, 0.5);
INSERT INTO "DATA" VALUES (7, 1, 0.95);
INSERT INTO "DATA" VALUES (8, 1, 0.6);
INSERT INTO "DATA" VALUES (9, 1, 0.7);
INSERT INTO "DATA" VALUES (10, 1, 0.76);
INSERT INTO "DATA" VALUES (11, 1, 0.9);

CREATE COLUMN TABLE "AUC" LIKE "T_AUC";
CREATE COLUMN TABLE "ROC" LIKE "T_ROC";

-- runtime
DROP TABLE "#PARAMS";
CREATE LOCAL TEMPORARY COLUMN TABLE "#PARAMS" LIKE "T_PARAMS";
INSERT INTO "#PARAMS" VALUES ('THREAD_NUMBER', 2, null, null);

TRUNCATE TABLE "AUC";
TRUNCATE TABLE "ROC";

CALL "P_AUC" ("DATA", "#PARAMS", "AUC", "ROC") WITH OVERVIEW;

SELECT * FROM "DATA";
SELECT * FROM "AUC";
SELECT * FROM "ROC";
