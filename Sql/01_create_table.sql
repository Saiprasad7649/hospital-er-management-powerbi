-- Create and rename database
ALTER DATABASE ER_Analytics
MODIFY NAME = HospitalER_Analytics;
GO

-- Create schema
CREATE SCHEMA er;
GO

-- Move table to schema
ALTER SCHEMA er
TRANSFER dbo.Hospital_ER_Data;

-- Rename table
EXEC sp_rename 'er.Hospital_ER_Data', 'ER_Visits';

-- Preview data
SELECT TOP 5 *
FROM er.ER_Visits;

-- Rename columns (clean naming convention)
EXEC sp_rename 'er.ER_Visits.[Patient Id]', 'PATIENT_ID', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Admission Date]', 'PATIENT_ADMISSION_DATE', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient first Inital]', 'PATIENT_FIRST_INITIAL', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Last Name]', 'PATIENT_LAST_NAME', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Gender]', 'PATIENT_GENDER', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Age]', 'PATIENT_AGE', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Race]', 'PATIENT_RACE', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Department Referral]', 'DEPARTMENT_REFERRAL', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Admission Flag]', 'PATIENT_ADMISSION_FLAG', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Satisfaction Score]', 'PATIENT_SATISFACTION_SCORE', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Waittime]', 'PATIENT_WAITTIME', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patients CM]', 'PATIENTS_CM', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Age Group]', 'AGE_GROUP', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Hour of Arrival]', 'HOUR_OF_ARRIVAL', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Day of Week]', 'DAY_OF_WEEK', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Wait Time Group]', 'WAIT_TIME_GROUP', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Satisfaction Band]', 'SATISFACTION_BAND', 'COLUMN';
EXEC sp_rename 'er.ER_Visits.[Patient Admission Flag Numeric]', 'PATIENT_ADMISSION_FLAG_NUMERIC', 'COLUMN';

-- Fix data types
ALTER TABLE er.ER_Visits ALTER COLUMN PATIENT_WAITTIME FLOAT;
ALTER TABLE er.ER_Visits ALTER COLUMN PATIENT_SATISFACTION_SCORE FLOAT;
ALTER TABLE er.ER_Visits ALTER COLUMN PATIENT_ADMISSION_FLAG_NUMERIC INT;
ALTER TABLE er.ER_Visits ALTER COLUMN HOUR_OF_ARRIVAL INT;
ALTER TABLE er.ER_Visits ALTER COLUMN PATIENT_ADMISSION_DATE DATETIME;

-- Verify structure
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ER_Visits' AND TABLE_SCHEMA = 'er';
