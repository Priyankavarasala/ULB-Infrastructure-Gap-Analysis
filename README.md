# ULB Infrastructure Gap Analysis

SQL + Tableau analysis of 10,000 urban local body (ULB) infrastructure projects in Andhra Pradesh, identifying where cost and schedule performance actually break down — and fixing real data-quality issues along the way.

## Business Problem

Municipal leadership needed a clear view of why infrastructure projects (roads, drains, school upgrades, and related works funded through convergence schemes) were falling behind schedule, and whether the root cause was **cost overrun** or **execution delay**. Prior reporting bundled every funding source together, masking where the actual bottleneck was.

## Dataset

- **10,000** infrastructure project records
- Fields: project ID, funding source, budget allocated, budget utilized, sanction date, target completion date, actual completion date, contractor name, project status
- Source: municipal infrastructure records (anonymized/aggregated for this project)

## Tools

| Stage | Tool |
|---|---|
| Data cleaning & transformation | SQL (MySQL) |
| Analysis | SQL (CTEs, window functions) |
| Visualization | Tableau |
| Reporting | PowerPoint (executive summary deck) |

## Data Quality Issues Found & Fixed

Before any analysis, three real data-quality problems had to be resolved:

1. **Blank-date miscalculation** — missing completion dates were initially causing delay calculations to default to 0 or throw errors; these were isolated and excluded from delay averages rather than silently miscounted.
2. **Inconsistent contractor naming** — the same contractor appeared under multiple spelling/casing variants (e.g. trailing spaces, inconsistent capitalization), which fragmented aggregation. Fixed with `TRIM()` and `UPPER()` normalization.
3. **NULL vs. empty-string filtering** — some fields stored missing values as empty strings (`''`) rather than `NULL`, which silently passed default filters and skewed counts. Explicit `NULLIF()` / empty-string checks were added.

## Methodology

1. **Extraction & staging** — loaded raw project records into a staging table.
2. **Cleaning** — applied the fixes above plus standard type casting (dates, currency).
3. **Analysis (SQL)** — used CTEs to segment projects by funding source and status, then window functions (`DENSE_RANK()`) to rank contractor cost performance and delay patterns within each funding source.
4. **Visualization (Tableau)** — built an interactive dashboard to let stakeholders filter by district, funding source, and contractor.
5. **Reporting** — packaged the findings into an executive-ready PowerPoint deck.

## Key Findings

- **Cost is not the core problem.** Completed projects finish *under* budget across every funding source, with average variance ranging from **-0.6% to -1.9%**.
- **Schedule is the real bottleneck.** Average delay stays consistently around **14–15 days** regardless of funding source — pointing to an execution/timeline issue rather than a budgeting one.
- This reframes the leadership conversation from "why are we overspending" to "why do projects consistently slip by two weeks."

## Repository Structure

├── Infrastructure Projects Gap Analysis.pptx   # executive summary deck
├── Infrastructure Projects Gap Analysis.twbx   # interactive Tableau dashboard
├── Infrastructure_Projects_Gap_Analysis.sql    # cleaning, CTEs, window functions
├── Infrastructure_Projects_Insights.xlsx       # supporting Excel breakdowns & pivot summaries
└── README.md

## Dashboard Preview

<img width="1920" height="1080" alt="Screenshot (164)" src="https://github.com/user-attachments/assets/95771631-eb3f-479d-9358-108342909ffa" />


## Author

**Varasala Priyanka**
[LinkedIn](https://linkedin.com/in/priyanka-varasala) · [GitHub](https://github.com/Priyankavarasala)
