--Switch Partition #1 from dbo.Orders to dbo.Orders_Staging
ALTER TABLE Orders SWITCH PARTITION 1 TO Orders_Staging PARTITION 1
Go

Execute dbo.PartitionDetails
Go