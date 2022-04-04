--Now that data has been moved from Orders to Orders_Staging, Purge old data
TRUNCATE table Orders_Staging
Go

Execute dbo.PartitionDetails
Go	