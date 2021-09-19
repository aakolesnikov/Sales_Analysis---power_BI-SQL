# Sales Analysis Portfolio Project
<a href="https://ibb.co/2jqYD2G"><img src="https://i.ibb.co/rZkfCPD/summary.png" alt="summary" border="0"></a>

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
#### DIM_Calendar:
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
  c.firstname + ' ' + c.lastname AS [Full Name], --- combining first and lst name
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

