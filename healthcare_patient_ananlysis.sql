/* ============================================================
   HEALTHCARE PATIENT ANALYSIS
   MySQL Analysis Queries

   Dataset: 5,000 cleaned healthcare records
   Schema: healthcare_test
   Table: healthcare_cleaned

   Note:
   case_id is not a unique identifier.
   Therefore COUNT(*) is used for record/case volume.
   ============================================================ */


USE healthcare_test;


/* ============================================================
   SECTION 1 — DATASET VALIDATION
   ============================================================ */

-- 1. Total number of records
SELECT
    COUNT(*) AS total_records
FROM healthcare_cleaned;


-- 2. Patient and case ID summary
SELECT
    COUNT(*) AS total_records,
    COUNT(case_id) AS non_null_case_ids,
    COUNT(DISTINCT case_id) AS distinct_case_ids,
    COUNT(DISTINCT patientid) AS distinct_patients
FROM healthcare_cleaned;


-- 3. Table structure
DESCRIBE healthcare_cleaned;


/* ============================================================
   SECTION 2 — DEPARTMENT ANALYSIS
   ============================================================ */

-- 4. Cases by department
SELECT
    Department,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY Department
ORDER BY total_cases DESC;


-- 5. Department case volume and percentage
SELECT
    Department,
    COUNT(*) AS total_cases,
    COUNT(DISTINCT hospital_code) AS unique_hospitals,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM healthcare_cleaned),
        2
    ) AS pct_of_total_cases
FROM healthcare_cleaned
GROUP BY Department
ORDER BY total_cases DESC;


/* ============================================================
   SECTION 3 — SEVERITY ANALYSIS
   ============================================================ */

-- 6. Overall severity distribution
SELECT
    `Severity of Illness`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY `Severity of Illness`
ORDER BY total_cases DESC;


-- 7. Severity distribution by department
SELECT
    Department,
    `Severity of Illness`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    Department,
    `Severity of Illness`
ORDER BY
    Department,
    total_cases DESC;


/* ============================================================
   SECTION 4 — ADMISSION ANALYSIS
   ============================================================ */

-- 8. Overall admission type distribution
SELECT
    `Type of Admission`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY `Type of Admission`
ORDER BY total_cases DESC;


-- 9. Admission type by department
SELECT
    Department,
    `Type of Admission`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    Department,
    `Type of Admission`
ORDER BY
    Department,
    total_cases DESC;


-- 10. Severity distribution by admission type
SELECT
    `Type of Admission`,
    `Severity of Illness`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    `Type of Admission`,
    `Severity of Illness`
ORDER BY
    `Type of Admission`,
    total_cases DESC;


/* ============================================================
   SECTION 5 — HOSPITAL TYPE ANALYSIS
   ============================================================ */

-- 11. Cases by hospital type
SELECT
    Hospital_type_code,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY Hospital_type_code
ORDER BY total_cases DESC;


-- 12. Hospital type by admission type
SELECT
    Hospital_type_code,
    `Type of Admission`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    Hospital_type_code,
    `Type of Admission`
ORDER BY
    Hospital_type_code,
    total_cases DESC;


-- 13. Hospital type by severity
SELECT
    Hospital_type_code,
    `Severity of Illness`,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    Hospital_type_code,
    `Severity of Illness`
ORDER BY
    Hospital_type_code,
    total_cases DESC;


/* ============================================================
   SECTION 6 — HOSPITAL CAPACITY ANALYSIS
   ============================================================ */

-- 14. Average available extra rooms by region and hospital type
SELECT
    Hospital_region_code,
    Hospital_type_code,
    COUNT(DISTINCT hospital_code) AS total_hospitals,
    ROUND(
        AVG(`Available Extra Rooms in Hospital`),
        2
    ) AS avg_extra_rooms,
    MIN(`Available Extra Rooms in Hospital`) AS min_rooms,
    MAX(`Available Extra Rooms in Hospital`) AS max_rooms
FROM healthcare_cleaned
GROUP BY
    Hospital_region_code,
    Hospital_type_code
ORDER BY
    Hospital_region_code,
    avg_extra_rooms ASC;


-- 15. Patient cases by hospital capacity category
SELECT
    Department,
    CASE
        WHEN `Available Extra Rooms in Hospital` = 0
            THEN 'Critical Capacity'
        WHEN `Available Extra Rooms in Hospital` BETWEEN 1 AND 2
            THEN 'Low Capacity'
        WHEN `Available Extra Rooms in Hospital` BETWEEN 3 AND 5
            THEN 'Moderate Capacity'
        ELSE 'High Capacity'
    END AS capacity_status,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY
    Department,
    capacity_status
ORDER BY
    Department,
    total_cases DESC;


/* ============================================================
   SECTION 7 — EMERGENCY ANALYSIS
   ============================================================ */

-- 16. Hospitals with the highest emergency case volume
SELECT
    hospital_code,
    COUNT(*) AS emergency_cases
FROM healthcare_cleaned
WHERE `Type of Admission` = 'Emergency'
GROUP BY hospital_code
ORDER BY emergency_cases DESC;


/* ============================================================
   SECTION 8 — ADMISSION DEPOSIT ANALYSIS
   ============================================================ */

-- 17. Admission deposit statistics by admission type
SELECT
    `Type of Admission`,
    ROUND(AVG(`Admission_Deposit`), 2) AS avg_admission_deposit,
    MIN(`Admission_Deposit`) AS minimum_deposit,
    MAX(`Admission_Deposit`) AS maximum_deposit,
    COUNT(*) AS total_cases
FROM healthcare_cleaned
GROUP BY `Type of Admission`
ORDER BY avg_admission_deposit DESC;


/* ============================================================
   SECTION 9 — REGIONAL ANALYSIS
   ============================================================ */

-- 18. Patient cases and hospitals by region
SELECT
    Hospital_region_code,
    COUNT(*) AS total_cases,
    COUNT(DISTINCT hospital_code) AS total_hospitals
FROM healthcare_cleaned
GROUP BY Hospital_region_code
ORDER BY total_cases DESC;


/* ============================================================
   SECTION 10 — AGE GROUP ANALYSIS
   ============================================================ */

-- 19. Patient distribution by age group
SELECT
    Age,
    COUNT(*) AS patient_count
FROM healthcare_cleaned
GROUP BY Age
ORDER BY Age;


/* ============================================================
   SECTION 11 — LENGTH OF STAY ANALYSIS
   ============================================================ */

-- 20. Patient distribution by length-of-stay category
SELECT
    Stay,
    COUNT(*) AS patient_count
FROM healthcare_cleaned
GROUP BY Stay
ORDER BY Stay;


/* ============================================================
   SECTION 12 — HOSPITAL-LEVEL ANALYSIS
   ============================================================ */

-- 21. Hospital-level performance summary
SELECT
    hospital_code,
    COUNT(*) AS total_cases,
    COUNT(DISTINCT Department) AS departments_served,
    ROUND(
        AVG(`Available Extra Rooms in Hospital`),
        2
    ) AS avg_extra_rooms,
    ROUND(
        AVG(`Admission_Deposit`),
        2
    ) AS avg_admission_deposit
FROM healthcare_cleaned
GROUP BY hospital_code
ORDER BY total_cases DESC;


/* ============================================================
   SECTION 13 — EXTREME SEVERITY ANALYSIS
   ============================================================ */

-- 22. Extreme-severity cases by hospital
SELECT
    hospital_code,
    COUNT(*) AS extreme_cases,
    ROUND(
        AVG(`Available Extra Rooms in Hospital`),
        2
    ) AS avg_extra_rooms
FROM healthcare_cleaned
WHERE `Severity of Illness` = 'Extreme'
GROUP BY hospital_code
ORDER BY extreme_cases DESC;


/* ============================================================
   SECTION 14 — DATA QUALITY CHECKS
   ============================================================ */

-- 23. Check repeated case IDs
-- Repeated case IDs are not automatically errors.
SELECT
    case_id,
    COUNT(*) AS occurrence_count
FROM healthcare_cleaned
GROUP BY case_id
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;


-- 24. Check whether one case ID is associated with multiple patients
SELECT
    case_id,
    COUNT(*) AS total_records,
    COUNT(DISTINCT patientid) AS unique_patients
FROM healthcare_cleaned
GROUP BY case_id
HAVING COUNT(DISTINCT patientid) > 1
ORDER BY unique_patients DESC;


-- 25. Check missing values in important columns
SELECT
    SUM(case_id IS NULL) AS missing_case_ids,
    SUM(hospital_code IS NULL) AS missing_hospital_codes,
    SUM(patientid IS NULL) AS missing_patient_ids,
    SUM(Department IS NULL) AS missing_departments,
    SUM(`Type of Admission` IS NULL) AS missing_admission_types,
    SUM(`Severity of Illness` IS NULL) AS missing_severity,
    SUM(Age IS NULL) AS missing_age,
    SUM(Stay IS NULL) AS missing_stay
FROM healthcare_cleaned;


/* ============================================================
   SECTION 15 — FINAL DATA VERIFICATION
   ============================================================ */

-- 26. Final record count
SELECT
    COUNT(*) AS final_record_count
FROM healthcare_cleaned;


-- 27. Final patient and case verification
SELECT
    COUNT(*) AS total_records,
    COUNT(patientid) AS non_null_patients,
    COUNT(DISTINCT patientid) AS unique_patients,
    COUNT(case_id) AS non_null_case_ids,
    COUNT(DISTINCT case_id) AS unique_case_ids
FROM healthcare_cleaned;


/* ============================================================
   END OF HEALTHCARE PATIENT ANALYSIS SQL PROJECT
   ============================================================ */