-- CLEAN TABLE - Contains cleaned data + engineered features

DROP TABLE diabetes_readmissions_clean;

CREATE TABLE diabetes_readmissions_clean
(
    encounter_id NUMBER,
    patient_nbr NUMBER,
    race VARCHAR2 (100),
    gender VARCHAR2 (100),
    age VARCHAR2 (100),
    admission_type_id NUMBER,
    discharge_disposition_id NUMBER,
    time_in_hospital NUMBER,
    num_lab_procedures NUMBER,
    num_medications NUMBER,
    number_diagnoses NUMBER,
    diag_1 VARCHAR2(100),
    diag_2 VARCHAR2(100),
    diag_3 VARCHAR2(100),
    readmitted VARCHAR2(100),
    admission_source_id NUMBER,     
    medical_specialty VARCHAR2(100),
    diabetesMed VARCHAR2(100),     
    insulin VARCHAR2(100),       
    medication_change VARCHAR2(100),
    num_procedures NUMBER,
    number_outpatient NUMBER,
    number_emergency NUMBER,
    number_inpatient NUMBER,
    A1Cresult VARCHAR2(100),
    max_glu_serum VARCHAR2(100),
    readmit_30d NUMBER,
    los_group  VARCHAR2(100),
    age_group  VARCHAR2(100),
    risk_score NUMBER,
    risk_category VARCHAR2(100)
);
    