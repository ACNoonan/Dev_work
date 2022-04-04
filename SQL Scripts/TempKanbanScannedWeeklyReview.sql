SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Monday 1/20'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-20') AS NumTempKanban

SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Tuesday 1/21'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-21') AS NumTempKanban

SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Wednesday 1/22'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-22') AS NumTempKanban

SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Thursday 1/23'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-23') AS NumTempKanban

SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Friday 1/24'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-24') AS NumTempKanban

SELECT COUNT(*) AS 'Number of Temp Kanbans Scanned: Monday 1/27'
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-27') AS NumTempKanban