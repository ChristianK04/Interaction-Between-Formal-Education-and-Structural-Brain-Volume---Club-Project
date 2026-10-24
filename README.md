# Interaction Between Formal Education and Structural Brain Atrophy in Alzheimer's Disease
## Project Overview
This repository contains a multi-stage statistical data analysis workflow written in R designed to evaluate the **Cognitive Reserve Hypothesis**. Using secondary quantitative data from the Open Access Series of Imaging Studies (OASIS) dataset ($N = 350$), this project models how years of formal educational attainment correlate with Normalized Whole Brain Volume (nWBV) and tests whether education serves as a structural buffer against progressive brain atrophy across diverse clinical cohorts.

### Leadership & Mentorship Role
* **Project Mentor / Data Lead:** Actively managed and guided a 5-person student research cohort within the **Mount Royal University Research Mentorship Club**.
* **Technical Oversight:** Architected the data cleaning pipeline, standardized categorical data filtering methodologies, and coached team members on interpreting Two-Way ANOVA interaction models and multivariate regressions.

---

## Data Pipeline & Script Architecture
The computational workflow is broken down into structured scripts to ensure complete modularity and transparency:

* **`01_Data_Cleaning.R`**: Environment initialization, library dependencies management (`readxl`, `ggplot2`), clearing null data states (`na.omit`), and casting experimental classifications into categorical R factors.
* **`02_lifespan_atrophy_analysis.R`**: Maps continuous baseline linear regressions to track structural brain volume decline across a lifespan spanning ages 18–96.
* **`03_dementia_cognitive_scores.R`**: Statistical subsetting and distribution benchmarking of Mini-Mental State Examination (MMSE) scores relative to Clinical Dementia Ratings (CDR).
* **`04_socioeconomic_status_regression.R`**: Linear model evaluates correlation vectors between external socioeconomic status factors (SES) and absolute cognitive outcomes.
* **`05_education_interaction_anova.R`**: Executes the high-level inferential engine—a Two-Way ANOVA assessing the definitive interaction effect ($Clinical\ Diagnosis \times Years\ of\ Education$) on physical brain volume.

---

## Core Statistical Findings
* **The Atrophy Gap:** One-Way ANOVA confirmed a highly significant, physical reduction in baseline normalized whole-brain volume in demented individuals relative to healthy aging controls ($p < 0.001, \eta^2 = 0.101$).
* **The Interaction Effect:** Two-Way ANOVA modeling confirmed a significant structural interaction between formal education metrics and absolute clinical diagnosis status ($p = 0.0115, \eta^2 = 0.067$). 
* **The Takeaway:** These variations in regression slopes validate the Cognitive Reserve framework, indicating that higher early-life formal educational attainment tracks with enhanced structural brain resilience against clinical symptoms of neurodegeneration.

---

## Tech Stack & Methodology
* **Language:** R (RStudio environment)
* **Core Libraries:** `ggplot2` (Grammar of Graphics rendering), `readxl` (Data manipulation)
* **Statistical Methods:** Ordinary Least Squares (OLS) Linear Regression, One-Way Analysis of Variance (ANOVA), Two-Way Interaction ANOVA, Tukey Honest Significant Difference (HSD) Post-Hoc Analysis.
