# Agriculture Climate and Crop Yield Analysis

## 1. Project Overview
This project focuses on analyzing the relationship between climate conditions and agricultural crop yields using R programming.

It explores how annual rainfall, average temperature, pesticide usage, crop type, country, and year influence agricultural productivity.

## 2. Objectives
- Analyze crop yield across different countries.
- Study the relationship between rainfall and crop yield.
- Understand the impact of temperature on crop productivity.
- Compare average yields of different crops.
- Identify crop yield trends over the years.
- Perform correlation analysis.
- Clean and export the dataset for further analysis.

## 3. Technologies Used
- Programming Language: R
- Libraries: tidyverse
- Data Manipulation: dplyr, tidyr
- Data Visualization: ggplot2
- Data Import/Export: readr

## 4. Dataset Description

**Dataset Name:** agriculture_climate_yield_tableau_2.csv

Important attributes:

| Column | Description |
|---|---|
| Country | Country name |
| Crop | Type of crop |
| Year | Year of production |
| Annual_Rainfall_mm | Annual rainfall in millimeters |
| Avg_Temperature_C | Average temperature in Celsius |
| Pesticides_tonnes | Pesticides used in tonnes |
| Yield_kg_per_ha | Crop yield in kg per hectare |
| Yield_hg_per_ha | Crop yield in hectograms per hectare |

## 5. Data Analysis Performed

### A. Data Exploration
- Inspected dataset structure using glimpse().
- Checked missing values.
- Counted unique countries and crop types.
- Identified the year range.
- Checked duplicate records.
- Verified yield unit conversion.

### B. Statistical Analysis
Calculated:
- Average annual rainfall.
- Average temperature.
- Average crop yield.
- Mean and median yield for each crop.
- Minimum and maximum yield.
- Total yield aggregated by crop.

### C. Crop Yield Trend Analysis
- Grouped crop yields by crop and year.
- Calculated average annual yield.
- Compared yields between 1990 and 2013.
- Calculated percentage change in yield.

### D. Climate-Based Analysis
- Grouped rainfall into different ranges.
- Grouped temperatures into different ranges.
- Calculated average yield for each range.

### E. Correlation Analysis
Calculated correlations between:
- Crop yield and annual rainfall.
- Crop yield and average temperature.
- Crop yield and pesticide usage.

Correlation analysis was performed separately for each crop.

## 6. Data Visualization

Created visualizations using ggplot2.

### 1. Crop Yield Trend Over Time
- Line chart showing average crop yield across different years.
- Different colours represent different crop types.
- Output: yield_trend.png

### 2. Rainfall vs Crop Yield
- Scatter plot showing the relationship between annual rainfall and crop yield.
- Different colours represent different crop types.
- Output: rainfall_vs_yield.png

## 7. Data Cleaning
- Checked missing values.
- Identified duplicate records.
- Removed duplicate rows using distinct().
- Exported the cleaned dataset.

Cleaned Dataset: agriculture_climate_yield_clean.csv

## 8. Project Files

| File Name | Description |
|---|---|
| agriculture_climate_yield_tableau_2.csv | Original dataset |
| agriculture_climate_yield_clean.csv | Cleaned dataset |
| agriculture_analysis.R | R source code |
| yield_trend.png | Crop yield trend graph |
| rainfall_vs_yield.png | Rainfall vs yield graph |

## 9. How to Run the Project

1. Install R and RStudio.
2. Install the required package:

```r
install.packages("tidyverse")
