--Create stored procedure to automatically create parameters for new partition, perform partition switching, splitting and merging
IF Exists(Select Name from sys.procedures where name='CreateNextPartition')
Drop procedure CreateNextPartition
GO
Create procedure dbo.CreateNextPartition (@DtNextBoundary as datetime)
as
Begin
Declare @DtOldestBoundary AS datetime
Declare @strFileGroupToBeUsed AS VARCHAR(100)
Declare @PartitionNumber As int
SELECT @strFileGroupToBeUsed = fg.name, @PartitionNumber = p.partition_number, @DtOldestBoundary = cast(prv.value as datetime) FROM sys.partitions p 
INNER JOIN sys.sysobjects tab on tab.id = p.object_id
INNER JOIN sys.allocation_units au ON au.container_id = p.hobt_id 
INNER JOIN sys.filegroups fg ON fg.data_space_id = au.data_space_id 
INNER JOIN SYS.partition_range_values prv ON prv.boundary_id = p.partition_number
INNER JOIN sys.partition_functions PF ON pf.function_id = prv.function_id
WHERE 1=1
AND pf.name = 'OrderPartitionFunction'
AND tab.name = 'Orders'
AND cast(value as datetime) = (
SELECT MIN(cast(value as datetime)) FROM sys.partitions p 
INNER JOIN sys.sysobjects tab on tab.id = p.object_id
INNER JOIN SYS.partition_range_values prv ON prv.boundary_id = p.partition_number
INNER JOIN sys.partition_functions PF ON pf.function_id = prv.function_id
WHERE 1=1
AND pf.name = 'OrderPartitionFunction'
AND tab.name = 'Orders'
)
Select @DtOldestBoundary Oldest_Boundary , @strFileGroupToBeUsed FileGroupToBeUsed,@PartitionNumber PartitionNumber
ALTER TABLE Orders SWITCH PARTITION @PartitionNumber TO Orders_Staging PARTITION @PartitionNumber
TRUNCATE TABLE Orders_Staging
EXEC('Alter Partition Scheme OrderPartitionScheme NEXT USED '+@strFileGroupToBeUsed)
Alter Partition Function OrderPartitionFunction() SPLIT RANGE (@DtNextBoundary);
Alter Partition Function OrderPartitionFunction() MERGE RANGE (@DtOldestBoundary);
End
Go

Execute CreateNextPartition '20180301'
Go

Execute dbo.PartitionDetails
Go	