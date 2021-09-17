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
