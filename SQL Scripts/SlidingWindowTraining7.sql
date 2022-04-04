--Partition Splitting: Prepare filegroup for new partition
ALTER Partition Scheme OrderPartitionScheme NEXT USED Staging_TSTFG_01
Go

Execute dbo.PartitionDetails
Go