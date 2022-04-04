--Merge the unwanted partition with the new partition
ALTER Partition Function OrderPartitionFunction() SPLIT RANGE ('20180201');
Go

Execute dbo.PartitionDetails
Go

Alter Partition Function OrderPartitionFunction() MERGE RANGE ('20171201');
Go

Execute dbo.PartitionDetails
Go			