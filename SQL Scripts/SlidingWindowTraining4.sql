--Creating Orders Staging table
CREATE TABLE Orders_Staging (
OrderID INT IDENTITY NOT NULL,
OrderDate DATETIME NOT NULL,
CustomerID INT NOT NULL, 
OrderStatus CHAR(1) NOT NULL DEFAULT 'P',
ShippingDate DATETIME
);
Go

ALTER TABLE Orders_Staging ADD CONSTRAINT PK_Orders_Work PRIMARY KEY Clustered (OrderID, OrderDate)
ON OrderPartitionScheme (OrderDate);
Go

Execute dbo.PartitionDetails
Go