-- Calculates the overall 30-day readmission rate (%)
-- This metric represents the average probability of a patient being readmitted
-- within 30 days after discharge across the entire dataset.
SELECT ROUND(AVG(readmit_30d)*100,1) as readmission_rate_pct
FROM diabetes_readmissions_clean;



-- Calculates readmission rate by length-of-stay group
-- Helps identify whether longer or shorter hospital stays
-- are associated with higher readmission risk.
SELECT los_group,ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY los_group
ORDER BY readmission_rate_pct DESC;



-- Calculates readmission rate by age group
-- Used to assess how readmission risk changes across patient age segments.
SELECT age_group, ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY age_group;



-- Calculates readmission rate by discharge disposition
-- Identifies discharge pathways associated with higher readmission risk.
SELECT discharge_disposition_id, ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY discharge_disposition_id
ORDER BY readmission_rate_pct DESC;



---- Calculates readmission rate by risk score
SELECT risk_score,
       ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct, 
       COUNT(*) AS patient_count
FROM diabetes_readmissions_clean
GROUP BY risk_score
ORDER BY risk_score;
