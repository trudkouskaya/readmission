-- Calculates readmission rate by age group
-- Used to assess how readmission risk changes across patient age segments.
SELECT age_group, ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct
FROM diabetes_readmissions_clean
GROUP BY age_group;