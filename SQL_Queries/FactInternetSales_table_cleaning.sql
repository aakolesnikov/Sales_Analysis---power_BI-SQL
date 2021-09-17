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
