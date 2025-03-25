HR_analysis
================
Tavish King
2025-03-14

## Introduction

- What is employee attrition?
- Why it is important?
- Project Scope:
  - discover and interpret the factors that affect employee attrition
  - build a machine learning model to better predict the type of
    employee who is more likely to quit.

### Data Source

- include link to data and background of data
- include codebook reference for hr_attrition_transformed

### Data Context

``` sql
```

``` r
# Load necessary packages

library(tidyverse)  #for data wrangling and visualization
library(gtsummary)  #for tables
library(caret)      #for model evaluation
library(car)        #for checking multicollinearity
library(ROCR)       #for ROC curve
library(corrplot)   #for correlation matrix
```
