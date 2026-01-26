-- Calculates readmission rate by length-of-stay group
-- Helps identify whether longer or shorter hospital stays
-- are associated with higher readmission risk.
SELECT los_group,ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY los_group
ORDER BY readmission_rate_pct DESC;