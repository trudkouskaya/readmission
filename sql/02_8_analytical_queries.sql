-- Calculates readmission rate by discharge disposition
-- Identifies discharge pathways associated with higher readmission risk.
SELECT discharge_disposition_id, ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY discharge_disposition_id
ORDER BY readmission_rate_pct DESC;