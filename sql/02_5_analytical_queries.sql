-- Calculates the overall 30-day readmission rate (%)
-- This metric represents the average probability of a patient being readmitted
-- within 30 days after discharge across the entire dataset.
SELECT ROUND(AVG(readmit_30d)*100,1) as readmission_rate_pct
FROM diabetes_readmissions_clean;















