SELECT DISTINCT
	   [Kanban]
	   ,AWNCLine
FROM [AWNCInventory].[dbo].[Reference]
WHERE Kanban NOT IN (
	SELECT DISTINCT KanbanAWNCKanbanNumber
	FROM AWNCInventory.aw.v_Inventory
	WHERE CastDateForSearch = '2020-01-23'
)
ORDER BY AWNCLine


SELECT COUNT(*) 
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = '2020-01-23') AS NumberTempKanbans


DECLARE @UserSearchDate VARCHAR(45) = '2020-01-23';
SELECT COUNT(*) 
FROM (
SELECT  DISTINCT [KanbanAWNCKanbanNumber]
	,[LocationDataElementSite]
	,[LocationDataElementLocation]
	,[KanbanSupplierCode]
	,[Supplier Code]
	,[ScanDateTime]
	,[UploadUser]
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [KanbanSupplierCode] LIKE 'Supplier code' AND CastDateForSearch = (@UserSearchDate)) AS NumTempKanban