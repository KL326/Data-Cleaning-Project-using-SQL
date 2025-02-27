/*
DATA CLEANING SCRIPT FOR NASHVILLE HOUSING DATASET
This script performs various data cleaning tasks including standardizing formats, populating missing values, splitting fields, and removing duplicates.
*/

-- STEP 1: Standardize Date Format

-- Add a new column for standardized sale dates
ALTER TABLE PortfolioProject..NashvilleHousing
ADD SaleDateConverted DATE;

-- Update the new column with converted date values
UPDATE PortfolioProject..NashvilleHousing
SET SaleDateConverted = CONVERT(DATE, SaleDate);


-- STEP 2: Populate Missing Property Address Data

-- Identify rows with missing PropertyAddress
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,
       ISNULL(a.PropertyAddress, b.PropertyAddress) AS ResolvedAddress
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
  ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

-- Update missing PropertyAddress values
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
  ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


-- STEP 3: Break Out Address into Individual Columns

-- Add new columns for Address and City components
ALTER TABLE PortfolioProject..NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255),
    PropertySplitCity NVARCHAR(255);

-- Update new columns with split values
UPDATE PortfolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
    PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Add new columns for Owner Address components (Address, City, State)
ALTER TABLE PortfolioProject..NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255),
    OwnerSplitCity NVARCHAR(255),
    OwnerSplitState NVARCHAR(255);

-- Update new columns with split values from OwnerAddress
UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);


-- STEP 4: Standardize "Sold as Vacant" Field

-- Convert "Y" and "N" values to "Yes" and "No"
UPDATE PortfolioProject..NashvilleHousing
SET SoldAsVacant = CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;

-- Verify changes
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2;


-- STEP 5: Remove Duplicate Records

-- Identify duplicate rows using ROW_NUMBER()
WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM PortfolioProject..NashvilleHousing
)

-- Delete duplicate rows
DELETE FROM PortfolioProject..NashvilleHousing
WHERE UniqueID IN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
);


-- STEP 6: Delete Unused Columns

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate;

-- Final verification
SELECT *
FROM PortfolioProject..NashvilleHousing;
