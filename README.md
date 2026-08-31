

# **Logistics Operations Performance Analysis**

## 
Project Overview


This project analyzes warehouse/Shift level logistics operations data to identify operational bottlenecks, capacity pressure, backlog patterns, and service-performance risks.

The analysis follows an end-to-end analytics workflow:

**Python → Statistical Analysis → DuckDB → SQL → Tableau**

The objective is to demonstrate practical data-analysis and business-intelligence skills relevant to logistics, supply-chain, warehouse operations, and operations analyst roles.

## Business Problem

### Logistics operations need to balance:

Shipment volume
Warehouse capacity
Productivity
Backlog
On-time delivery
Operational errors
High utilization can indicate strong throughput, but sustained capacity pressure may also be associated with increasing backlog and declining service performance.

### This project investigates:

Which warehouses experience the greatest operational pressure?
How does utilization relate to backlog?
How does utilization relate to on-time delivery?
Which shifts perform better or worse?
Which periods show elevated operational risk?
When does operational pressure increase during the year?

## Tools & Technologies

| **Tool** | **Purpose**                                   |
| -------------- | --------------------------------------------------- |
| Python         | Data cleaning, exploration and statistical analysis |
| Pandas         | Data manipulation and aggregation                   |
| NumPy          | Numerical analysis                                  |
| SciPy          | Pearson correlation and statistical testing         |
| DuckDB         | Local analytical database                           |
| SQL            | Business-oriented data analysis                     |
| Tableau Public | Interactive dashboard and visualization             |
| GitHub         | Project version control and portfolio presentation  |

## Project Workflow

Raw Logistics Data
        ↓
Python / Pandas
        ↓
Data Cleaning & Validation
        ↓
Exploratory Data Analysis
        ↓
Correlation & Statistical Analysis
        ↓
DuckDB
        ↓
SQL Business Analysis
        ↓
KPI Tables
        ↓
Tableau Public
        ↓
Interactive Operations Dashboard

## Key KPIs

### The analysis focuses on:

Total shipments
Total backlog
Backlog rate
Warehouse utilization
Productivity
Error rate
On-time delivery
High-pressure periods

## Key Findings

### * Warehouse backlog concentration

* Warehouse performance differs substantially across the network.

| **Warehouse** | **Shipments** | **Backlog** | **Backlog Rate** |
| ------------------- | ------------------- | ----------------- | ---------------------- |
| WH03                | 9.41M               | 439K              | 2.93%                  |
| WH05                | 8.04M               | 379K              | 2.91%                  |
| WH04                | 10.20M              | 219K              | 1.29%                  |
| WH01                | 11.27M              | 197K              | 1.00%                  |
| WH02                | 13.46M              | 173K              | 0.72%                  |

WH03 and WH05 have the highest backlog rates, while WH02 handles the largest shipment volume with the lowest backlog rate.

This suggests that **volume alone does not explain backlog performance.**

### * Utilization and backlog

* Pearson correlation:

**r ≈ 0.655**

This indicates a strong positive relationship between utilization and backlog in the analyzed data.

In operational terms:

Higher utilization tends to coincide with higher backlog.

This suggests that capacity pressure should be monitored before backlog becomes severe.

### * Utilization and on-time delivery

* Pearson correlation:

**r ≈ -0.634**

Higher utilization is associated with lower on-time delivery.

This does not prove that utilization directly causes late deliveries, but it indicates that periods of high utilization deserve closer operational monitoring.

### * Backlog and on-time delivery

* Pearson correlation:

**r ≈ -0.764**

This was the strongest relationship identified among the key operational KPIs.

Higher backlog is strongly associated with lower on-time delivery.

This indicates that backlog management is particularly important for protecting service performance.

### * High-pressure periods

High-pressure periods were identified using operational conditions involving elevated utilization and backlog.

The percentage of high-pressure periods differs considerably by warehouse:

| **Warehouse** | **High-Pressure Periods** | **High-Pressure Rate** |
| ------------------- | ------------------------------- | ---------------------------- |
| WH03                | 190                             | 17.35%                       |
| WH05                | 182                             | 16.62%                       |
| WH04                | 96                              | 8.77%                        |
| WH01                | 81                              | 7.40%                        |
| WH02                | 68                              | 6.21%                        |

WH03 and WH05 therefore appear to require the greatest attention when planning capacity and workload management.

### * Peak periods

Peak periods show a different operational profile from normal periods.

Peak periods have:

Higher shipment volume
Higher utilization
Higher backlog
Higher error rates
Lower on-time delivery
This suggests that capacity planning becomes particularly important during periods of elevated demand.

### * Monthly pattern

December represents the most significant period of operational pressure in the monthly analysis, with substantially higher shipment volume and utilization accompanied by elevated backlog and lower on-time delivery.

This highlights the importance of preparing capacity and staffing for predictable seasonal demand.

Operational Recommendations

**Prioritize WH03 and WH05**
WH03 and WH05 have the highest backlog rates and the highest frequency of high-pressure periods.

Recommended actions:

Review staffing levels
Review shift allocation
Investigate recurring bottlenecks
Monitor capacity before backlog accumulates
Compare processes against better-performing warehouses

**2. Use early-warning capacity monitoring**
Because utilization and backlog have a strong positive relationship, utilization can be used as an early-warning indicator.

Operations teams could monitor:

Utilization
      ↓
Capacity pressure
      ↓
Backlog growth
      ↓
Service risk
This enables intervention before service performance deteriorates significantly.

3. **Protect on-time delivery from backlog growth**
   The strongest correlation found was between backlog and on-time delivery.

Therefore, backlog should not only be treated as a warehouse-efficiency KPI.

It should also be treated as a service-risk indicator.

4. **Prepare specifically for peak periods**

Peak periods show increased operational pressure.

Capacity planning should therefore consider:

Expected shipment volume
Staffing requirements
Warehouse capacity
Shift allocation
Historical peak-period performance

**5. Investigate warehouse-shift combinations**
The analysis shows that performance differs across both warehouses and shifts.

Instead of asking only:

“Which warehouse is underperforming?”

operations teams should ask:

“Which warehouse-shift combinations repeatedly experience capacity pressure?”

This can help identify more targeted operational interventions.

## Tableau Dashboard

**Interactive Dashboard**
[View the Logistics Operations Dashboard]() [(https://public.tableau.com/authoring/OperationPerform/Dashboard2/Logistics_Operations_Performance#1)](%5Bpublic.tableau.com/authoring/OperationPerform/Dashboard2/Logistics_Operations_Performance#1%5D(https://public.tableau.com/authoring/OperationPerform/Dashboard2/Logistics_Operations_Performance#1))

The dashboard provides:

Executive KPI cards
Warehouse backlog comparison
Utilization vs on-time delivery analysis
Monthly operational trends
High-pressure warehouse analysis
Operational exception table
Warehouse and shift filters

## Dashboard Preview


```Markdown
![Tableau Dashboard](/Volumes/DATA/logist/Logistics_Operation_Dashboard.png)
```


## SQL Analysis

DuckDB was used as a local analytical database.

The SQL analysis includes:

* Warehouse KPI analysis
* Shift performance analysis
* Monthly trends
* High-pressure period identification
* Operational exception detection
* Warehouse/shift comparisons

**Example analytical questions:**

-- Which warehouses have the highest backlog?

-- Which shifts have the highest productivity?

-- Which months have the highest operational pressure?

-- Which warehouse-shift combinations have the
-- greatest backlog?

-- Which periods exceed capacity?

-- How frequently does each warehouse experience
-- high-pressure conditions?

## Statistical Analysis

Pearson correlation was used to evaluate relationships between operational KPIs.

Key relationships:


| **Relationship**           | **Pearson r** | **Interpretation** |
| -------------------------------- | ------------------- | ------------------------ |
| Backlog vs On-Time Delivery      | -0.764              | Strong negative          |
| Utilization vs Backlog           | 0.655               | Strong positive          |
| Productivity vs Backlog          | 0.638               | Strong positive          |
| Utilization vs On-Time Delivery  | -0.634              | Strong negative          |
| Productivity vs On-Time Delivery | -0.586              | Moderate negative        |
| Utilization vs Error Rate        | 0.530               | Moderate positive        |

Correlation results were interpreted as **associations rather than causal relationships.**

## Project Structure


```
logist/
│
├── data/
│   ├── raw/
│   |   ├── operations_complete.csv
│   |   ├── opr_skeletion.csv
│   |   ├── shifts.csv
│   |   ├── products.csv
│   |   └── warehouses.csv
│   └── processed/
│       ├── cleaned_oper.csv
│       ├── final_analysis_summary.csv
│       ├── kpi_summary.csv
│       ├── high_pressure_by_warehouse.csv
│       ├── warehouse_kpi.csv
│       ├── shift_kpi.csv
│       ├── monthly_kpi.csv
│       ├── high_pressure_by_warehouse.csv
│       └── warehouse_dashboard.csv
│
├── notebooks/
│       ├── data_analysis.ipynb
│       ├── Logistic_opr.ipynb
│       ├── sql.ipynb.csv
│       └──sql/
│     		├── oper_analysis.ipynb
│       	└── logistics.duckdb
│
├── README.md
│
└── Logistics Operation Dashboard.png
```

---

## Skills Demonstrated

### Data Analytics

* Data cleaning
* Data validation

* Exploratory data analysis
* Aggregation

* KPI development
* Correlation analysis

* Statistical interpretation

### SQL

* GROUP BY
* CASE statements
* Aggregations
* Conditional logic
* Window/analytical thinking
* Operational KPI calculations
* Exception identification

### Business Intelligence

* Dashboard design
* KPI visualization
* Interactive filtering
* Operational reporting
* Exception reporting
* Business storytelling

### Business Analysis

* Capacity analysis
* Backlog analysis
* Service-level analysis
* Peak-period analysis
* Warehouse benchmarking
* Operational risk identification

### Business Impact

The analysis demonstrates how operational data can be transformed into actionable insights.

Instead of simply reporting:

“Warehouse utilization is high.”

the analysis connects multiple operational indicators:

High Utilization
       +
Backlog Growth
       ↓
Operational Pressure
       ↓
Potential Service Impact
       ↓
Targeted Intervention
This approach helps operations teams move from **descriptive reporting** toward **proactive operational management.**

## Conclusion

The project demonstrates an end-to-end approach to logistics analytics, combining **Python, statistical analysis, DuckDB, SQL and Tableau.**

The analysis identifies WH03 and WH05 as the warehouses requiring the closest attention due to their higher backlog rates and frequency of high-pressure periods.

The strongest relationship observed was between backlog and on-time delivery, highlighting backlog management as an important component of service performance.

The resulting Tableau dashboard converts these findings into an interactive operational reporting tool that can be used to explore warehouse, shift and period-level performance.

## Author

R Uma Sirishamai 

Data Analyst / Aspiring Operations

Skills: Python · SQL · DuckDB · Tableau · Data Analytics · Logistics Operations
