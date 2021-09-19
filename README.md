# Sales Analysis Portfolio Project
<img src = "https://github.com/aakolesnikov/Sales_Analysis---power_BI-SQL/blob/9d71c29c0f622ef947339fbdf97643e3f160f5bf/pictures/collage.png">


# Business Request & User Stories
The main request was an executive sales report for sales management team. Power BI dashboard was created condisering several user's stories:

1) "Follow up my customers that buys the most and who we can sell more to" --- filtering data by customers
2) "Follow up my products which sells the most" --- filtering data by product 
3) "Folow sales over time against budget" --- graphs and KPIs comparing against budget

# Data Cleaning & Transformation (SQL)
Following tables were extracted using SQL in order to create data model fulfilling the business needs and analysis purposes. Sales budgets data were provided in Excel format and connected to the data model further.

SQL queries for cleaning and transformation necessary data are represented below:

#### DIM_Calendar:
```SQL
-- Cleaning DimDate table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  -- [DayNumberOfWeek], 
  [EnglishDayNameOfWeek] AS Day, 
  -- [SpanishDayNameOfWeek], 
  -- [FrenchDayNameOfWeek], 
  -- [DayNumberOfMonth], 
  -- [DayNumberOfYear], 
  [WeekNumberOfYear] AS WeekNr, 
  [EnglishMonthName] AS Month, 
  LEFT([EnglishMonthName], 3) AS MonthShort, 
  -- [SpanishMonthName], 
  -- [FrenchMonthName], 
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year -- [CalendarSemester], 
  -- [FiscalQuarter], 
  -- [FiscalYear], 
  -- [FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate] 
WHERE 
  CalendarYear >= 2019
```
#### DIM_Customer
```SQL
-- Cleaning DimCustomer table -- 
SELECT 
  c.customerkey AS [CustomerKey], 
  -- [GeographyKey], 
  -- [CustomerAlternateKey], 
  -- [Title], 
  c.firstname AS [FirstName], 
  -- [MiddleName], 
  c.lastname AS [LastName], 
  c.firstname + ' ' + c.lastname AS [Full Name], --- combining first and last name
  -- [NameStyle], 
  -- [BirthDate], 
  -- [MaritalStatus], 
  -- [Suffix], 
  CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  -- [EmailAddress], 
  -- [YearlyIncome], 
  -- [TotalChildren], 
  -- [NumberChildrenAtHome], 
  -- [EnglishEducation], 
  -- [SpanishEducation], 
  -- [FrenchEducation], 
  -- [EnglishOccupation], 
  -- [SpanishOccupation], 
  -- [FrenchOccupation], 
  -- [HouseOwnerFlag], 
  -- [NumberCarsOwned], 
  -- [AddressLine1], 
  -- [AddressLine2], 
  -- [Phone], 
  c.datefirstpurchase AS [DateFirstPurchase], 
  -- [CommuteDistance]
  g.city AS [CustomerCity] -- joined [CustomerCity] from Geography Table
FROM 
  dbo.DimCustomer AS c
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey
ORDER BY 
  CustomerKey ASC --- ordering list by [CustomerKey]
```

#### DIM_Product:
```SQL
-- Cleaning DimProduct table -- 
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  -- [ProductSubcategoryKey], 
  -- [WeightUnitMeasureCode], 
  -- [SizeUnitMeasureCode], 
  p.[EnglishProductName] AS [Product Name],
  ps.EnglishProductSubcategoryName AS [Sub Category], --- joined from DimProductSubcategory
  pc.EnglishProductCategoryName AS [Category], --- joined from DimProductCategory
  -- [SpanishProductName], 
  -- [FrenchProductName], 
  -- [StandardCost], 
  -- [FinishedGoodsFlag], 
  p.[Color] AS [Product Color],
  -- [SafetyStockLevel], 
  -- [ReorderPoint], 
  -- [ListPrice], 
  p.[Size] AS [Product Size], 
  -- [SizeRange], 
  -- [Weight], 
  -- [DaysToManufacture], 
  p.[ProductLine] AS [Product Line], 
  -- [DealerPrice], 
  -- [Class], 
  -- [Style], 
  p.[ModelName] AS [Product Model Name], 
  -- [LargePhoto], 
  p.[EnglishDescription] AS [Product Description], 
  -- [FrenchDescription], 
  -- [ChineseDescription], 
  -- [ArabicDescription], 
  -- [HebrewDescription], 
  -- [ThaiDescription], 
  -- [GermanDescription], 
  -- [JapaneseDescription], 
  -- [TurkishDescription], 
  -- [StartDate], 
  -- [EndDate], 
  ISNULL (p.[Status], 'Outdated') AS [Product Status]
FROM 
  dbo.DimProduct AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
  p.ProductKey ASC
```

#### FACT_InternetSales:
```SQL
-- Cleaning FactInternetSales table --
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  -- [PromotionKey], 
  -- [CurrencyKey], 
  -- [SalesTerritoryKey], 
  [SalesOrderNumber], 
  -- [SalesOrderLineNumber], 
  -- [RevisionNumber], 
  -- [OrderQuantity], 
  -- [UnitPrice], 
  -- [ExtendedAmount], 
  -- [UnitPriceDiscountPct], 
  -- [DiscountAmount], 
  -- [ProductStandardCost], 
  -- [TotalProductCost], 
  [SalesAmount]
  -- [TaxAmt], 
  -- [Freight], 
  -- [CarrierTrackingNumber], 
  -- [CustomerPONumber], 
  -- [OrderDate], 
  -- [DueDate], 
  -- [ShipDate],
FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) - 2 --- controlling on having only 2 years back in time for analysis 
ORDER BY 
OrderDateKey ASC 
```
# Data Model
Data model screenshot can be seen below. 

All of the data were loaded to Power BI --- FACT_Budget and FACT_InternetSales were connected to all of the necessary DIM tables.



