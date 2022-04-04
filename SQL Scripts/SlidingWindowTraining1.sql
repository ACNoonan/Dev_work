USE [master]
GO

--Drop if the DB already exists 
If exists(Select name from sys.databases where name = 'Staging_TST')
Begin
   Drop database Staging_TST
End
Go

--Create the DB
CREATE DATABASE [Staging_TST]
CONTAINMENT = NONE
ON PRIMARY ( NAME = N'Staging_TST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_TST.mdf' , SIZE = 500000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
LOG ON ( NAME = N'Staging_TST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_TST_log.ldf' , SIZE = 470144KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
go

--Remove physical database files for 3 partitioning
If (Exists(Select name from sys.database_files where name='Staging_TST_01'))
Begin
   Alter Database Staging_TST
   Remove file Staging_TST_01
End
Go

If (Exists(Select name from sys.database_files where name='Staging_TST_02'))
Begin
   Alter Database Staging_TST
   Remove file Staging_TST_02
End
Go

If (Exists(Select name from sys.database_files where name='Staging_TST_03'))
Begin
   Alter Database Staging_TST
   Remove file Staging_TST_03
End
Go

----Remove file groups for 3 partitioning
If (Exists(Select name from sys.filegroups where name='Staging_TSTFG_01'))
Begin
   Alter Database Staging_TST
   Remove Filegroup Staging_TSTFG_01
End
Go

If (Exists(Select name from sys.filegroups where name='Staging_TSTFG_02'))
Begin
   Alter Database Staging_TST
   Remove Filegroup Staging_TSTFG_02
End
Go

If (Exists(Select name from sys.filegroups where name='Staging_TSTFG_03'))
Begin
   Alter Database Staging_TST
   Remove Filegroup Staging_TSTFG_03
End
Go

Use Master
go

--Create FileGroups for partitioning
ALTER DATABASE Staging_TST
ADD FILEGROUP Staging_TSTFG_01 
GO

ALTER DATABASE Staging_TST
ADD FILE 
(
NAME = [Staging_TST_01], 
FILENAME = --'K:\Program Files\Microsoft SQL Server\MSSQL11.SIR\MSSQL\Data\Staging\Staging_TST_01.ndf', 
'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_TST_01.ndf', 
SIZE = 5242880 KB, 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 5242880 KB
) TO FILEGROUP Staging_TSTFG_01
GO

ALTER DATABASE Staging_TST
ADD FILEGROUP Staging_TSTFG_02 
GO

ALTER DATABASE Staging_TST
ADD FILE 
(
NAME = [Staging_TST_02], 
FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_TST_02.ndf', 
SIZE = 5242880 KB, 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 5242880 KB
) TO FILEGROUP Staging_TSTFG_02
GO

ALTER DATABASE Staging_TST
ADD FILEGROUP Staging_TSTFG_03 
GO

ALTER DATABASE Staging_TST
ADD FILE 
(
NAME = [Staging_TST_03], 
FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Staging_TST_03.ndf', 
SIZE = 5242880 KB, 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 5242880 KB
) TO FILEGROUP Staging_TSTFG_03
GO

Use Staging_TST
go

CREATE PARTITION FUNCTION OrderPartitionFunction (Datetime) 
AS RANGE LEFT FOR VALUES ('20171201', '20180101'); 
GO

CREATE PARTITION SCHEME OrderPartitionScheme
AS PARTITION OrderPartitionFunction
TO (Staging_TSTFG_01,Staging_TSTFG_02,Staging_TSTFG_03);
GO

--Creating Orders table
CREATE TABLE Orders (
OrderID INT IDENTITY NOT NULL,
OrderDate DATETIME NOT NULL,
CustomerID INT NOT NULL, 
OrderStatus CHAR(1) NOT NULL DEFAULT 'P',
ShippingDate DATETIME
);
Go

ALTER TABLE Orders ADD CONSTRAINT PK_Orders PRIMARY KEY Clustered (OrderID, OrderDate)
ON OrderPartitionScheme (OrderDate);
Go

INSERT INTO [dbo].[Orders]([OrderDate],[CustomerID],[OrderStatus],[ShippingDate])
VALUES(DateAdd(d, ROUND(DateDiff(d, '2017-10-01', '2017-12-31') * RAND(CHECKSUM(NEWID())), 0),DATEADD(second,CHECKSUM(NEWID())%48000, '2017-10-01')),ABS(CHECKSUM(NewId())) % 1000,'P',DateAdd(d, ROUND(DateDiff(d, '2017-10-01', '2017-12-31') * RAND(CHECKSUM(NEWID())), 0),DATEADD(second,CHECKSUM(NEWID())%48000, '2017-10-01')))
GO 1000

