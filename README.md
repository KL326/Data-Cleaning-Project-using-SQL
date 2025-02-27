# 🏡 Nashville Housing Data Cleaning Project

Welcome to the **Nashville Housing Data Cleaning Project**! This project focuses on cleaning and preprocessing the **Nashville Housing Dataset** using SQL. 🏠📊

---

## 🚀 Project Overview

This project involves cleaning raw housing data to improve consistency and usability. The cleaning tasks include:
- Standardizing date formats 📅
- Filling in missing property addresses 🏡
- Splitting address fields for better usability 📍
- Standardizing categorical values 🔄
- Removing duplicate records 🚮
- Dropping unnecessary columns ❌

---

## 🔧 Tools and Techniques

- **SQL (Structured Query Language)**:  
  - 🛠️ *Data Cleaning*: Standardized formats, handled missing values, and ensured consistency.  
  - 🔍 *Data Transformation*: Split fields and standardized categorical data.  
  - 🚀 *Performance Optimization*: Removed redundant records and dropped unused columns.  

---

## 📂 Data Cleaning Steps

### 1️⃣ Standardizing Date Format
- Added a new column `SaleDateConverted` and converted date values into a standardized format.

### 2️⃣ Handling Missing Property Addresses
- Used `ParcelID` to fill in missing `PropertyAddress` values from other entries.

### 3️⃣ Splitting Address Fields
- Extracted `PropertyAddress` into `PropertySplitAddress` and `PropertySplitCity`.
- Extracted `OwnerAddress` into `OwnerSplitAddress`, `OwnerSplitCity`, and `OwnerSplitState`.

### 4️⃣ Standardizing "Sold as Vacant" Field
- Replaced 'Y' and 'N' with 'Yes' and 'No'.

### 5️⃣ Removing Duplicate Records
- Used `ROW_NUMBER()` to identify and delete duplicate rows.

### 6️⃣ Dropping Unnecessary Columns
- Removed `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, and `SaleDate` to optimize the dataset.

---

## 📌 Key Insights

1. **Data inconsistency**: Found and resolved missing or incorrect values in key fields.  
2. **Address structure**: Splitting addresses improved readability and usability.  
3. **Duplicate records**: Eliminated redundancy to ensure accurate analysis.  

---

## 🌟 How to Use This Project

1. Clone this repository:  
   ```sh
   git clone https://github.com/yourusername/nashville-housing-cleaning.git
   ```
2. Open the SQL script in a SQL Server environment.
3. Execute the script step by step to clean the dataset.

---


