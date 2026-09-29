SELECT *
FROM dbo.NashvilleHousing;

-- Standardize Date Format

Select  SaleDateConverted, Convert(Date,SaleDate)
From dbo.NashvilleHousing

Alter Table NashvilleHousing
Add SaleDateConverted Date 

Update NashvilleHousing
Set SaleDateConverted = Convert(Date,SaleDate)

-- Populate Property Address Data

Select *
From dbo.NashvilleHousing
Order By ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, Isnull(a.PropertyAddress, b.PropertyAddress)
From dbo.NashvilleHousing a
Join dbo.NashvilleHousing b
	on a.parcelID = b.parcelID
	And a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is null

Update a
Set PropertyAddress = Isnull(a.PropertyAddress, b.PropertyAddress)
From dbo.NashvilleHousing a
Join dbo.NashvilleHousing b
	on a.parcelID = b.parcelID
	And a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)

Select
SUBSTRING(PropertyAddress,1,charindex(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,charindex(',', PropertyAddress)+1, Len(PropertyAddress)) as Address
From dbo.NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(225) 

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress,charindex(',', PropertyAddress)+1, Len(PropertyAddress))

Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(225) 

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1,charindex(',', PropertyAddress)-1)

Select 
Parsename(Replace(OwnerAddress, ',', '.') , 3),
Parsename(Replace(OwnerAddress, ',', '.') , 2),
Parsename(Replace(OwnerAddress, ',', '.') , 1)
From dbo.NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(225) 

Update NashvilleHousing
Set OwnerSplitAddress = Parsename(Replace(OwnerAddress, ',', '.') , 3)

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(225) 

Update NashvilleHousing
Set OwnerSplitCity = Parsename(Replace(OwnerAddress, ',', '.') , 2)

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(225) 

Update NashvilleHousing
Set OwnerSplitState = Parsename(Replace(OwnerAddress, ',', '.') , 1)

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From dbo.NashvilleHousing
Group By SoldAsVacant
Order By 2

Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
From dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End

-- Remove Duplicates

With RowNumCTE As(
Select *,
	Row_number () Over (
	Partition By 
				 ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order By
				 UniqueID 
				 ) row_num
From dbo.NashvilleHousing
)
Delete
From RowNumCTE
Where row_num >1

-- Delete Unused Columns

Select *
From dbo.NashvilleHousing

Alter Table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

