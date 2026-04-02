# Hospital Emergency Room Management - Power BI Dashboard

<div align="center">

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Excel](https://img.shields.io/badge/Microsoft%20Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Healthcare](https://img.shields.io/badge/Domain-Healthcare%20Analytics-blue?style=for-the-badge)

**An end-to-end data analytics project identifying ER operational bottlenecks across 9,216 patient visits**

[View Live Dashboard](#) &nbsp;|&nbsp; [Explore the Data](#project-structure) &nbsp;|&nbsp; [Key Findings](#key-findings)

</div>

---

## Table of Contents

- [Project Overview](#project-overview)
- [Business Impact](#business-impact)
- [Dashboard Pages](#dashboard-pages)
- [Key Findings](#key-findings)
- [Project Structure](#project-structure)
- [Three-Tool Pipeline](#three-tool-pipeline)
- [KPIs Measured](#kpis-measured)
- [Data Source](#data-source)
- [How to Use](#how-to-use)
- [Screenshots](#screenshots)
- [Future Enhancements](#future-enhancements)
- [Author](#author)

---

## Project Overview

Emergency Room overcrowding is one of the most critical operational challenges in modern healthcare. Long wait times directly reduce patient satisfaction, increase clinical risk, and strain staff across every shift.

This project analyses **9,216 ER patient visits** spanning **18 months (April 2023 - October 2024)** using a full three-tool analytics pipeline:

- **Excel** for data cleaning and feature engineering
- **SQL Server (T-SQL)** for schema transformation, KPI computation, and reusable analytical views
- **Power BI** for a five-page interactive dashboard

The goal is to answer four core operational questions:

> 1. **Where is time being lost?** - Peak overcrowding periods by hour and day
> 2. **Who is being affected?** - Demographic patterns in wait times and admissions
> 3. **Which referral pathways are the problem?** - Department-level wait time analysis
> 4. **Are patients satisfied?** - Satisfaction score correlation with wait time and the gap to hospital target

---

## Business Impact

This analysis highlights critical operational inefficiencies in ER workflows:

- Identified **system-wide overcrowding patterns**, not limited to specific time windows
- Quantified patient experience gaps, with satisfaction scores **22% below the hospital target**
- Detected **department-specific bottlenecks** (e.g., Neurology referrals driving the longest delays despite lower volume)
- Provided actionable insights for:
  - **Staffing optimisation** - using peak hour and day-of-week volume patterns
  - **Referral pathway redesign** - addressing specialty bottlenecks before they reach the ER floor
  - **Wait time reduction strategies** - targeting the 59.3% of patients waiting beyond the 30-minute benchmark

This project demonstrates how data analytics can directly support **hospital operations, patient experience, and clinical decision-making**.

---

## Dashboard Pages

| # | Page | Focus Area | Key Visual |
|---|------|------------|------------|
| 1 | **Executive Overview** | Top-level KPIs, volume trends, referral breakdown | Dual-axis line chart + wait time donut |
| 2 | **Wait Time & Overcrowding** | Hour-by-day heatmap, department delays, distribution | Day * Hour matrix with conditional formatting |
| 3 | **Patient Demographics** | Ethnicity, gender, age group breakdowns | Stacked bar by ethnicity + admission % by age |
| 4 | **Patient Satisfaction** | Wait vs satisfaction correlation, gauge vs target | Scatter plot + satisfaction gauge |
| 5 | **Patient Drill-Through** | Individual patient record on click | Detail table + per-patient wait gauge |

---

## Key Findings

| Metric | Value | Benchmark | Status |
|--------|-------|-----------|--------|
| Average Wait Time | **35.30 mins** | < 30 mins |  Above target |
| 90th Percentile Wait | **56.00 mins** | < 45 mins |  Critical |
| Patients Waiting > 30 mins | **59.3%** | < 40% | Critical |
| Patient Satisfaction Score | **5.47 / 10** | 7.0 / 10 | 22% below target |
| Admission Rate | **50.04%** | Varies |  High acuity load |

### Insights

- **Overcrowding is systemic, not isolated.** The Day * Hour heatmap shows consistently elevated wait times across all hours and days, with no meaningful off-peak relief window - indicating a capacity problem, not a scheduling problem.

- **1 in 10 patients waits nearly an hour.** The 90th percentile wait of 56 minutes represents a tangible patient safety risk, particularly for those who arrive requiring urgent attention and do not self-escalate.

- **Satisfaction and wait time are inversely correlated.** The scatter plot on Page 4 confirms a clear downward trend - longer waits are consistently associated with lower satisfaction scores across all referral types.

- **Neurology referrals drive the longest waits** despite lower volume than Self-Referral or General Practice - pointing to a specialist availability bottleneck rather than a volume issue.

- **Half of all ER visits result in hospital admission** (50.04%), indicating the ER is operating under high clinical acuity - compounding the wait time and overcrowding challenge.

- **Satisfaction is 22% below the hospital target of 7.0.** Gastroenterology-referred patients score highest; Renal-referred patients score lowest — highlighting that referral pathway design directly affects the patient experience.

---

## Project Structure

```
hospital-er-management-powerbi/
│
├── data/
│   ├── hospital_er_raw.csv                  # Original Kaggle download (9,216 rows)
│   └── hospital_er_clean.csv                # After Excel cleaning + derived columns
│
├── excel/
│   └── ER_Data_Cleaning_Analysis.xlsx       # Power Query + PivotTables + summary KPIs
│
├── sql/
│   ├── 01_create_table.sql                  # er schema creation + ER_Visits table (T-SQL)
│   ├── 02_kpi_queries.sql                   # Core KPI calculations
│   ├── 03_demographics_analysis.sql         # Breakdowns by race, gender, age group
│   ├── 04_referral_flow.sql                 # Department referral volume and wait impact
│   └── 05_create_views.sql                  # Views consumed by Power BI
│
├── powerbi/
│   └── ER_Operations_Dashboard.pbix         # Full 5-page Power BI report
│
├── screenshots/
│   ├── 01_executive_overview.png
│   ├── 02_wait_time_overcrowding.png
│   ├── 03_patient_demographics.png
│   ├── 04_patient_satisfaction.png
│   └── 05_drillthrough.png
│
└── README.md
```

---

## Three-Tool Pipeline

```
┌──────────────────┬──────────────────────┬─────────────────────────────────┐
│     EXCEL        │     SQL SERVER        │           POWER BI              │
├──────────────────┼──────────────────────┼─────────────────────────────────┤
│ • Import CSV     │ • Create er schema   │ • Connect to SQL Server views   │
│ • Fix nulls      │ • Migrate raw data   │ • Build Date table (DAX)        │
│ • Add columns:   │   into ER_Visits     │ • Write DAX measures            │
│   - Age_Group    │ • Rename columns     │ • 5-page dashboard              │
│   - Arrival_Hour │   (uppercase conv.)  │ • Heatmap, scatter, gauge       │
│   - Day_of_Week  │ • Fix data types     │ • Global slicers                │
│   - Wait_Bucket  │ • KPI queries        │ • Drill-through navigation      │
│   - Sat_Band     │ • Demographic        │ • Reset button (Demographics)   │
│ • PivotTables    │   segmentation       │ • Publish to web                │
│ • Export CSV     │ • Referral analysis  │                                 │
│                  │ • Create 4 views     │                                 │
└──────────────────┴──────────────────────┴─────────────────────────────────┘
```

### Excel - Data Cleaning & Feature Engineering

- Imported raw CSV via **Power Query** and corrected all column data types
- Handled null values in `patient_sat_score` for patients who did not submit a rating
- Created five derived columns using conditional logic in Power Query:
  - `Age_Group` - Paediatric / Adult / Senior
  - `Arrival_Hour` - extracted from timestamp
  - `Day_of_Week` - Monday through Sunday
  - `Wait_Bucket` - 0–15 / 16–30 / 31–60 / 60+ mins
  - `Satisfaction_Band` — Low / Medium / High / Not Rated
- Built PivotTables for initial data profiling and summary KPI validation
- Exported enriched file as `hospital_er_clean.csv` for SQL Server ingestion

### SQL Server — Data Transformation & Analytics Layer

- Designed a structured schema by creating a dedicated `er` schema and migrating raw data into a standardised table (`ER_Visits`)
- Performed data cleaning directly in SQL, including:
  - Renaming all columns to consistent uppercase naming conventions
  - Converting incorrect data types (wait time as INT, satisfaction score as DECIMAL, date/time fields to DATETIME)
- Built KPI queries to measure:
  - Average wait time, patient satisfaction (excluding unrated records with score = 0), and admission rate
- Developed analytical queries for:
  - Demographic segmentation by age group, gender, and race/ethnicity
  - Referral flow analysis and departmental bottleneck identification
- Created four reusable SQL views consumed directly by Power BI:
  - `vw_er_kpis` — executive-level KPIs as a single-row summary
  - `vw_hourly_volume` — heatmap dataset (day × hour visit counts and average wait)
  - `vw_dept_referral` — department-level wait time and admission performance
  - `vw_monthly_trends` — time-series volume and satisfaction trend data
- Ensured clean separation between data transformation logic and the visualisation layer, enabling maintainable and scalable Power BI integration

### Power BI — Dashboard & Visualisation

- Connected to SQL Server via Import Mode; imported all four views plus the full `ER_Visits` table
- Built a **Date dimension table** in DAX using `CALENDAR()` with Year, Month, Weekday, and Week Number columns
- Established a `Date_Table[Date]` → `ER_Visits[visit_date]` one-to-many relationship for time intelligence
- Wrote **8 core DAX measures** including `Avg Satisfaction` (filtered to exclude unrated visits), `% Waiting > 30 Min`, `Admitted vs Discharged Wait Gap`, and `90th Percentile Wait Time`
- Designed 5 dashboard pages with cross-page slicers, conditional formatting on the heatmap matrix, and drill-through navigation to individual patient records
- Added a **Reset button** on the Demographics page to clear all active filter selections
- Published the report to Power BI Service and enabled **Publish to Web** for public, login-free access

---

## KPIs Measured

| KPI | Formula | Why It Matters |
|-----|---------|----------------|
| Average Wait Time | `AVERAGE(wait_time_mins)` | Primary ER performance benchmark — target < 30 mins |
| 90th Percentile Wait | `PERCENTILX(er_visits, wait, 0.9)` | Captures the tail-end patient experience — 1 in 10 patients |
| % Waiting > 30 min | `COUNT(wait > 30) / total` | Overcrowding severity indicator |
| Admission Rate | `SUM(admin_flag = 1) / total` | Reflects patient acuity and downstream bed pressure |
| Avg Satisfaction Score | `AVG(sat_score) WHERE score > 0` | Patient experience metric — excludes unrated visits |
| Unrated Patient % | `COUNT(sat = 0) / total` | Data quality flag and potential LWBS proxy |
| Admitted vs Discharged Wait Gap | `Avg Wait(admitted) − Avg Wait(discharged)` | Boarding pressure indicator |
| Peak Hour Volume | `MAX(COUNT per hour)` | Staffing and surge planning input |

---

## Data Source

| Attribute | Detail |
|-----------|--------|
| **Source** | [Kaggle — Hospital Emergency Dataset](https://www.kaggle.com/datasets/xavierberge/hospital-emergency-dataset) |
| **Author** | Xavier Berge |
| **Rows** | 9,216 patient visits |
| **Columns** | 11 original + 5 derived |
| **Date Range** | April 2023 – October 2024 |
| **Format** | CSV |
| **Patient Data** | Fully synthetic — no real patient identifiable information |

### Original Columns

| Column | Type | Description |
|--------|------|-------------|
| `date` | Date | Timestamp of ER visit |
| `patient_id` | String | Unique patient identifier |
| `patient_gender` | String | M / F / NC |
| `patient_age` | Integer | Age in years |
| `patient_race` | String | Ethnicity / race category |
| `patient_sat_score` | Decimal | Satisfaction rating 0–10 (0 = not rated) |
| `patient_first_initial` | String | First name initial |
| `patient_last_name` | String | Last name |
| `patient_admin_flag` | Boolean | 1 = admitted, 0 = discharged |
| `patient_waittime` | Integer | Wait time in minutes |
| `department_referral` | String | Referring department or Self-Referral |

---

### Reproduce the Analysis Locally

**Prerequisites:** Microsoft Excel, SQL Server Management Studio (SSMS), Power BI Desktop (free)

#### Excel
```
1. Open: excel/ER_Data_Cleaning_Analysis.xlsx
2. Review Power Query transformation steps and PivotTables
3. Clean export already saved as: data/hospital_er_clean.csv
```

#### SQL Server — Run Scripts in SSMS

```
1. Open SQL Server Management Studio (SSMS)
2. Connect to your SQL Server instance
3. Run scripts in the following order:

   01_create_table.sql           -- Creates er schema and ER_Visits table
   02_kpi_queries.sql            -- Core KPI calculations
   03_demographics_analysis.sql  -- Demographic segmentation queries
   04_referral_flow.sql          -- Department referral analysis
   05_create_views.sql           -- Creates all 4 Power BI views

4. Verify views were created successfully:
```

```sql
SELECT * FROM er.vw_er_kpis;
SELECT * FROM er.vw_hourly_volume;
SELECT * FROM er.vw_dept_referral;
SELECT * FROM er.vw_monthly_trends;
```

#### Power BI
```
1. Open: powerbi/ER_Operations_Dashboard.pbix
2. Home → Transform Data → Data Source Settings
3. Update the SQL Server connection string to your local instance
4. Click Refresh — all 5 dashboard pages will populate automatically
```

---

## Screenshots

### Page 1 — Executive Overview
![Executive Overview](screenshots/01_executive_overview.png)

### Page 2 — Wait Time & Overcrowding
![Wait Time & Overcrowding](screenshots/02_wait_time_overcrowding.png)

### Page 3 — Patient Demographics
![Patient Demographics](screenshots/03_patient_demographics.png)

### Page 4 — Patient Satisfaction
![Patient Satisfaction](screenshots/04_patient_satisfaction.png)

### Page 5 — Patient Drill-Through
![Patient Drill-Through](screenshots/05_drillthrough.png)

---

## Future Enhancements

- [ ] Add **LWBS (Left Without Being Seen) rate** estimation using unrated patients as a proxy metric
- [ ] Build a **30-day readmission analysis** by tracking return visits per patient ID
- [ ] Add **seasonal surge analysis** — winter vs summer volume and wait time patterns
- [ ] Incorporate **staff-to-patient ratio modelling** using peak hour volume data
- [ ] Introduce **predictive wait time modelling** using arrival hour, day of week, and referral type as inputs
- [ ] Connect to a **live SQL Server source** for scheduled dashboard refresh in Power BI Service

---

## Author

**Saiprasad Gone**
Graduate Student - Health Informatics - Dec 2025
Aspiring Data Analyst | Healthcare Analytics

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin)](www.linkedin.com/in/saiprasad18)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github)](https://github.com/Saiprasad7649/hospital-er-management-powerbi.git)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-6366F1?style=flat)](https://saiprasad7649.github.io/portfolio/)

---

<div align="center">

⭐ If you found this project useful, please consider starring the repository

*Built with Excel · SQL Server · Power BI · and a passion for healthcare analytics*

</div>