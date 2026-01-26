---- Calculates readmission rate by risk score
SELECT risk_score,
       ROUND(AVG(readmit_30d)*100,1) AS readmission_rate_pct,
       COUNT(*) AS patient_count
FROM diabetes_readmissions_clean
GROUP BY risk_score
ORDER BY risk_score;
