-- 1. Ensure you are in the Pluggable Database
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Create the schema/user
CREATE USER FUSION IDENTIFIED BY FUSION;

-- 3. Grant unlimited space to create objects
-- ALTER USER fusion QUOTA UNLIMITED ON USERS;

-- 4. Grant core development and object creation system privileges
GRANT CREATE SESSION, 
      CREATE TABLE, 
      CREATE VIEW,
	  CREATE SEQUENCE,
      CREATE MATERIALIZED VIEW, 
      CREATE ANALYTIC VIEW,
      CREATE ATTRIBUTE DIMENSION TO FUSION;

-- 5. Grant absolute administrative control (All Grants/DBA Role)
GRANT DBA TO FUSION;


ALTER SESSION SET CURRENT_SCHEMA = FUSION;


-- DROP TABLE statements generated from the supplied HR and PAYROLL CREATE TABLE SQL files.
-- Schema: FUSION
-- 45 unique tables: 35 Payroll-related + 10 HR-related.
-- Drop PAYROLL-related tables first, then HR tables.
-- CASCADE CONSTRAINTS removes dependent referential constraints; PURGE skips the recycle bin.
-- Run as FUSION or a user with sufficient DROP ANY TABLE privileges.

-- 1. PAYROLL tables
DROP TABLE FUSION.PAY_INPUT_VALUES_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_INPUT_VALUES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELEMENT_TYPES_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELEMENT_TYPES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELEMENT_LINKS_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELEMENT_ENTRY_VALUES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELEMENT_ENTRIES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELE_CLASSIFICATIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ELE_CLASSIFICATIONS_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ASSIGNED_PAYROLLS_DN CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_RUN_BALANCES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_PAYROLL_REL_ACTIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_PAYROLL_ACTIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_DIMENSION_USAGES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BALANCE_TYPES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BALANCE_TYPES_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BALANCE_FEEDS_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BALANCE_DIMENSIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_CLASSIFICATIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_TIME_PERIODS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_REL_GROUPS_DN CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_PAY_RELATIONSHIPS_DN CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_FLOW_INSTANCES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_EXCEPTIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_DEFINED_BALANCES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_CONSOLIDATION_SETS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_EXCEPTIONS_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_EXCEPTIONS_B CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_EXCEPTION_REPORTS_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_EXCEPTION_REPORTS_B CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_BAL_EXCEP_REPORT_ENTRIES CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ANA_PAYROLL_ACTIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PAY_ALL_PAYROLLS_F CASCADE CONSTRAINTS PURGE;

-- 2. HR tables
DROP TABLE FUSION.PER_ALL_PEOPLE_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_ALL_ASSIGNMENTS_M CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_PERSONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_PERSON_NAMES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_LOCATIONS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_LEGISLATIVE_DATA_GROUPS CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_LEGISLATIVE_DATA_GROUPS_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_JOBS_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_JOBS_F_TL CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.HR_ALL_ORGANIZATION_UNITS_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.PER_GRADES_F CASCADE CONSTRAINTS PURGE;
DROP TABLE FUSION.HR_ALL_POSITIONS_F CASCADE CONSTRAINTS PURGE;

-- End of DROP TABLE script.



-- Source PDF: HR_ALL_POSITIONS_F.pdf
-- Schema: FUSION | Object owner: PER
CREATE TABLE FUSION.HR_ALL_POSITIONS_F
(
    POSITION_ID                      NUMBER(18) NOT NULL,
    CATEGORY_CODE                    VARCHAR2(80) NULL,
    EFFECTIVE_START_DATE             DATE NOT NULL,
    EFFECTIVE_END_DATE               DATE NOT NULL,
    BUSINESS_UNIT_ID                 NUMBER(18) NULL,
    POSITION_CODE                    VARCHAR2(30) NULL,
    BUSINESS_GROUP_ID                NUMBER(18) NULL,
    ORGANIZATION_ID                  NUMBER(18) NULL,
    UNION_ID                         NUMBER(18) NULL,
    COLLECTIVE_AGREEMENT_ID          NUMBER(18) NULL,
    JOB_ID                           NUMBER(18) NULL,
    LOCATION_ID                      NUMBER(18) NULL,
    SUPERVISOR_ID                    NUMBER(18) NULL,
    SUPERVISOR_ASSIGNMENT_ID         NUMBER(18) NULL,
    GRADE_LADDER_ID                  NUMBER(18) NULL,
    ACTION_OCCURRENCE_ID             NUMBER(18) NULL,
    ACTIVE_STATUS                    VARCHAR2(30) NULL,
    HIRING_STATUS                    VARCHAR2(30) NULL,
    POSITION_TYPE                    VARCHAR2(30) NULL,
    PERMANENT_TEMPORARY_FLAG         VARCHAR2(30) NULL,
    FULL_PART_TIME                   VARCHAR2(30) NULL,
    FTE                              NUMBER(30) NULL,
    CALCULATE_FTE                    VARCHAR2(1) NULL,
    MAX_PERSONS                      NUMBER(4) NULL,
    STANDARD_WORKING_HOURS           NUMBER(22) NULL,
    STANDARD_WORKING_FREQUENCY       VARCHAR2(30) NULL,
    WORKING_HOURS                    NUMBER(22) NULL,
    FREQUENCY                        VARCHAR2(30) NULL,
    STD_ANNUAL_WORKING_DURATION      NUMBER(8) NULL,
    ANNUAL_WORKING_DURATION_UNITS    VARCHAR2(10) NULL,
    ANNUAL_WORKING_DURATION          NUMBER(8) NULL,
    TIME_NORMAL_START                VARCHAR2(5) NULL,
    TIME_NORMAL_FINISH               VARCHAR2(5) NULL,
    PROBATION_PERIOD                 NUMBER(22) NULL,
    PROBATION_PERIOD_UNIT_CD         VARCHAR2(30) NULL,
    BARGAINING_UNIT_CD               VARCHAR2(30) NULL,
    POSITION_SYNCHRONIZATION_FLAG    VARCHAR2(30) NULL,
    SECURITY_CLEARANCE               VARCHAR2(30) NULL,
    OVERLAP_ALLOWED                  VARCHAR2(30) NULL,
    SEASONAL_FLAG                    VARCHAR2(30) NULL,
    SEASONAL_START_DATE              DATE NULL,
    SEASONAL_END_DATE                DATE NULL,
    OBJECT_VERSION_NUMBER            NUMBER(9) NULL,
    CREATED_BY                       VARCHAR2(64) NULL,
    CREATION_DATE                    TIMESTAMP NULL,
    LAST_UPDATED_BY                  VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                 TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                VARCHAR2(32) NULL,
    ASSIGNMENT_CATEGORY              VARCHAR2(30) NULL,
    COST_CENTER                      VARCHAR2(30) NULL,
    DELEGATE_POSITION_ID             NUMBER(18) NULL,
    BUDGETED_POSITION_FLAG           VARCHAR2(1) NULL,
    BUDGET_AMOUNT                    NUMBER NULL,
    BUDGET_AMOUNT_CURRENCY           VARCHAR2(20) NULL,
    FUNDED_BY_EXISTING_POSITION      VARCHAR2(1) NULL,
    REQUISITION_TEMPLATE_ID          NUMBER(18) NULL,
    CONSTRAINT HR_ALL_POSITIONS_F_PK PRIMARY KEY (POSITION_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- Source PDF: PER_GRADES_F.pdf
-- Schema: FUSION | Object owner: PER
CREATE TABLE FUSION.PER_GRADES_F
(
    GRADE_ID                         NUMBER(18) NOT NULL,
    EFFECTIVE_START_DATE             DATE NOT NULL,
    EFFECTIVE_END_DATE               DATE NOT NULL,
    SET_ID                           NUMBER(18) NULL,
    BUSINESS_GROUP_ID                NUMBER(18) NULL,
    ACTION_OCCURRENCE_ID             NUMBER(18) NULL,
    PAY_SCALE_ID                     NUMBER(18) NULL,
    STARTING_STEP                    NUMBER(18) NULL,
    CEILING_STEP_ID                  NUMBER(18) NULL,
    GRADE_CODE                       VARCHAR2(30) NULL,
    GRADE_TYPE                       VARCHAR2(30) NULL,
    ACTIVE_STATUS                    VARCHAR2(30) NULL,
    CATEGORY_CODE                    VARCHAR2(80) NULL,
    OBJECT_VERSION_NUMBER            NUMBER(9) NULL,
    CREATED_BY                       VARCHAR2(64) NULL,
    CREATION_DATE                    TIMESTAMP NULL,
    LAST_UPDATED_BY                  VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                 TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                VARCHAR2(32) NULL,
    CONSTRAINT PER_GRADES_F_PK PRIMARY KEY (GRADE_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- Oracle Fusion table DDL generated from the supplied PDF data dictionary files.
-- Schema: FUSION | Object owner metadata: PER
-- All non-primary-key columns are nullable as requested.
-- Excluded flexfield ATTRIBUTE* columns and specified excluded column prefixes.

CREATE TABLE FUSION.HR_ALL_ORGANIZATION_UNITS_F
(
    ORGANIZATION_ID                        NUMBER(18) NOT NULL,
    MODULE_ID                              VARCHAR2(32) NULL,
    EFFECTIVE_START_DATE                   DATE NOT NULL,
    EFFECTIVE_END_DATE                     DATE NOT NULL,
    ACTION_OCCURRENCE_ID                   NUMBER(18) NULL,
    BUSINESS_GROUP_ID                      NUMBER(18) NULL,
    LEGAL_ENTITY_ID                        NUMBER(18) NULL,
    ESTABLISHMENT_ID                       NUMBER(18) NULL,
    INTERNAL_EXTERNAL_FLAG                 VARCHAR2(30) NULL,
    TYPE                                   VARCHAR2(30) NULL,
    INTERNAL_ADDRESS_LINE                  VARCHAR2(80) NULL,
    COST_ALLOCATION_KEYFLEX_ID             NUMBER(18) NULL,
    LOCATION_ID                            NUMBER(18) NULL,
    OBJECT_VERSION_NUMBER                  NUMBER(9) NULL,
    ORGANIZATION_CODE                      VARCHAR2(500) NULL,
    CREATED_BY                             VARCHAR2(64) NULL,
    CREATION_DATE                          TIMESTAMP NULL,
    LAST_UPDATED_BY                        VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                       TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                      VARCHAR2(32) NULL,
    CONSTRAINT HR_ALL_ORGANIZATION_UNITS_PK PRIMARY KEY (ORGANIZATION_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PER_JOBS_F_TL
(
    JOB_ID                                 NUMBER(18) NOT NULL,
    LANGUAGE                               VARCHAR2(4) NOT NULL,
    EFFECTIVE_START_DATE                   DATE NOT NULL,
    EFFECTIVE_END_DATE                     DATE NOT NULL,
    BUSINESS_GROUP_ID                      NUMBER(18) NULL,
    SOURCE_LANG                            VARCHAR2(4) NULL,
    NAME                                   VARCHAR2(240) NULL,
    OBJECT_VERSION_NUMBER                  NUMBER(9) NULL,
    CREATED_BY                             VARCHAR2(64) NULL,
    CREATION_DATE                          TIMESTAMP NULL,
    LAST_UPDATED_BY                        VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                       TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                      VARCHAR2(32) NULL,
    CONSTRAINT PER_JOBS_F_TL_PK PRIMARY KEY (JOB_ID, LANGUAGE, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PER_JOBS_F
(
    JOB_ID                                 NUMBER(18) NOT NULL,
    PROGRESSION_JOB_ID                     NUMBER(18) NULL,
    EFFECTIVE_START_DATE                   DATE NOT NULL,
    EFFECTIVE_END_DATE                     DATE NOT NULL,
    JOB_CODE                               VARCHAR2(30) NULL,
    BUSINESS_GROUP_ID                      NUMBER(18) NULL,
    SET_ID                                 NUMBER(18) NULL,
    BENCHMARK_JOB_ID                       NUMBER(18) NULL,
    JOB_FAMILY_ID                          NUMBER(18) NULL,
    JOB_SUB_FAMILY                         VARCHAR2(30) NULL,
    ACTION_OCCURRENCE_ID                   NUMBER(18) NULL,
    ACTIVE_STATUS                          VARCHAR2(30) NULL,
    BENCHMARK_JOB_FLAG                     VARCHAR2(30) NULL,
    APPROVAL_AUTHORITY                     NUMBER(38) NULL,
    SCHEDULING_GROUP                       VARCHAR2(30) NULL,
    MANAGER_LEVEL                          VARCHAR2(30) NULL,
    MED_CHECKUP_REQ                        VARCHAR2(30) NULL,
    STANDARD_WORKING_HOURS                 NUMBER(22) NULL,
    STANDARD_WORKING_FREQUENCY             VARCHAR2(30) NULL,
    STD_ANNUAL_WORKING_DURATION            NUMBER(8) NULL,
    ANNUAL_WORKING_DURATION_UNITS          VARCHAR2(10) NULL,
    CATEGORY_CODE                          VARCHAR2(80) NULL,
    REGULAR_TEMPORARY                      VARCHAR2(30) NULL,
    FULL_PART_TIME                         VARCHAR2(30) NULL,
    JOB_FUNCTION_CODE                      VARCHAR2(30) NULL,
    OBJECT_VERSION_NUMBER                  NUMBER(9) NULL,
    CREATED_BY                             VARCHAR2(64) NULL,
    CREATION_DATE                          TIMESTAMP NULL,
    LAST_UPDATED_BY                        VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                       TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                      VARCHAR2(32) NULL,
    GRADE_LADDER_ID                        NUMBER(18) NULL,
    REQUISITION_TEMPLATE_ID                NUMBER(18) NULL,
    CONSTRAINT PER_JOBS_F_PK PRIMARY KEY (JOB_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PER_LEGISLATIVE_DATA_GROUPS_TL
(
    LEGISLATIVE_DATA_GROUP_ID              NUMBER(18) NOT NULL,
    LANGUAGE                               VARCHAR2(4) NOT NULL,
    BUSINESS_GROUP_ID                      NUMBER(18) NULL,
    NAME                                   VARCHAR2(240) NULL,
    SOURCE_LANG                            VARCHAR2(4) NULL,
    OBJECT_VERSION_NUMBER                  NUMBER(9) NULL,
    CREATED_BY                             VARCHAR2(64) NULL,
    CREATION_DATE                          TIMESTAMP NULL,
    LAST_UPDATED_BY                        VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                       TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                      VARCHAR2(32) NULL,
    CONSTRAINT PER_LEG_TL_PK PRIMARY KEY (LEGISLATIVE_DATA_GROUP_ID, LANGUAGE)
);

CREATE TABLE FUSION.PER_LEGISLATIVE_DATA_GROUPS
(
    LEGISLATIVE_DATA_GROUP_ID              NUMBER(18) NOT NULL,
    BUSINESS_GROUP_ID                      NUMBER(18) NULL,
    DEFAULT_CURRENCY_CODE                  VARCHAR2(20) NULL,
    LEGISLATION_CODE                       VARCHAR2(30) NULL,
    COST_ALLOCATION_ID_FLEX_NUM            NUMBER NULL,
    OBJECT_VERSION_NUMBER                  NUMBER(9) NULL,
    CREATED_BY                             VARCHAR2(64) NULL,
    CREATION_DATE                          TIMESTAMP NULL,
    LAST_UPDATED_BY                        VARCHAR2(64) NULL,
    LAST_UPDATE_DATE                       TIMESTAMP NULL,
    LAST_UPDATE_LOGIN                      VARCHAR2(32) NULL,
    CONSTRAINT PER_LEG_DT_GRP_PK PRIMARY KEY (LEGISLATIVE_DATA_GROUP_ID)
);

-- Oracle Fusion DDL generated from the supplied Oracle table reference PDFs
-- Schema: FUSION | Object owner: PER
-- Only primary-key columns are NOT NULL; all other included columns are NULL.
-- No tablespace clauses or foreign-key constraints are included.

CREATE TABLE FUSION.PER_LOCATIONS
(
    LOCATION_ID                          NUMBER(18) NOT NULL,
    OBJECT_VERSION_NUMBER                NUMBER(9),
    BUSINESS_GROUP_ID                    NUMBER(18),
    SET_ID                               NUMBER(18),
    INTERNAL_LOCATION_CODE               VARCHAR2(150),
    LOCATION_IMAGE_URL                   VARCHAR2(1000),
    ACTION_OCCURRENCE_ID                 NUMBER(18),
    CATEGORY_CODE                        VARCHAR2(80),
    CREATED_BY                           VARCHAR2(64),
    CREATION_DATE                        TIMESTAMP,
    LAST_UPDATED_BY                      VARCHAR2(64),
    LAST_UPDATE_DATE                     TIMESTAMP,
    LAST_UPDATE_LOGIN                    VARCHAR2(32),
    COUNTRY                              VARCHAR2(60),
    EMPLOYEE_LOCATION_FLAG               VARCHAR2(1)
  , CONSTRAINT PER_LOCATIONS_PK PRIMARY KEY (LOCATION_ID)
);
CREATE TABLE FUSION.PER_PERSON_NAMES_F
(
    PERSON_NAME_ID                       NUMBER(18) NOT NULL,
    EFFECTIVE_START_DATE                 DATE NOT NULL,
    EFFECTIVE_END_DATE                   DATE NOT NULL,
    PERSON_ID                            NUMBER(18),
    BUSINESS_GROUP_ID                    NUMBER(18),
    LEGISLATION_CODE                     VARCHAR2(4),
    NAME_TYPE                            VARCHAR2(30),
    LAST_NAME                            VARCHAR2(150),
    FIRST_NAME                           VARCHAR2(150),
    MIDDLE_NAMES                         VARCHAR2(80),
    TITLE                                VARCHAR2(30),
    PRE_NAME_ADJUNCT                     VARCHAR2(150),
    SUFFIX                               VARCHAR2(80),
    KNOWN_AS                             VARCHAR2(80),
    PREVIOUS_LAST_NAME                   VARCHAR2(150),
    HONORS                               VARCHAR2(80),
    MILITARY_RANK                        VARCHAR2(80),
    DISPLAY_NAME                         VARCHAR2(240),
    FULL_NAME                            VARCHAR2(2000),
    LIST_NAME                            VARCHAR2(240),
    ORDER_NAME                           VARCHAR2(240),
    OBJECT_VERSION_NUMBER                NUMBER(9),
    CREATED_BY                           VARCHAR2(64),
    CREATION_DATE                        TIMESTAMP,
    LAST_UPDATE_DATE                     TIMESTAMP,
    LAST_UPDATE_LOGIN                    VARCHAR2(32),
    LAST_UPDATED_BY                      VARCHAR2(64),
    CHAR_SET_CONTEXT                     VARCHAR2(4)
  , CONSTRAINT PER_PERSON_NAMES_F_PK PRIMARY KEY (PERSON_NAME_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);
CREATE TABLE FUSION.PER_PERSONS
(
    PERSON_ID                            NUMBER(18) NOT NULL,
    BUSINESS_GROUP_ID                    NUMBER(18),
    PARTY_ID                             NUMBER(18),
    START_DATE                           DATE,
    CORRESPONDENCE_LANGUAGE              VARCHAR2(30),
    BLOOD_TYPE                           VARCHAR2(30),
    DATE_OF_BIRTH                        DATE,
    DATE_OF_DEATH                        DATE,
    COUNTRY_OF_BIRTH                     VARCHAR2(240),
    REGION_OF_BIRTH                      VARCHAR2(240),
    TOWN_OF_BIRTH                        VARCHAR2(240),
    USER_GUID                            VARCHAR2(64),
    OBJECT_VERSION_NUMBER                NUMBER(9),
    CREATED_BY                           VARCHAR2(64),
    CREATION_DATE                        TIMESTAMP,
    LAST_UPDATED_BY                      VARCHAR2(64),
    LAST_UPDATE_LOGIN                    VARCHAR2(32),
    LAST_UPDATE_DATE                     TIMESTAMP,
    CATEGORY_CODE                        VARCHAR2(80)
  , CONSTRAINT PER_PERSONS_PK PRIMARY KEY (PERSON_ID)
);

Commit;

-- Oracle Fusion DDL generated from the five supplied PDF data dictionary extracts.
-- Schema: FUSION. Object owner: PAY for all five tables, as stated in each PDF.
-- Only primary-key columns are NOT NULL; every other included column is nullable.
-- No tablespace clauses or foreign-key constraints are included.
-- Excluded requested prefixes/columns: ATTRIBUTE*, SEED_DATA_SOURCE, ENTERPRISE_ID,
-- ORA_SEED*, and other named excluded prefixes.
-- PRL_INFORMATION* columns are retained: they appear in PAY_ALL_PAYROLLS_F.pdf,
-- are not among the named excluded prefixes, and are not marked as DFF columns
-- in the supplied PDF extract.
--
-- PAY_ALL_PAYROLLS_F primary key constraint name is PAY_PAYROLLS_F_PK,
-- exactly as shown in the PDF's Primary Key section.

-- PAY_ALL_PAYROLLS_F | Schema: FUSION | Object owner: PAY
ALTER SESSION SET CURRENT_SCHEMA = FUSION;

CREATE TABLE FUSION.PAY_ALL_PAYROLLS_F
(
    PAYROLL_ID                               NUMBER(18) NOT NULL,
    PROCESS_SUB_DATE_OFFSET                  NUMBER(5),
    PROCESS_SUB_WRT                          VARCHAR2(1),
    PROCESS_SUB_BASE_DATE                    VARCHAR2(1),
    PROCESS_SUB_FALLS                        NUMBER(2),
    PROCESS_SUB_OFFSET                       VARCHAR2(1),
    PROCESS_SUB_FIXED_DATE                   DATE,
    EFFECTIVE_START_DATE                     DATE NOT NULL,
    EFFECTIVE_END_DATE                       DATE NOT NULL,
    REPORTING_NAME                           VARCHAR2(80),
    PAYROLL_NAME                             VARCHAR2(80),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    CONSOLIDATION_SET_ID                     NUMBER(18),
    GL_SET_OF_BOOKS_ID                       NUMBER(18),
    PERIOD_TYPE                              VARCHAR2(30),
    TIME_DEFINITION_ID                       NUMBER(18),
    FIRST_PERIOD_END_DATE                    DATE,
    NUMBER_OF_YEARS                          NUMBER(5),
    PERIOD_RESET_YEARS                       NUMBER(9),
    CUT_OFF_DATE_OFFSET                      NUMBER(5),
    REGULAR_EARN_DATE_OFFSET                 NUMBER(5),
    REGULAR_PROCESS_DATE_OFFSET              NUMBER(5),
    DEFAULT_PAYDATE_OFFSET                   NUMBER(5),
    PAYSLIP_VIEW_DATE_OFFSET                 NUMBER(5),
    NEGATIVE_PAY_ALLOWED_FLAG                VARCHAR2(30),
    DEFAULT_PAYMENT_METHOD_ID                NUMBER(18),
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    BASE_OFFSETS                             VARCHAR2(1),
    PAYMENTS_WRT                             VARCHAR2(1),
    PAYDATE_BASE_WRT                         VARCHAR2(1),
    PAYSLIP_BASE_WRT                         VARCHAR2(1),
    CUTOFF_BASE_WRT                          VARCHAR2(1),
    PROCESS_BASE_WRT                         VARCHAR2(1),
    EARN_BASE_WRT                            VARCHAR2(1),
    PAYSLIP_BASE_DATE                        VARCHAR2(1),
    CUTOFF_BASE_DATE                         VARCHAR2(1),
    PROCESS_BASE_DATE                        VARCHAR2(1),
    EARN_BASE_DATE                           VARCHAR2(1),
    PAYDATE_BASE_DATE                        VARCHAR2(1),
    PROCESS_FALLS                            NUMBER(2),
    EARN_FALLS                               NUMBER(2),
    PAYDATE_FALLS                            NUMBER(2),
    PAYSLIP_FALLS                            NUMBER(2),
    CUTOFF_FALLS                             NUMBER(2),
    PAYSLIP_OFFSET                           VARCHAR2(1),
    EARN_OFFSET                              VARCHAR2(1),
    PROCESS_OFFSET                           VARCHAR2(1),
    CUTOFF_OFFSET                            VARCHAR2(1),
    PAYDATE_OFFSET                           VARCHAR2(1),
    FIXED_DATE                               VARCHAR2(1),
    PAYSLIP_FIXED_DATE                       DATE,
    CUTOFF_FIXED_DATE                        DATE,
    PROCESS_FIXED_DATE                       DATE,
    EARN_FIXED_DATE                          DATE,
    PAYDATE_FIXED_DATE                       DATE,
    CONSTRAINT PAY_PAYROLLS_F_PK PRIMARY KEY (PAYROLL_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- PAY_ANA_PAYROLL_ACTIONS | Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_ANA_PAYROLL_ACTIONS
(
    PAYROLL_ACTION_ID                        NUMBER(18) NOT NULL,
    PROCESS_DATE                             DATE,
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    CATEGORY                                 VARCHAR2(32),
    PAYROLL_ID                               NUMBER(18),
    TIME_PERIOD_ID                           NUMBER(18),
    DEDN_TIME_PERIOD_ID                      NUMBER(18),
    FLOW_INSTANCE_ID                         NUMBER(18),
    FLOW_INSTANCE_NAME                       VARCHAR2(200),
    BASE_FLOW_ID                             NUMBER(18),
    RUN_TYPE_ID                              NUMBER(18),
    TASK_ID                                  NUMBER(18),
    ACTION_TYPE                              VARCHAR2(30),
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    LAST_UPDATE_DATE                         TIMESTAMP,
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CONSTRAINT PAY_ANA_PAYROLL_ACTIONS_PK PRIMARY KEY (PAYROLL_ACTION_ID)
);

-- PAY_BAL_EXCEP_REPORT_ENTRIES | Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_BAL_EXCEP_REPORT_ENTRIES
(
    BAL_EXCEP_REPORT_ENTRY_ID                NUMBER(18) NOT NULL,
    BAL_EXCEPTION_REPORT_ID                  NUMBER(18),
    BAL_EXCEPTION_ID                         NUMBER(18),
    LEGISLATION_CODE                         VARCHAR2(30),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    LAST_UPDATED_BY                          VARCHAR2(64),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BAL_EXCEP_RPRT_ENTR_PK PRIMARY KEY (BAL_EXCEP_REPORT_ENTRY_ID)
);

-- PAY_BAL_EXCEPTION_REPORTS_B | Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_BAL_EXCEPTION_REPORTS_B
(
    BAL_EXCEPTION_REPORT_ID                  NUMBER(18) NOT NULL,
    MODULE_ID                                VARCHAR2(32),
    REPORT_DEFINITION_ID                     NUMBER(18),
    BASE_BAL_EXCEP_REPORT_NAME               VARCHAR2(80),
    LEGISLATION_CODE                         VARCHAR2(30),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    CONSOLIDATION_SET_ID                     NUMBER(18),
    PAYROLL_ID                               NUMBER(18),
    OUTPUT_FORMAT                            VARCHAR2(30),
    LAST_UPDATED_BY                          VARCHAR2(64),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BAL_EXCEPTION_REPORTS_PK PRIMARY KEY (BAL_EXCEPTION_REPORT_ID)
);

-- PAY_BAL_EXCEPTION_REPORTS_TL | Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_BAL_EXCEPTION_REPORTS_TL
(
    BAL_EXCEPTION_REPORT_ID                  NUMBER(18) NOT NULL,
    BAL_EXCEP_REPORT_NAME                    VARCHAR2(80),
    LANGUAGE                                 VARCHAR2(4) NOT NULL,
    SOURCE_LANG                              VARCHAR2(4),
    LAST_UPDATED_BY                          VARCHAR2(64),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BAL_EXCEP_REPORTS_TL_PK PRIMARY KEY (BAL_EXCEPTION_REPORT_ID, LANGUAGE)
);

-- Oracle Fusion CREATE TABLE DDL generated from the five supplied PDF files.
-- Schema: FUSION
-- Object owner: PAY for all five tables, as specified in the PDFs.
--
-- Applied rules:
--   1. Table names match the PDF names.
--   2. Primary-key columns are NOT NULL.
--   3. All other included columns are nullable, even where the PDFs mark them NOT NULL.
--   4. Excluded the requested prefixes/columns:
--      ATTRIBUTE*, ELEMENT_INFORMATION*, SGUID, SEED_DATA_SOURCE, ORA_SEED*,
--      ENTERPRISE_ID, PIL*, PBT_INFORMATION*, ACTION_INFORMATION*, ENTRY*,
--      and columns marked as descriptive flexfield columns.
--   5. No tablespace clauses or foreign-key constraints are included.
--
-- Note: Source PDFs show additional not-null attributes for non-PK columns.
--       Per the request, those constraints are intentionally not applied.

-- Table: PAY_BAL_EXCEPTIONS_B
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_BAL_EXCEPTIONS_B
(
    BAL_EXCEPTION_ID                           NUMBER(18) NOT NULL,
    MODULE_ID                                  VARCHAR2(32),
    REPORT_DEFINITION_ID                       NUMBER(18),
    BASE_BAL_EXCEPTION_NAME                    VARCHAR2(80),
    LEGISLATION_CODE                           VARCHAR2(30),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    CURRENCY_CODE                              VARCHAR2(15),
    DEFINED_BALANCE_ID                         NUMBER(18),
    VARIANCE_TYPE                              VARCHAR2(30),
    VARIANCE_VALUE                             NUMBER(11),
    COMPARISON_TYPE                            VARCHAR2(30),
    COMPARISON_VALUE                           NUMBER(9),
    VARIANCE_OPERATOR                          VARCHAR2(30),
    OUTPUT_FORMAT                              VARCHAR2(30),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    SEVERITY_LEVEL                             NUMBER(1),
    FORMULA_ID                                 NUMBER(18),
    TARGET_DEFINED_BALANCE_ID                  NUMBER(18),
    BALANCE_GROUP_ID                           NUMBER(18),
    CONSTRAINT PAY_BAL_EXCEPTIONS_B_PK PRIMARY KEY (BAL_EXCEPTION_ID)
);

-- Table: PAY_BAL_EXCEPTIONS_TL
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_BAL_EXCEPTIONS_TL
(
    BAL_EXCEPTION_ID                           NUMBER(18) NOT NULL,
    BAL_EXCEPTION_NAME                         VARCHAR2(80),
    LANGUAGE                                   VARCHAR2(4) NOT NULL,
    SOURCE_LANG                                VARCHAR2(4),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_BAL_EXCEPTIONS_TL_PK PRIMARY KEY (BAL_EXCEPTION_ID, LANGUAGE)
);

-- Table: PAY_CONSOLIDATION_SETS
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_CONSOLIDATION_SETS
(
    CONSOLIDATION_SET_ID                       NUMBER(18) NOT NULL,
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    CONSOLIDATION_SET_NAME                     VARCHAR2(60),
    CONSOLIDATION_SET_CODE                     VARCHAR2(60),
    COMMENTS                                   CLOB,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_CONSOLIDATION_SETS_PK PRIMARY KEY (CONSOLIDATION_SET_ID)
);

-- Table: PAY_DEFINED_BALANCES
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_DEFINED_BALANCES
(
    DEFINED_BALANCE_ID                         NUMBER(18) NOT NULL,
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    MODULE_ID                                  VARCHAR2(32),
    BALANCE_TYPE_ID                            NUMBER(18),
    BALANCE_DIMENSION_ID                       NUMBER(18),
    GROSSUP_ALLOWED_FLAG                       VARCHAR2(30),
    GROSSUP_EXCLUDE_BY_DEFAULT                 VARCHAR2(30),
    SAVE_RUN_BALANCE                           VARCHAR2(30),
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_DEFINED_BALANCES_PK PRIMARY KEY (DEFINED_BALANCE_ID)
);

-- Table: PAY_EXCEPTIONS
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_EXCEPTIONS
(
    PAYROLL_EXCEPTION_ID                       NUMBER(18) NOT NULL,
    SOURCE                                     VARCHAR2(32),
    PERSON_ID                                  NUMBER(18),
    PAYROLL_RELATIONSHIP_ID                    NUMBER(18),
    HR_ASSIGNMENT_ID                           NUMBER(18),
    PROCESS_IDENTIFIER                         NUMBER(18),
    TIME_PERIOD_ID                             NUMBER(18),
    EXCEPTION_TYPE                             VARCHAR2(32),
    EXCEPTION_CODE                             VARCHAR2(128),
    EXCEPTION_DETAIL                           VARCHAR2(4000),
    EXCEPTION_OBJECT_ID                        NUMBER(18),
    AI_VERDICT                                 VARCHAR2(32),
    AI_EXPLANATION                             VARCHAR2(4000),
    AI_CONFIDENCE_LEVEL                        NUMBER(5),
    HUMAN_VERDICT                              VARCHAR2(32),
    HUMAN_EXPLANATION                          VARCHAR2(4000),
    ASSIGNED_TO                                VARCHAR2(64),
    STATUS                                     VARCHAR2(20),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CONSTRAINT PAY_EXCEPTIONS_PK PRIMARY KEY (PAYROLL_EXCEPTION_ID)
);

-- Oracle Fusion CREATE TABLE DDL generated from the seven supplied PDF files.
-- Schema: FUSION
--
-- Applied rules:
--   * Table names match the supplied PDF names.
--   * Object owner is PAY for PAY_* tables and PER for PER_* tables.
--   * Only primary-key columns are declared NOT NULL.
--   * All other included columns are nullable, regardless of PDF not-null flags.
--   * Excluded ENTERPRISE_ID, ATTRIBUTE* / ASS_ATTRIBUTE* / ATTRIBUTE_NUMBER* /
--     ATTRIBUTE_DATE*, and descriptive flexfield information families.
--   * Excluded tablespace clauses and all foreign-key constraints.
--   * Retained the PDF primary-key constraint names and column order.
--
-- Note: PAY_TIME_PERIODS PRD_INFORMATION* columns and PER assignment
--       ASG_INFORMATION* columns are descriptive-information/flexfield families
--       and are omitted along with the explicitly excluded ATTRIBUTE families.

-- Table: PAY_FLOW_INSTANCES
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_FLOW_INSTANCES
(
    FLOW_INSTANCE_ID                           NUMBER(18) NOT NULL,
    FLOW_CATEGORIES                            VARCHAR2(100),
    CONTEXT_PARAM_VALUES                       CLOB,
    SUBMISSION_CONTEXT                         VARCHAR2(100),
    ROOT_FLOW_INSTANCE_ID                      NUMBER(18),
    INSTANCE_NAME                              VARCHAR2(200),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    BASE_FLOW_ID                               NUMBER(18),
    FI_TASK_STATUS                             VARCHAR2(20),
    FI_PAYROLL_ID                              NUMBER(20),
    FI_PAYROLL_PERIOD                          NUMBER(18),
    FI_PROCESS_DATE                            DATE,
    FI_TASK_TYPE                               VARCHAR2(20),
    ERRORED                                    VARCHAR2(1),
    MARKED_FOR_RETRY                           VARCHAR2(1),
    REVERSED                                   VARCHAR2(1),
    NUMBER_OF_TASKS                            NUMBER(3),
    FI_COMPLETED_TASKS                         NUMBER(3),
    RECUR_SCH_FORMULA_ID                       NUMBER(18),
    RECUR_TIME_COMPONENT                       VARCHAR2(50),
    PROGRESS                                   NUMBER(9),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    RUN_ID                                     NUMBER(18),
    STATUS                                     VARCHAR2(30),
    RECUR_SCH_TIME_DEF_ID                      NUMBER(18),
    SCHEDULED_DATE                             TIMESTAMP,
    SCHEDULE_END_DATE                          TIMESTAMP,
    RECURRING_FLAG                             VARCHAR2(1),
    FI_TASK_FLOW_FLAG                          VARCHAR2(2),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    INSTANTIATED_BY                            VARCHAR2(100),
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    EXECUTION_MODE                             VARCHAR2(20),
    FI_TOTAL_COMPLETED                         NUMBER,
    FI_ROLLEDBACK                              VARCHAR2(30),
    FLOW_INSTANCE_NAME_UNIQUE                  VARCHAR2(200),
    FLOW_INSTANCE_UNIQUE                       VARCHAR2(200),
    IS_FULL_ROLLBACK                           VARCHAR2(30),
    IS_SKIPPED                                 VARCHAR2(30),
    IS_INCOMPLETE                              VARCHAR2(30),
    IS_EXTRACT                                 VARCHAR2(2),
    IS_DATA_LOADER                             VARCHAR2(2),
    FLOW_ID                                    NUMBER(18),
    SUB_STATUS                                 VARCHAR2(40),
    AC_TYPE                                    VARCHAR2(10),
    OUTBOUND_ENABLED_FLAG                      VARCHAR2(1),
    IS_BG_PROCESSING_ACTIVE                    VARCHAR2(1),
    BG_PROCESSING_STATUS                       VARCHAR2(50),
    IS_VERIFY_PENDING                          VARCHAR2(4),
    CONSTRAINT PAY_FLOW_INSTANCES_PK PRIMARY KEY (FLOW_INSTANCE_ID)
);

-- Table: PAY_PAY_RELATIONSHIPS_DN
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_PAY_RELATIONSHIPS_DN
(
    PAYROLL_RELATIONSHIP_ID                    NUMBER(18) NOT NULL,
    START_DATE                                 DATE,
    END_DATE                                   DATE,
    PAYROLL_RELATIONSHIP_NUMBER                VARCHAR2(30),
    PAYROLL_STAT_UNIT_ID                       NUMBER(18),
    PERSON_ID                                  NUMBER(18),
    RELATIONSHIP_TYPE_ID                       NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_PAY_RELATIONSHIPS_DN_PK PRIMARY KEY (PAYROLL_RELATIONSHIP_ID)
);

-- Table: PAY_REL_GROUPS_DN
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_REL_GROUPS_DN
(
    RELATIONSHIP_GROUP_ID                      NUMBER(18) NOT NULL,
    AC_TRIGGER_FLAG                            VARCHAR2(1),
    START_DATE                                 DATE,
    END_DATE                                   DATE,
    PAYROLL_RELATIONSHIP_ID                    NUMBER(18),
    GROUP_TYPE                                 VARCHAR2(30),
    TERM_ID                                    NUMBER(18),
    ASSIGNMENT_ID                              NUMBER(18),
    PARENT_REL_GROUP_ID                        NUMBER(18),
    LEGAL_EMPLOYER_ID                          NUMBER(18),
    ASSIGNMENT_NUMBER                          VARCHAR2(30),
    TAX_REPORTING_UNIT_ID                      NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_REL_GROUPS_DN_PK PRIMARY KEY (RELATIONSHIP_GROUP_ID)
);

-- Table: PAY_TIME_PERIODS
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_TIME_PERIODS
(
    TIME_PERIOD_ID                             NUMBER(18) NOT NULL,
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    PAYROLL_ID                                 NUMBER(18),
    END_DATE                                   DATE,
    PERIOD_NAME                                VARCHAR2(70),
    PERIOD_NUM                                 NUMBER(18),
    PERIOD_TYPE                                VARCHAR2(30),
    START_DATE                                 DATE,
    CUT_OFF_DATE                               DATE,
    DESCRIPTION                                VARCHAR2(240),
    PERIOD_SET_NAME                            VARCHAR2(30),
    PERIOD_YEAR                                NUMBER(18),
    PROC_PERIOD_TYPE                           VARCHAR2(30),
    QUARTER_NUM                                NUMBER(18),
    QUICKPAY_DISPLAY_NUMBER                    NUMBER(9),
    RUN_DISPLAY_NUMBER                         NUMBER(9),
    STATUS                                     VARCHAR2(30),
    DEFAULT_PAYDATE                            DATE,
    REGULAR_PROCESS_DATE                       DATE,
    PROCESS_SUB_DATE                           DATE,
    REGULAR_EARN_DATE                          DATE,
    YEAR_NUMBER                                NUMBER(18),
    PERIOD_CATEGORY                            VARCHAR2(30),
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    TIME_DEFINITION_ID                         NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    PAYSLIP_VIEW_DATE                          DATE,
    CONSTRAINT PAY_TIME_PERIODS_PK PRIMARY KEY (TIME_PERIOD_ID)
);

-- Table: PER_ALL_ASSIGNMENTS_M
-- Schema: FUSION | Object owner: PER
CREATE TABLE FUSION.PER_ALL_ASSIGNMENTS_M
(
    ASSIGNMENT_ID                              NUMBER(18) NOT NULL,
    EFFECTIVE_START_DATE                       DATE NOT NULL,
    EFFECTIVE_END_DATE                         DATE NOT NULL,
    BUSINESS_GROUP_ID                          NUMBER(18),
    PERSON_ID                                  NUMBER(18),
    PERIOD_OF_SERVICE_ID                       NUMBER(18),
    ASSIGNMENT_TYPE                            VARCHAR2(30),
    ASSIGNMENT_NUMBER                          VARCHAR2(50),
    ASSIGNMENT_SEQUENCE                        NUMBER(18) NOT NULL,
    ASSIGNMENT_STATUS_TYPE_ID                  NUMBER(18),
    PRIMARY_FLAG                               VARCHAR2(30),
    ORGANIZATION_ID                            NUMBER(18),
    JOB_ID                                     NUMBER(18),
    LOCATION_ID                                NUMBER(18),
    POSITION_ID                                NUMBER(18),
    GRADE_ID                                   NUMBER(18),
    GRADE_LADDER_PGM_ID                        NUMBER(18),
    PEOPLE_GROUP_ID                            NUMBER(18),
    COLLECTIVE_AGREEMENT_ID                    NUMBER(18),
    BARGAINING_UNIT_CODE                       VARCHAR2(30),
    LABOUR_UNION_MEMBER_FLAG                   VARCHAR2(30),
    CAGR_GRADE_DEF_ID                          NUMBER(18),
    CAGR_ID_FLEX_NUM                           NUMBER(18),
    CONTRACT_ID                                NUMBER(18),
    MANAGER_FLAG                               VARCHAR2(30),
    DATE_PROBATION_END                         DATE,
    PROBATION_PERIOD                           NUMBER(25),
    PROBATION_UNIT                             VARCHAR2(30),
    NORMAL_HOURS                               NUMBER(22),
    FREQUENCY                                  VARCHAR2(30),
    WORK_AT_HOME                               VARCHAR2(30),
    TIME_NORMAL_FINISH                         VARCHAR2(5),
    TIME_NORMAL_START                          VARCHAR2(5),
    NOTICE_PERIOD                              NUMBER(10),
    NOTICE_PERIOD_UOM                          VARCHAR2(30),
    DEFAULT_CODE_COMB_ID                       NUMBER(18),
    EMPLOYEE_CATEGORY                          VARCHAR2(30),
    EMPLOYMENT_CATEGORY                        VARCHAR2(30),
    ESTABLISHMENT_ID                           NUMBER(18),
    HOURLY_SALARIED_CODE                       VARCHAR2(30),
    SAL_REVIEW_PERIOD                          NUMBER(18),
    SAL_REVIEW_PERIOD_FREQUENCY                VARCHAR2(30),
    JOB_POST_SOURCE_NAME                       VARCHAR2(240),
    PROJECT_TITLE                              VARCHAR2(80),
    PERSON_REFERRED_BY_ID                      NUMBER(18),
    PO_HEADER_ID                               NUMBER(18),
    PO_LINE_ID                                 NUMBER(18),
    RECRUITER_ID                               NUMBER(18),
    RECRUITMENT_ACTIVITY_ID                    NUMBER(18),
    VACANCY_ID                                 NUMBER(18),
    APPLICANT_RANK                             NUMBER,
    POSTING_CONTENT_ID                         NUMBER(18),
    SOURCE_ORGANIZATION_ID                     NUMBER(18),
    SOURCE_TYPE                                VARCHAR2(30),
    PROJECTED_ASSIGNMENT_END                   DATE,
    SET_OF_BOOKS_ID                            NUMBER(18),
    SOFT_CODING_KEYFLEX_ID                     NUMBER(18),
    SPECIAL_CEILING_STEP_ID                    NUMBER(18),
    VENDOR_ASSIGNMENT_NUMBER                   VARCHAR2(30),
    VENDOR_EMPLOYEE_NUMBER                     VARCHAR2(30),
    VENDOR_ID                                  NUMBER(18),
    VENDOR_SITE_ID                             NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    WORK_TERMS_ASSIGNMENT_ID                   NUMBER(18),
    ACTION_CODE                                VARCHAR2(30),
    ASSIGNMENT_NAME                            VARCHAR2(80),
    ASSIGNMENT_STATUS_TYPE                     VARCHAR2(30),
    AUTO_END_FLAG                              VARCHAR2(30),
    DUTIES_TYPE                                VARCHAR2(30),
    EFFECTIVE_SEQUENCE                         NUMBER(4) NOT NULL,
    EXPENSE_CHECK_ADDRESS                      VARCHAR2(30),
    INTERNAL_BUILDING                          VARCHAR2(45),
    INTERNAL_FLOOR                             VARCHAR2(45),
    INTERNAL_LOCATION                          VARCHAR2(80),
    INTERNAL_MAILSTOP                          VARCHAR2(45),
    INTERNAL_OFFICE_NUMBER                     VARCHAR2(45),
    LEGAL_ENTITY_ID                            NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(150),
    LINKAGE_TYPE                               VARCHAR2(30),
    PARENT_ASSIGNMENT_ID                       NUMBER(18),
    PERSON_TYPE_ID                             NUMBER(18),
    PRIMARY_WORK_TERMS_FLAG                    VARCHAR2(30),
    PRIMARY_ASSIGNMENT_FLAG                    VARCHAR2(30),
    PRIMARY_WORK_RELATION_FLAG                 VARCHAR2(30),
    PROJECTED_START_DATE                       DATE,
    REASON_CODE                                VARCHAR2(30),
    SYSTEM_PERSON_TYPE                         VARCHAR2(30),
    BUSINESS_UNIT_ID                           NUMBER(18),
    BILLING_TITLE                              VARCHAR2(30),
    STEP_ENTRY_DATE                            DATE,
    RECORD_CREATOR                             VARCHAR2(30),
    ACTION_OCCURRENCE_ID                       NUMBER(18),
    PROPOSED_WORKER_TYPE                       VARCHAR2(30),
    RETIREMENT_AGE                             NUMBER(18),
    RETIREMENT_DATE                            DATE,
    POSITION_OVERRIDE_FLAG                     VARCHAR2(30),
    EFFECTIVE_LATEST_CHANGE                    VARCHAR2(30) NOT NULL,
    ALLOW_ASG_OVERRIDE_FLAG                    VARCHAR2(30),
    FREEZE_START_DATE                          DATE,
    FREEZE_UNTIL_DATE                          DATE,
    ID_FLEX_NUM                                NUMBER(18),
    CATEGORY_CODE                              VARCHAR2(80),
    FULL_PART_TIME                             VARCHAR2(30),
    PERMANENT_TEMPORARY_FLAG                   VARCHAR2(30),
    GSP_ELIGIBILITY_FLAG                       VARCHAR2(30),
    UNION_ID                                   NUMBER(18),
    SENIORITY_BASIS                            VARCHAR2(30),
    OVERTIME_PERIOD                            NUMBER(18),
    SOURCE_ASSIGNMENT_ID                       NUMBER(18),
    LAST_WORKING_DATE                          DATE,
    REVIEW_USER_ACCESS                         VARCHAR2(30),
    REHIRE_RECOMMENDATION                      VARCHAR2(30),
    REHIRE_REASON                              VARCHAR2(30),
    REHIRE_AUTHORIZER_PERSON_ID                NUMBER(18),
    TERMINATION_DATE                           DATE,
    NOTIFICATION_DATE                          DATE,
    STANDARD_HOURS                             NUMBER(22),
    STANDARD_FREQUENCY                         VARCHAR2(30),
    STD_ANNUAL_WORKING_DURATION                NUMBER(8),
    ANNUAL_WORKING_DURATION_UNITS              VARCHAR2(20),
    ANNUAL_WORKING_DURATION                    NUMBER(8),
    ANNUAL_WORKING_RATIO                       NUMBER(8),
    ADJUSTED_FTE                               NUMBER(30),
    CONSTRAINT PER_ALL_ASSIGNMENTS_M_PK PRIMARY KEY (ASSIGNMENT_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE, EFFECTIVE_LATEST_CHANGE, EFFECTIVE_SEQUENCE)
);

-- Table: PER_ALL_PEOPLE_F
-- Schema: FUSION | Object owner: PER
CREATE TABLE FUSION.PER_ALL_PEOPLE_F
(
    PERSON_ID                                  NUMBER(18) NOT NULL,
    EFFECTIVE_START_DATE                       DATE NOT NULL,
    EFFECTIVE_END_DATE                         DATE NOT NULL,
    BUSINESS_GROUP_ID                          NUMBER(18),
    START_DATE                                 DATE,
    APPLICANT_NUMBER                           VARCHAR2(30),
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    PERSON_NUMBER                              VARCHAR2(30),
    WAIVE_DATA_PROTECT                         VARCHAR2(30),
    PRIMARY_EMAIL_ID                           NUMBER(18),
    PRIMARY_PHONE_ID                           NUMBER(18),
    MAILING_ADDRESS_ID                         NUMBER(18),
    PRIMARY_NID_ID                             NUMBER(18),
    PRIMARY_NID_NUMBER                         VARCHAR2(30),
    CONSTRAINT PER_PEOPLE_F_PK PRIMARY KEY (PERSON_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- Oracle Fusion Payroll Balance tables
-- Generated from the five supplied Oracle table-definition PDFs.
-- Schema: FUSION | Object owner: PAY
--
-- Rules carried forward from the previous batch:
--   * Retain the source table names, included column names, datatypes,
--     VARCHAR2 lengths, and NUMBER precision.
--   * Preserve the primary-key column order and PK constraint names.
--   * Declare only primary-key columns as NOT NULL; all other included
--     columns are nullable in this generated DDL.
--   * Exclude ENTERPRISE_ID, ATTRIBUTE* columns, SEED_DATA_SOURCE,
--     ORA_SEED_SET* columns, SGUID, and descriptive-information/flexfield
--     columns (including PBT_INFORMATION_*).
--   * Do not add foreign-key constraints or tablespace clauses.
--
-- Note: Source PDFs show additional NOT NULL flags on non-PK columns.
-- Those are intentionally not carried forward, matching the prior activity.

-- PAY_BAL_CLASSIFICATIONS
CREATE TABLE FUSION.PAY_BAL_CLASSIFICATIONS
(
    BALANCE_CLASSIFICATION_ID                NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    LEGISLATION_CODE                         VARCHAR2(30),
    MODULE_ID                                VARCHAR2(32),
    BALANCE_TYPE_ID                          NUMBER(18),
    CLASSIFICATION_ID                        NUMBER(18),
    SCALE                                    NUMBER(5),
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BAL_CLASSIFICATIONS_PK PRIMARY KEY (BALANCE_CLASSIFICATION_ID)
);

-- PAY_BALANCE_DIMENSIONS
CREATE TABLE FUSION.PAY_BALANCE_DIMENSIONS
(
    BALANCE_DIMENSION_ID                     NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    LEGISLATION_CODE                         VARCHAR2(30),
    MODULE_ID                                VARCHAR2(32),
    APPLICATION_ID                           NUMBER(18),
    DIMENSION_LEVEL                          VARCHAR2(30),
    PERIOD_TYPE                              VARCHAR2(30),
    ROUTE_ID                                 NUMBER(18),
    BASE_DB_ITEM_SUFFIX                      VARCHAR2(80),
    BASE_DIMENSION_NAME                      VARCHAR2(160),
    DIMENSION_TYPE                           VARCHAR2(1),
    DESCRIPTION                              VARCHAR2(240),
    PAYMENTS_FLAG                            VARCHAR2(30),
    EXPIRY_CHECKING_LEVEL                    VARCHAR2(1),
    FEED_CHECKING_TYPE                       VARCHAR2(1),
    ASG_ACTION_BALANCE_DIM_ID                NUMBER(18),
    SAVE_RUN_BALANCE_ENABLED                 VARCHAR2(30),
    INITIAL_DATE                             DATE,
    INITIAL_TIME_DEF_ID                      NUMBER(18),
    START_TIME_DEF_ID                        NUMBER(18),
    END_TIME_DEF_ID                          NUMBER(18),
    EXPIRY_TIME_DEF_ID                       NUMBER(18),
    TIME_PERIOD_ID                           NUMBER(18),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BALANCE_DIMENSIONS_PK PRIMARY KEY (BALANCE_DIMENSION_ID)
);

-- PAY_BALANCE_FEEDS_F
CREATE TABLE FUSION.PAY_BALANCE_FEEDS_F
(
    BALANCE_FEED_ID                          NUMBER(18),
    EFFECTIVE_START_DATE                     DATE,
    EFFECTIVE_END_DATE                       DATE,
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    LEGISLATION_CODE                         VARCHAR2(30),
    MODULE_ID                                VARCHAR2(32),
    BALANCE_TYPE_ID                          NUMBER(18),
    INPUT_VALUE_ID                           NUMBER(18),
    SCALE                                    NUMBER(5),
    ELEMENT_TYPE_ID                          NUMBER(18),
    SOURCE_ID                                NUMBER(18),
    SOURCE_TYPE                              VARCHAR2(30),
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BALANCE_FEEDS_F_PK PRIMARY KEY (BALANCE_FEED_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- PAY_BALANCE_TYPES_TL
CREATE TABLE FUSION.PAY_BALANCE_TYPES_TL
(
    BALANCE_TYPE_ID                          NUMBER(18),
    BALANCE_NAME                             VARCHAR2(120),
    REPORTING_NAME                           VARCHAR2(120),
    DESCRIPTION                              VARCHAR2(2000),
    LANGUAGE                                 VARCHAR2(4),
    SOURCE_LANG                              VARCHAR2(4),
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BALANCE_TYPES_TL_PK PRIMARY KEY (BALANCE_TYPE_ID, LANGUAGE)
);

-- PAY_BALANCE_TYPES
CREATE TABLE FUSION.PAY_BALANCE_TYPES
(
    BALANCE_TYPE_ID                          NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                NUMBER(18),
    LEGISLATION_CODE                         VARCHAR2(30),
    MODULE_ID                                VARCHAR2(32),
    CURRENCY_CODE                            VARCHAR2(15),
    BASE_BALANCE_NAME                        VARCHAR2(80),
    BALANCE_UOM                              VARCHAR2(30),
    REMUNERATION_FLAG                        VARCHAR2(30),
    BALANCE_CATEGORY_ID                      NUMBER(18),
    BASE_BALANCE_TYPE_ID                     NUMBER(18),
    INPUT_VALUE_ID                           NUMBER(18),
    APPLICATION_ID                           NUMBER(18),
    DEDUCTION_TYPE_ID                        NUMBER(18),
    COMMENTS                                 CLOB,
    LAST_UPDATE_DATE                         TIMESTAMP,
    LAST_UPDATED_BY                          VARCHAR2(64),
    LAST_UPDATE_LOGIN                        VARCHAR2(32),
    CREATED_BY                               VARCHAR2(64),
    CREATION_DATE                            TIMESTAMP,
    OBJECT_VERSION_NUMBER                    NUMBER(9),
    CONSTRAINT PAY_BALANCE_TYPES_PK PRIMARY KEY (BALANCE_TYPE_ID)
);

-- Oracle Fusion Payroll DDL generated from the four supplied PDF files.
-- Schema: FUSION
--
-- Applied rules:
--   * Table names and column definitions follow the supplied PDFs.
--   * Object owner: PAY for all four tables.
--   * Only primary-key columns are NOT NULL; all other included columns
--     are nullable, as requested.
--   * Excluded ENTERPRISE_ID, SGUID, SEED_DATA_SOURCE, ORA_SEED_SET*,
--     and other explicitly excluded flexfield/information column families.
--   * No tablespace clauses or foreign-key constraints are included.
--
-- Note: PAY_PAYROLL_ACTIONS(1).pdf is represented by its actual table name
--       PAY_PAYROLL_ACTIONS; the "(1)" is only a duplicate filename suffix.

-- Table: PAY_DIMENSION_USAGES
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_DIMENSION_USAGES
(
    DIMENSION_USAGE_ID                         NUMBER(18),
    BALANCE_DIMENSION_ID                       NUMBER(18),
    DATABASE_ITEM_SUFFIX                       VARCHAR2(80),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    USE_IN_EXCEP_REPORTING_FLAG                VARCHAR2(1),
    MODULE_ID                                  VARCHAR2(32),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CONSTRAINT PAY_DIMENSION_USAGES_PK PRIMARY KEY (DIMENSION_USAGE_ID)
);

-- Table: PAY_PAYROLL_ACTIONS
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_PAYROLL_ACTIONS
(
    PAYROLL_ACTION_ID                          NUMBER(18),
    ACTION_STATUS                              VARCHAR2(1),
    ACTION_TYPE                                VARCHAR2(30),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(20),
    ACTION_POPULATION_STATUS                   VARCHAR2(1),
    CURRENT_CHUNK_NUMBER                       NUMBER(18),
    DISPLAY_RUN_NUMBER                         NUMBER(10),
    PAY_REQUEST_ID                             NUMBER(18),
    ACTION_SEQUENCE                            NUMBER(18),
    ACTION_PARAMETER_GROUP_ID                  NUMBER(18),
    START_DATE                                 DATE,
    END_DATE                                   DATE,
    EFFECTIVE_DATE                             DATE,
    PAYROLL_ID                                 NUMBER(18),
    CONSOLIDATION_SET_ID                       NUMBER(18),
    ELEMENT_SET_ID                             NUMBER(18),
    DATE_EARNED                                DATE,
    RUN_TYPE_ID                                NUMBER(18),
    ASSIGNMENT_SET_ID                          NUMBER(18),
    PAYMENT_TYPE_ID                            NUMBER(18),
    EARN_TIME_PERIOD_ID                        NUMBER(18),
    DEDN_TIME_PERIOD_ID                        NUMBER(18),
    BATCH_PROCESS_MODE                         VARCHAR2(30),
    LEGISLATIVE_PARAMETERS                     VARCHAR2(2000),
    RETRO_DEFINITION_ID                        NUMBER(18),
    FUTURE_PROCESS_MODE                        VARCHAR2(30),
    COSTING_PROCESS_MODE                       VARCHAR2(30),
    TARGET_PAYROLL_ACTION_ID                   NUMBER(18),
    CREATOR_ID                                 NUMBER(18),
    CREATOR_TYPE                               VARCHAR2(30),
    CURRENT_TASK                               VARCHAR2(30),
    ORG_PAYMENT_METHOD_ID                      NUMBER(18),
    PARENT_ORG_PAY_METHOD_ID                   NUMBER(18),
    START_CHEQUE_NUMBER                        NUMBER(18),
    END_CHEQUE_NUMBER                          NUMBER(18),
    OVERRIDING_DD_DATE                         DATE,
    REPORT_CATEGORY_ID                         NUMBER(18),
    CHEQUE_PROCEDURE                           VARCHAR2(30),
    REPORT_FORMAT_MAPPING_ID                   NUMBER(18),
    EFT_FILE_REFERENCE                         VARCHAR2(30),
    EFT_EXPIRY_DATE                            DATE,
    BIP_JOB_ID                                 NUMBER(18),
    INTERFACE_TYPE_ID                          NUMBER(18),
    PAYMENT_REASON                             VARCHAR2(30),
    FILE_NAME                                  VARCHAR2(256),
    PARAMETER1                                 VARCHAR2(2300),
    PARAMETER2                                 VARCHAR2(30),
    PARAMETER3                                 VARCHAR2(30),
    PARAMETER4                                 VARCHAR2(30),
    PARAMETER5                                 VARCHAR2(30),
    PROCESS_EVENT_ID                           NUMBER(18),
    EVENT_ACTION_ID                            NUMBER(18),
    PAY_PAYEE_TYPE                             VARCHAR2(30),
    EXPEDITE_FLAG                              VARCHAR2(30),
    EXPIRE_ID                                  NUMBER(8),
    PROCESS_PHASE                              VARCHAR2(20),
    OVERRIDE_DATE                              DATE,
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    LAST_UPDATE_DATE                           TIMESTAMP,
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CREATED_BY                                 VARCHAR2(64),
    CONSTRAINT PAY_PAYROLL_ACTIONS_PK PRIMARY KEY (PAYROLL_ACTION_ID)
);

-- Table: PAY_PAYROLL_REL_ACTIONS
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_PAYROLL_REL_ACTIONS
(
    PAYROLL_REL_ACTION_ID                      NUMBER(18),
    PAYROLL_ACTION_ID                          NUMBER(18),
    PAYROLL_RELATIONSHIP_ID                    NUMBER(18),
    ACTION_STATUS                              VARCHAR2(1),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    ACTION_SEQUENCE                            NUMBER(18),
    CHUNK_NUMBER                               NUMBER(18),
    SOURCE_ACTION_ID                           NUMBER(18),
    RUN_TYPE_ID                                NUMBER(18),
    PRE_PAYMENT_ID                             NUMBER(18),
    START_DATE                                 DATE,
    END_DATE                                   DATE,
    SERIAL_NUMBER                              VARCHAR2(30),
    RETRO_COMPONENT_ID                         NUMBER(18),
    SOURCE_ID                                  NUMBER(18),
    PARENT_OBJECT_ID                           VARCHAR2(2000),
    PROCESS_PATH                               VARCHAR2(80),
    ORA_PART_KEY                               DATE,
    CONSTRAINT PAY_PAYROLL_REL_ACTIONS_PK PRIMARY KEY (PAYROLL_REL_ACTION_ID)
);

-- Table: PAY_RUN_BALANCES
-- Schema: FUSION | Object owner: PAY
CREATE TABLE FUSION.PAY_RUN_BALANCES
(
    RUN_BALANCE_ID                             NUMBER(18),
    DEFINED_BALANCE_ID                         NUMBER(18),
    EFFECTIVE_DATE                             DATE,
    BALANCE_VALUE                              NUMBER,
    PAYROLL_REL_ACTION_ID                      NUMBER(18),
    PAYROLL_RELATIONSHIP_ID                    NUMBER(18),
    PAYROLL_TERM_ID                            NUMBER(18),
    PAYROLL_ASSIGNMENT_ID                      NUMBER(18),
    ACTION_SEQUENCE                            NUMBER(18),
    PAYROLL_ACTION_ID                          NUMBER(18),
    TAX_UNIT_ID                                NUMBER(18),
    LEGAL_EMPLOYER_ID                          NUMBER(18),
    ELEMENT_ENTRY_ID                           NUMBER(18),
    PAYROLL_ID                                 NUMBER(18),
    BALANCE_DATE                               DATE,
    AREA1                                      NUMBER(18),
    AREA2                                      NUMBER(18),
    AREA3                                      NUMBER(18),
    AREA4                                      NUMBER(18),
    THIRD_PARTY_PAYEE_ID                       NUMBER(18),
    TIME_DEFINITION_ID                         NUMBER(18),
    CALC_BREAKDOWN_ID                          NUMBER(18),
    PROCESSING_SPAN                            NUMBER(18),
    DEDUCTION_TYPE_ID                          NUMBER(18),
    CONTEXT_VALUE1                             VARCHAR2(60),
    CONTEXT_VALUE2                             VARCHAR2(60),
    CONTEXT_VALUE3                             VARCHAR2(60),
    CONTEXT_VALUE4                             VARCHAR2(60),
    CONTEXT_VALUE5                             VARCHAR2(60),
    CONTEXT_VALUE6                             VARCHAR2(60),
    ORA_PART_KEY                               DATE,
    CONSTRAINT PAY_RUN_BALANCES_PK PRIMARY KEY (RUN_BALANCE_ID)
);

-- Oracle Fusion Payroll DDL generated from the five supplied PDF files.
-- Schema: FUSION
-- Object owner: PAY
--
-- Applied rules (same as the preceding batch):
--   * Preserve table names, included column names, datatypes, lengths and precision.
--   * Only primary-key columns are NOT NULL; all other included columns are nullable.
--   * Exclude ENTERPRISE_ID, SGUID, SEED_DATA_SOURCE, ORA_SEED_SET* columns.
--   * Exclude flexfield/information column families (ATTRIBUTE*, ENTRY_INFORMATION*,
--     PEC_INFORMATION* and their category columns).
--   * Do not add tablespace clauses or foreign-key constraints.
--
-- Composite primary keys are retained exactly as shown in the source PDFs.

CREATE TABLE FUSION.PAY_ASSIGNED_PAYROLLS_DN
(
    ASSIGNED_PAYROLL_ID                        NUMBER(18),
    LSED                                       DATE,
    LSPD                                       DATE,
    FINC                                       DATE,
    FSED                                       DATE,
    START_DATE                                 DATE,
    END_DATE                                   DATE,
    PAYROLL_TERM_ID                            NUMBER(18),
    PAYROLL_ID                                 NUMBER(18),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_ASSIGNED_PAYROLLS_DN_PK PRIMARY KEY (ASSIGNED_PAYROLL_ID)
);

CREATE TABLE FUSION.PAY_ELE_CLASSIFICATIONS_TL
(
    CLASSIFICATION_ID                          NUMBER(18),
    CLASSIFICATION_NAME                        VARCHAR2(120),
    LANGUAGE                                   VARCHAR2(4),
    SOURCE_LANG                                VARCHAR2(4),
    DESCRIPTION                                VARCHAR2(80),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_ELE_CLASSIFICATIONS_TL_PK PRIMARY KEY (CLASSIFICATION_ID, LANGUAGE)
);

CREATE TABLE FUSION.PAY_ELE_CLASSIFICATIONS
(
    CLASSIFICATION_ID                          NUMBER(18),
    DATE_FROM                                  DATE,
    DATE_TO                                    DATE,
    BASE_CLASSIFICATION_NAME                   VARCHAR2(160),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    NON_PAYMENTS_FLAG                          VARCHAR2(30),
    DEFAULT_LOW_PRIORITY                       NUMBER(9),
    DEFAULT_PRIORITY                           NUMBER(9),
    DEFAULT_HIGH_PRIORITY                      NUMBER(9),
    COSTABLE_FLAG                              VARCHAR2(30),
    COSTING_DEBIT_OR_CREDIT                    VARCHAR2(30),
    DISTRIBUTABLE_OVER_FLAG                    VARCHAR2(30),
    FREQ_RULE_ENABLED                          VARCHAR2(30),
    PROCESS_WHEN_EARNING                       VARCHAR2(30),
    PARENT_CLASSIFICATION_ID                   NUMBER(18),
    SECONDARY_CLASSIFICATION_FLAG              VARCHAR2(30),
    CREATE_BY_DEFAULT_FLAG                     VARCHAR2(30),
    BASE_CLASSIFICATION_ID                     NUMBER(18),
    MODULE_ID                                  VARCHAR2(32),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATE_DATE                           TIMESTAMP,
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CONSTRAINT PAY_ELE_CLASSIFICATIONS_PK PRIMARY KEY (CLASSIFICATION_ID)
);

CREATE TABLE FUSION.PAY_ELEMENT_ENTRIES_F
(
    ELEMENT_ENTRY_ID                           NUMBER(18),
    EFFECTIVE_START_DATE                       DATE,
    EFFECTIVE_END_DATE                         DATE,
    PERSON_ID                                  NUMBER(18),
    ELEMENT_TYPE_ID                            NUMBER(18),
    ENTRY_TYPE                                 VARCHAR2(30),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATOR_TYPE                               VARCHAR2(30),
    CREATOR_ID                                 NUMBER(18),
    BATCH_ID                                   NUMBER(18),
    BATCH_ACTION_ID                            NUMBER(18),
    REASON                                     VARCHAR2(4000),
    TARGET_ENTRY_ID                            NUMBER(18),
    SUBPRIORITY                                NUMBER(9),
    DATE_EARNED                                DATE,
    BALANCE_ADJ_COST_FLAG                      VARCHAR2(30),
    MULTIPLE_ENTRY_COUNT                       NUMBER(18),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATED_BY                            VARCHAR2(64),
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    CONSTRAINT PAY_ELEMENT_ENTRIES_F_PK PRIMARY KEY (ELEMENT_ENTRY_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PAY_ELEMENT_ENTRY_VALUES_F
(
    ELEMENT_ENTRY_VALUE_ID                     NUMBER(18),
    EFFECTIVE_START_DATE                       DATE,
    EFFECTIVE_END_DATE                         DATE,
    INPUT_VALUE_ID                             NUMBER(18),
    ELEMENT_ENTRY_ID                           NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    ENTRY_USAGE_ID                             NUMBER(18),
    SCREEN_ENTRY_VALUE                         VARCHAR2(60),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_ELEMENT_ENTRY_VALUES_F_PK PRIMARY KEY (ELEMENT_ENTRY_VALUE_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

-- Oracle Fusion Payroll CREATE TABLE DDL
-- Generated from the five supplied Oracle Fusion table-definition PDFs.
-- Schema: FUSION | Object owner: PAY
--
-- Same conventions as the preceding batches:
--   * Retain documented column names, datatypes, lengths and numeric precision.
--   * Only documented primary-key columns are declared NOT NULL (via PRIMARY KEY).
--   * Exclude ENTERPRISE_ID, SGUID, SEED_DATA_SOURCE and ORA_SEED_SET* columns.
--   * Exclude flexfield/information column families (ATTRIBUTE*, ELEMENT_INFORMATION*).
--   * Do not add tablespace clauses or foreign-key constraints.
--   * Use the primary keys shown in each PDF's Primary Key section.

CREATE TABLE FUSION.PAY_ELEMENT_LINKS_F
(
    ELEMENT_LINK_ID                            NUMBER(18),
    EFFECTIVE_START_DATE                       DATE,
    EFFECTIVE_END_DATE                         DATE,
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    ELEMENT_TYPE_ID                            NUMBER(18),
    STANDARD_LINK_FLAG                         VARCHAR2(30),
    ELEMENT_CRITERIA_ID                        NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    ELEMENT_LINK_NAME                          VARCHAR2(80),
    STARTING_TIME_DEF_ID                       NUMBER(18),
    ENDING_TIME_DEF_ID                         NUMBER(18),
    DEFAULTING_FORMULA_ID                      NUMBER(18),
    CALCULATION_FORMULA_ID                     NUMBER(18),
    VALIDATION_FORMULA_ID                      NUMBER(18),
    VALIDATION_OVERRIDE_MESSAGE                VARCHAR2(30),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    COSTING_LINK_FLAG                          VARCHAR2(30),
    CONSTRAINT PAY_ELEMENT_LINKS_F_PK PRIMARY KEY (ELEMENT_LINK_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PAY_ELEMENT_TYPES_F
(
    ELEMENT_TYPE_ID                            NUMBER(18),
    EFFECTIVE_START_DATE                       DATE,
    EFFECTIVE_END_DATE                         DATE,
    ADDITIONAL_ENTRY_ALLOWED_FLAG              VARCHAR2(30),
    ADJUSTMENT_ONLY_FLAG                       VARCHAR2(30),
    CLASSIFICATION_ID                          NUMBER(18),
    CLOSED_FOR_ENTRY_FLAG                      VARCHAR2(30),
    INDIRECT_ONLY_FLAG                         VARCHAR2(30),
    MULTIPLE_ENTRIES_ALLOWED_FLAG              VARCHAR2(30),
    PROCESS_IN_RUN_FLAG                        VARCHAR2(30),
    PROCESSING_PRIORITY                        NUMBER(9),
    PROCESSING_TYPE                            VARCHAR2(30),
    STANDARD_LINK_FLAG                         VARCHAR2(30),
    USE_AT_REL_LEVEL                           VARCHAR2(30),
    USE_AT_TERM_LEVEL                          VARCHAR2(30),
    USE_AT_ASG_LEVEL                           VARCHAR2(30),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    BASE_ELEMENT_NAME                          VARCHAR2(80),
    LEGISLATIVE_DATA_GROUP_ID                  NUMBER(18),
    LEGISLATION_CODE                           VARCHAR2(30),
    MODULE_ID                                  VARCHAR2(32),
    INPUT_CURRENCY_CODE                        VARCHAR2(15),
    OUTPUT_CURRENCY_CODE                       VARCHAR2(15),
    STARTING_TIME_DEF_ID                       NUMBER(18),
    ENDING_TIME_DEF_ID                         NUMBER(18),
    TIME_DEFINITION_TYPE                       VARCHAR2(1),
    TIME_DEFINITION_ID                         NUMBER(18),
    SECONDARY_CLASSIFICATION_ID                NUMBER(18),
    CATEGORY                                   VARCHAR2(30),
    CREATOR_TYPE                               VARCHAR2(30),
    FORMULA_ID                                 NUMBER(18),
    DEFAULTING_FORMULA_ID                      NUMBER(18),
    CALCULATION_FORMULA_ID                     NUMBER(18),
    VALIDATION_FORMULA_ID                      NUMBER(18),
    VALIDATION_OVERRIDE_MESSAGE                VARCHAR2(30),
    GROSSUP_FLAG                               VARCHAR2(30),
    ITERATIVE_FLAG                             VARCHAR2(30),
    ITERATIVE_FORMULA_ID                       NUMBER(18),
    ITERATIVE_PRIORITY                         NUMBER(9),
    ONCE_EACH_PERIOD_FLAG                      VARCHAR2(1),
    PROCESS_MODE                               VARCHAR2(30),
    PRORATION_FORMULA_ID                       NUMBER(18),
    PRORATION_GROUP_ID                         NUMBER(18),
    RECALC_EVENT_GROUP_ID                      NUMBER(18),
    DEDUCTION_TYPE_ID                          NUMBER(18),
    DEDUCTION_OR_EXEMPTION                     VARCHAR2(30),
    EXPEDITED_MODE                             VARCHAR2(30),
    PARENT_BASE_ELEMENT_NAME                   VARCHAR2(80),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_ELEMENT_TYPES_F_PK PRIMARY KEY (ELEMENT_TYPE_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PAY_ELEMENT_TYPES_TL
(
    ELEMENT_NAME                               VARCHAR2(80),
    REPORTING_NAME                             VARCHAR2(80),
    DESCRIPTION                                VARCHAR2(240),
    LANGUAGE                                   VARCHAR2(4),
    SOURCE_LANG                                VARCHAR2(4),
    ELEMENT_TYPE_ID                            NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_ELEMENT_TYPES_TL_PK PRIMARY KEY (ELEMENT_TYPE_ID, LANGUAGE)
);

CREATE TABLE FUSION.PAY_INPUT_VALUES_F
(
    INPUT_VALUE_ID                             NUMBER(18),
    EFFECTIVE_START_DATE                       DATE,
    EFFECTIVE_END_DATE                         DATE,
    DISPLAY_SEQUENCE                           NUMBER(5),
    ELEMENT_TYPE_ID                            NUMBER(18),
    GENERATE_DB_ITEMS_FLAG                     VARCHAR2(30),
    HOT_DEFAULT_FLAG                           VARCHAR2(30),
    MANDATORY_FLAG                             VARCHAR2(1),
    USER_ENTERABLE_FLAG                        VARCHAR2(1),
    BASE_NAME                                  VARCHAR2(80),
    UOM                                        VARCHAR2(30),
    USER_DISPLAY_FLAG                          VARCHAR2(30),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    RESERVED_INPUT_VALUE                       VARCHAR2(30),
    RETRO_STATIC_FLAG                          VARCHAR2(30),
    FORCE_RRV_MODE                             VARCHAR2(30),
    DEFAULT_VALUE                              VARCHAR2(60),
    FORMULA_ID                                 NUMBER(18),
    RATE_FORMULA_ID                            NUMBER(18),
    VALIDATION_OVERRIDE_MESSAGE                VARCHAR2(30),
    LOOKUP_TYPE                                VARCHAR2(30),
    MIN_VALUE                                  VARCHAR2(60),
    MAX_VALUE                                  VARCHAR2(60),
    VO_NAME                                    VARCHAR2(200),
    VALUE_SET_CODE                             VARCHAR2(200),
    WARNING_OR_ERROR                           VARCHAR2(30),
    CONTEXT_ID                                 NUMBER(18),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_INPUT_VALUES_F_PK PRIMARY KEY (INPUT_VALUE_ID, EFFECTIVE_START_DATE, EFFECTIVE_END_DATE)
);

CREATE TABLE FUSION.PAY_INPUT_VALUES_TL
(
    NAME                                       VARCHAR2(80),
    LANGUAGE                                   VARCHAR2(4),
    SOURCE_LANG                                VARCHAR2(4),
    INPUT_VALUE_ID                             NUMBER(18),
    OBJECT_VERSION_NUMBER                      NUMBER(9),
    CREATED_BY                                 VARCHAR2(64),
    CREATION_DATE                              TIMESTAMP,
    LAST_UPDATE_DATE                           TIMESTAMP,
    LAST_UPDATE_LOGIN                          VARCHAR2(32),
    LAST_UPDATED_BY                            VARCHAR2(64),
    CONSTRAINT PAY_INPUT_VALUES_TL_PK PRIMARY KEY (INPUT_VALUE_ID, LANGUAGE)
);

BEGIN
    FOR T IN (
        SELECT TABLE_NAME
        FROM ALL_TABLES
        WHERE OWNER IN ('PER', 'PAY', 'FUSION')
    )
    LOOP
        EXECUTE IMMEDIATE
            'GRANT SELECT, INSERT, UPDATE, DELETE ON FUSION.'
            || DBMS_ASSERT.ENQUOTE_NAME(T.TABLE_NAME, FALSE)
            || ' TO FUSION';
    END LOOP;
END;
/

commit;
