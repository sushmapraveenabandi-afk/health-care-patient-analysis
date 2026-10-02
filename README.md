# Healthcare Patient Analysis

An end-to-end healthcare data analysis project completed as an internship portfolio project.

## Project overview

The project analyzes a cleaned healthcare dataset containing **5,000 records and 18 columns**.

### Dashboard KPIs
- Total cases: **5,000**
- Unique patients: **4,876**
- Departments: **5**
- Hospital types: **7**

## Workflow

**Excel → Python → MySQL/SQL → Dashboard**

- **Excel:** data cleaning and preparation
- **Python:** analysis and validation
- **MySQL/SQL:** data import, validation, and analytical queries
- **Dashboard:** interactive healthcare analysis with filters

## Dashboard

The final dashboard includes:
- Cases by department
- Cases by severity
- Cases by hospital type
- Patient cases by age
- Cases by admission type
- Admission type by severity
- Length of stay distribution
- Interactive filters for department, severity, and admission type

## Project structure

```text
Healthcare-Patient-Analysis/
├── dashboard/
│   └── healthcare_analysis_tableau.twbx
├── data/
│   └── healthcare_cleaned.csv
├── excel/
│   └── Flow.xlsx
├── python/
│   └── healthcare_data_analysis.ipynb
├── sql/
│   └── healthcare_patient_analysis.sql
├── README.md
└── .gitignore
```

## Data validation

During SQL validation, the final all-text staging import successfully retained all **5,000 rows**. Earlier typed imports returned **4,848 rows**, so the validated 5,000-row table was retained for the analysis.

## Notes

Only final, relevant project files should be committed to GitHub. Do not upload temporary Excel files, duplicate datasets, development screenshots, credentials, or unrelated files.
