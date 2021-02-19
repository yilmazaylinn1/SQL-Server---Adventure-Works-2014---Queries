/****** Script for SelectTopNRows command from SSMS  ******/

 --create table sorgusu (Query 1)

 CREATE TABLE dbo.studentt
(
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
 emailadress VARCHAR(30) NOT NULL,
  department VARCHAR(30) NOT NULL,
  school VARCHAR (50) NOT NULL,
  City VARCHAR (20) NOT NULL,
  SchoolNumber INT NOT NULL,
  ExamScore INT NOT NULL,
  GENDER VARCHAR(10) NOT NULL,
)

-- ADD PRÝMARY KEY (Query2)

ALTER TABLE dbo.studentt
  ADD CONSTRAINT PK_studentt
  PRIMARY KEY(City) 

  --ADD Constraint (Query3)
  ALTER TABLE dbo.studentt
  ADD CONSTRAINT CHK_note
  CHECK(ExamScore > 0)

  	--between and or sorgusu (Query4)
SELECT  [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [Production].[Product]
  WHERE(ListPrice between 7 and 14) And 
    (ProductID >800)or 
(ProductModelID)< 112

--Between =! > sorgusu (Query5)

  SELECT [ProductID]
      ,[StartDate]
      ,[EndDate]
      ,[StandardCost]
      ,[ModifiedDate]
  FROM [Production].[ProductCostHistory]
  WHERE(StandardCost between 3 and 13) And
  (ProductID)> 700 and 
 (StandardCost)!= 9

  --and or ýn order sorgusu  (Query6)
  SELECT [ProductID]
      ,[BusinessEntityID]
      ,[AverageLeadTime]
      ,[StandardPrice]
      ,[LastReceiptCost]
      ,[LastReceiptDate]
      ,[MinOrderQty]
      ,[MaxOrderQty]
      ,[OnOrderQty]
      ,[UnitMeasureCode]
      ,[ModifiedDate]
  FROM [Purchasing].[ProductVendor]
  WHERE(LastReceiptCost > 40 and StandardPrice < 50) AND
 (ProductID >300 or AverageLeadTime < 17 ) AND
(UnitMeasureCode IN ( 'GAL'))
  ORDER BY MinOrderQty DESC 


  --OR NOT IN ORDER Sorgusu (Query7)

SELECT  [PurchaseOrderID]
      ,[PurchaseOrderDetailID]
      ,[OrderQty]
      ,[ProductID]
      ,[UnitPrice]
      ,[StockedQty]
      ,[ModifiedDate]
  FROM [Purchasing].[PurchaseOrderDetail]
  WHERE(UnitPrice < 30 or OrderQty > 500) AND
 (OrderQty NOT IN ('550'))

 --ýn group by sorgusu (Query8)

  SELECT [BusinessEntityID]
      ,[AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
      ,[ModifiedDate]
  FROM [Purchasing].[Vendor]
  WHERE(CreditRating IN ('1'))
  GROUP BY BusinessEntityID, AccountNumber, CreditRating, PreferredVendorStatus,
  ActiveFlag, PurchasingWebServiceURL, ModifiedDate, Name

-- NOT IN GROUP BY HAVING Sorgusu (Query9)
SELECT  COUNT(DISTINCT(LocationID))
      ,[Name]
      ,[CostRate]
      ,[Availability]
      ,[ModifiedDate]
  FROM [Production].[Location]
  WHERE(CostRate NOT IN('0'))
  GROUP BY CostRate, Name, Availability,ModifiedDate
  HAVING COUNT(DISTINCT(LocationID)) > 0

   -- between and != like sorgusu (Query10)
	SELECT  [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate]
FROM [Production].[Product]
WHERE Name LIKE '%ML%' And
(StandardCost between 12 and 50) And
        (MakeFlag != 0)
		
-- or ýn <= group by having not like sorgusu(Query11)

SELECT  COUNT(DISTINCT(ProductID))
      ,[ProductNumber]
      ,[MakeFlag]  
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
  FROM [Production].[Product]
  WHERE(MakeFlag IN ('1')) AND
  (StandardCost > 90 or ListPrice <= 150) AND
 (StandardCost NOT LIKE ('91'))
  GROUP BY ProductNumber,MakeFlag,StandardCost,ListPrice,Size
  HAVING COUNT(*) > 300
	 
--ýnner join sorgusu (Query12)

SELECT [AddressTypeID], [BusinessEntityID]
FROM[Person].[AddressType] JOIN [Person].[BusinessEntity]
ON AddressTypeID = BusinessEntityID

-- like inner join sorgusu (Query13)

SELECT [AddressTypeID], [BusinessEntityID], [Name]
FROM[Person].[AddressType] JOIN [Person].[BusinessEntity]
ON AddressTypeID = BusinessEntityID
WHERE AddressTypeID LIKE '%1'

--inner join case when sorgusu (Query14)

SELECT [AddressTypeID], [BusinessEntityID]
CASE
     WHEN 1 > AdressTypeID THEN 1
	 WHEN AdressTypeID > 1 THEN 2
	 ELSE 0
	 END AS 'DEÐER'
FROM[Person].[AddressType] JOIN [Person].[BusinessEntity]
ON AddressTypeID = BusinessEntityID

-- and != <= not like inner join (Query15)

SELECT BusinessEntityID, AverageLeadTime,StandardPrice,PurchaseOrderID,UnitPrice,LineTotal
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID
WHERE(AverageLeadTime > 17 AND UnitPrice NOT LIKE '%9') AND
 (PurchaseOrderID != 1578)

 --Between != > order inner join sorgusu (Query16)

 SELECT BusinessEntityID, AverageLeadTime,StandardPrice,PurchaseOrderID,UnitPrice,LineTotal
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID
WHERE(AverageLeadTime BETWEEN 17 AND 20) AND
 (PurchaseOrderID != 1578) AND
 (LineTotal > 500)
 ORDER BY BusinessEntityID ASC

 --2. inner join sorgusu (Query17)

 SELECT BusinessEntityID, AverageLeadTime,StandardPrice,PurchaseOrderID,UnitPrice,LineTotal
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID

--AND IN > GROUP BY Ýnner join sorgusu (Query18)

SELECT BusinessEntityID, AverageLeadTime,StandardPrice,PurchaseOrderID,UnitPrice,LineTotal
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID
WHERE(AverageLeadTime > 17) AND
(BusinessEntityID IN ('1578'))
GROUP BY BusinessEntityID, AverageLeadTime, StandardPrice,PurchaseOrderID,UnitPrice,LineTotal

-- != <= having not like inner join (Query19)

SELECT COUNT(BusinessEntityID),AverageLeadTime,StandardPrice,PurchaseOrderID, UnitPrice
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID
WHERE (AverageLeadTime > 17 AND UnitPrice NOT LIKE '%9')
 (PurchaseOrderID != 1578)
 GROUP BY AverageLeadTime, StandardPrice, PurchaseOrderID, UnitPrice
 HAVING COUNT(BusinessEntityID ) > 1600

 --order group by having like not like ,inner join if sorgusu (Query20)

 DECLARE @Sayi INT; 
SELECT @Sayi = COUNT(*) FROM Purchasing.PurchaseOrderDetail
IF @Sayi > 30000 BEGIN
PRINT '30 binden fazla kayýt var';
END
ELSE BEGIN
PRINT '30 binden az kayýt var';
END;
 SELECT COUNT(BusinessEntityID),AverageLeadTime,StandardPrice,PurchaseOrderID, UnitPrice
FROM Purchasing.ProductVendor JOIN Purchasing.PurchaseOrderDetail
ON BusinessEntityID = PurchaseOrderID
WHERE (AverageLeadTime > 17 AND UnitPrice NOT LIKE '%9')
 (PurchaseOrderID != 1578) AND
 (LineTotal IN ('551'))
 GROUP BY AverageLeadTime, StandardPrice, PurchaseOrderID, UnitPrice
 HAVING COUNT(BusinessEntityID ) > 1600




 










  
  
  
 

    
  