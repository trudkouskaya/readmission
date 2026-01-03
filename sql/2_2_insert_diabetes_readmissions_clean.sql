-- INSERT CLEANED AND FEATURE-ENGINEERED DATA

TRUNCATE TABLE diabetes_readmissions_clean;
    
INSERT INTO diabetes_readmissions_clean (
    encounter_id,
    patient_nbr,
    race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    time_in_hospital,
    num_lab_procedures,
    num_medications,
    number_diagnoses,
    diag_1,
    diag_2,
    diag_3,
    readmitted,
    admission_source_id,     
    medical_specialty,
    diabetesMed,     
    insulin,       
    medication_change,
    num_procedures,
    number_outpatient,
    number_emergency,
    number_inpatient,
    A1Cresult,
    max_glu_serum,
    readmit_30d,
    los_group,
    age_group,
    risk_score,
    risk_category
)
WITH d AS (
SELECT
    encounter_id,
    patient_nbr,
    CASE
        WHEN race = '?' THEN NULL
        ELSE race
    END AS race,
    gender,
    age,
    admission_type_id,
    discharge_disposition_id,
    time_in_hospital,
    num_lab_procedures,
    num_medications,
    number_diagnoses,
    CASE
        WHEN diag_1 LIKE '250%' THEN 'Diabetes'
        WHEN diag_1 LIKE '428%' 
             OR diag_1 IN ('398.91', '402.01', '402.11', '402.91',
                              '404.01', '404.03', '404.11', '404.13',
                              '404.91', '404.93')
        THEN 'CHF'
        WHEN diag_1 LIKE '585%' 
             OR diag_1 = '586'
             OR diag_1 LIKE '403%'
             OR diag_1 LIKE '404%'
        THEN 'CKD'
        WHEN (SUBSTR(diag_1,1,3) BETWEEN '490' AND '492')
             OR diag_1 = '494' 
             OR diag_1 = '496'
        THEN 'COPD'
        WHEN diag_1 = '?' THEN NULL
        ELSE 'Other'
    END AS diag_1_group,
    CASE
        WHEN diag_2 LIKE '250%' THEN 'Diabetes'
        WHEN diag_2 LIKE '428%' 
             OR diag_2 IN ('398.91', '402.01', '402.11', '402.91',
                              '404.01', '404.03', '404.11', '404.13',
                              '404.91', '404.93')
        THEN 'CHF'
        WHEN diag_2 LIKE '585%' 
             OR diag_2 = '586'
             OR diag_2 LIKE '403%'
             OR diag_2 LIKE '404%'
        THEN 'CKD'
        WHEN (SUBSTR(diag_1,1,3) BETWEEN '490' AND '492')
             OR diag_2 = '494' 
             OR diag_2 = '496'
        THEN 'COPD'
        WHEN diag_2 = '?' THEN NULL
        ELSE 'Other'
    END AS diag_2_group,
    CASE
        WHEN diag_3 LIKE '250%' THEN 'Diabetes'
        WHEN diag_3 LIKE '428%' 
             OR diag_3 IN ('398.91', '402.01', '402.11', '402.91',
                              '404.01', '404.03', '404.11', '404.13',
                              '404.91', '404.93')
        THEN 'CHF'
        WHEN diag_3 LIKE '585%' 
             OR diag_3 = '586'
             OR diag_3 LIKE '403%'
             OR diag_3 LIKE '404%'
        THEN 'CKD'
        WHEN (SUBSTR(diag_1,1,3) BETWEEN '490' AND '492')
             OR diag_3 = '494' 
             OR diag_3 = '496'
        THEN 'COPD'
        WHEN diag_3 = '?' THEN NULL
        ELSE 'Other'
    END AS diag_3_group,
    readmitted,
    admission_source_id,
    CASE 
        WHEN medical_specialty = '?' THEN NULL
        ELSE medical_specialty
    END AS medical_spetialty,
    diabetesMed,     
    insulin,       
    medication_change,
    num_procedures,
    number_outpatient,
    number_emergency,
    number_inpatient,
    A1Cresult,
    max_glu_serum,
    -- Target variable
    CASE
        WHEN readmitted = '<30' THEN 1
        ELSE 0
    END AS readmit_30d,
    -- Length of stay group
    CASE
        WHEN time_in_hospital <= 3 THEN 'Short'
        WHEN time_in_hospital <= 7 THEN 'Medium'
        ELSE 'Long'
    END AS los_group,
    -- Age groups
    CASE 
        WHEN age IN ('[0-10)', '[10-20)', '[20-30)') THEN 'Young'
        WHEN age IN ('[30-40)', '[40-50)', '[50-60)') THEN 'Middle'
        ELSE 'Senior'
    END AS age_group
FROM diabetes_readmissions
WHERE time_in_hospital >= 1), -- Remove invalid hospital stays
d_with_risk_score AS (
SELECT d.*,
       CASE WHEN time_in_hospital > 7 THEN 2 ELSE 0 END
       + CASE WHEN number_diagnoses >= 5 THEN 2 ELSE 0 END 
       + CASE WHEN age_group IN ('[60-69)', '[70-79)', '[80-89)', '[90-100)') THEN 1 ELSE 0 END AS risk_score
FROM d),
d_with_risk_category AS (
SELECT d.*,
       CASE
          WHEN risk_score <= 1 THEN 'Low'
          WHEN risk_score BETWEEN 2 AND 3 THEN 'Medium'
          ELSE 'High'
       END AS risk_category
FROM d_with_risk_score d
)
SELECT * FROM d_with_risk_category;

ALTER TABLE diabetes_readmissions_clean
UPDATE diabetes_readmissions_clean
SET race = 'African American'
WHERE race = 'AfricanAmerican';

UPDATE diabetes_readmissions_clean
SET medication_change = 'Ch'
WHERE medication_change = 'Yes';


    