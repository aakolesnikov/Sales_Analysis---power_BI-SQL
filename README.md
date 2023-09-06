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
  [EnglishDayNameOfWeek] AS Day, 
  [WeekNumberOfYear] AS WeekNr, 
  [EnglishMonthName] AS Month, 
  LEFT([EnglishMonthName], 3) AS MonthShort, 
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year -- [CalendarSemester], 
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
  c.firstname AS [FirstName], 
  c.lastname AS [LastName], 
  c.firstname + ' ' + c.lastname AS [Full Name], --- combining first and last name
  CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  c.datefirstpurchase AS [DateFirstPurchase], 
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
  p.[EnglishProductName] AS [Product Name],
  ps.EnglishProductSubcategoryName AS [Sub Category], --- joined from DimProductSubcategory
  pc.EnglishProductCategoryName AS [Category], --- joined from DimProductCategory
  p.[Color] AS [Product Color],
  p.[Size] AS [Product Size], 
  p.[ProductLine] AS [Product Line],  
  p.[ModelName] AS [Product Model Name], 
  p.[EnglishDescription] AS [Product Description],  
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
  [SalesOrderNumber], 
  [SalesAmount]
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

<img src = "https://github.com/aakolesnikov/Sales_Analysis---power_BI-SQL/blob/501c35dde7a1d14bcc586ecbf9d48342f89737b7/pictures/Data_Model.png">

# Sales Management Dashboard
Final sales management dashboard contains an overview page and two other pages representing necessary details and visualizations such as sales over time, per customers and per products.

https://user-images.githubusercontent.com/90852362/133932130-102f190e-b748-45b6-a695-155fd06b2414.mov


