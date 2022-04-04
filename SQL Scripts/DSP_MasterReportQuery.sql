=================
====Attempt#1====
=================
 SELECT
	[KanbanAWNCKanbanNumber]
	,SUM(Quantity) AS 'DailyQuantitySumByKanban'
 FROM [AWNCInventory].[aw].[v_Inventory]
 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'G903'
 GROUP BY [KanbanAWNCKanbanNumber]
 
 
 
==================
====Attempt#2=====
==================
 SELECT DISTINCT 
      [OGTable].[KanbanAWNCKanbanNumber]
      ,[OGTable].[KanbanAWNCPartNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
      ,[OGTable].[SupplierAbbrev]
	  ,[AggTable].DailyQuantitySumByKanban
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'B800'
	 GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
ORDER BY [OGTable].[KanbanAWNCKanbanNumber]



==================
====Attempt#3=====
==================
SELECT DISTINCT 
      [OGTable].[KanbanAWNCKanbanNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
	  ,[AggTable].DailyQuantitySumByKanban
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'G904'
	 GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
ORDER BY [OGTable].[KanbanAWNCKanbanNumber]

---MISSING PART NUMBER, CANNOT AGGREGATE W/ IT INCLUDED



==================
====Attempt#4=====
==================
SELECT DISTINCT 
      [OGTable].[KanbanAWNCKanbanNumber]
	  ,[OGTable].[AssignedPartNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
	  ,[AggTable].DailyQuantitySumByKanban
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'G904'
	 GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
ORDER BY [OGTable].[KanbanAWNCKanbanNumber]



==================
====Attempt#5=====
==================
SELECT DISTINCT 
      [OGTable].[KanbanAWNCKanbanNumber]
	  ,[OGTable].[SupplierAbbrev]
	  ,[OGTable].[AssignedPartNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
	  ,[AggTable].[DailyQuantitySumByKanban]
	  ,([OGTable].[QtyPerTote]*[AggTable].[DailyQuantitySumByKanban]) AS 'Part Inv (Pcs)'
	  ,([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv]) AS 'Difference'
	  ,(([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv])/[OGTable].[SInv]) AS 'Variance'
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] LIKE (@UserSearchDate) AND [AWNCLine] LIKE 'XXXX'
	 GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
ORDER BY [OGTable].[KanbanAWNCKanbanNumber]




==================
====Attempt#6=====
==================
SELECT DISTINCT 
      [OGTable].[KanbanAWNCKanbanNumber]
	  ,[OGTable].[SupplierAbbrev]
	  ,[OGTable].[AssignedPartNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
      ,[OGTable].[SortOrder]
	  ,[AggTable].DailyQuantitySumByKanban
	  ,([OGTable].[QtyPerTote]*[AggTable].[DailyQuantitySumByKanban]) AS 'Part Inv'
	  ,([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv]) AS 'Difference'
	  ,(([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv])/[OGTable].[SInv]) AS 'Variance'
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] = (@UserSearchDate) AND [AWNCLine] LIKE 'G903'
	 GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
ORDER BY [OGTable].[SortOrder] ASC




==================
====Attempt#7=====
==================
SELECT DISTINCT
	   [OG].[SortOrder]
      ,[OG].[KanbanAWNCKanbanNumber]
	  ,[OG].[SupplierAbbrev]
	  ,[OG].[AssignedPartNumber]
      ,[OG].[QtyPerTote]
      ,[OG].[SInv]
FROM [AWNCInventory].[aw].[v_Inventory] OG
LEFT JOIN 
		(
				SELECT DISTINCT 
			  [OGTable].[SortOrder]
		      ,[OGTable].[KanbanAWNCKanbanNumber]
			  ,[OGTable].[SupplierAbbrev]
			  ,[OGTable].[AssignedPartNumber]
		      ,[OGTable].[QtyPerTote]
		      ,[OGTable].[SInv]
			  ,[AggTable].DailyQuantitySumByKanban
			  ,([OGTable].[QtyPerTote]*[AggTable].[DailyQuantitySumByKanban]) AS 'Part Inv'
			  ,([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv]) AS 'Difference'
			  ,(([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv])/[OGTable].[SInv]) AS 'Variance'
		FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
		Inner Join 
		(
			 SELECT
				[KanbanAWNCKanbanNumber]
				,SUM(Quantity) AS 'DailyQuantitySumByKanban'
			 FROM [AWNCInventory].[aw].[v_Inventory]
			 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'B800'
			 GROUP BY [KanbanAWNCKanbanNumber]
		) AS AggTable
		ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
		) Less
ON OG.KanbanAWNCKanbanNumber = Less.KanbanAWNCKanbanNumber
WHERE Less.KanbanAWNCKanbanNumber IS NULL
ORDER BY OG.SortOrder ASC

--Need to account for unscanned Kanban's, Kanban's w/ 0 quantity for that day


==================
====Attempt#8=====
==================
WITH 
SortOrders AS (
 SELECT DISTINCT SortOrder
 FROM [AWNCInventory].[aw].[v_Inventory]
 WHERE AWNCLine LIKE 'B800'
),
ActualInventory AS (
SELECT DISTINCT 
	  [OGTable].[SortOrder]
      ,[OGTable].[KanbanAWNCKanbanNumber]
	  ,[OGTable].[SupplierAbbrev]
	  ,[OGTable].[AssignedPartNumber]
      ,[OGTable].[QtyPerTote]
      ,[OGTable].[SInv]
	  ,[AggTable].DailyQuantitySumByKanban
	  ,([OGTable].[QtyPerTote]*[AggTable].[DailyQuantitySumByKanban]) AS 'PartInv'
	  ,([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv]) AS 'Diff'
	  ,(([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv])/[OGTable].[SInv]) AS 'Variance'
FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
Inner Join 
(
	 SELECT
		[KanbanAWNCKanbanNumber]
		,SUM(Quantity) AS 'DailyQuantitySumByKanban'
	 FROM [AWNCInventory].[aw].[v_Inventory]
	 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'B800'
	  GROUP BY [KanbanAWNCKanbanNumber]
) AS AggTable
ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber])


SELECT so.SortOrder 
      ,ai.[KanbanAWNCKanbanNumber]
	  ,ai.[SupplierAbbrev]
	  ,ai.[AssignedPartNumber]
      ,ai.[QtyPerTote]
      ,ai.[SInv]
	  ,ai.DailyQuantitySumByKanban
	  ,ai.PartInv
	  ,ai.Diff
	  ,ai.Variance
FROM ActualInventory ai 
RIGHT JOIN SortOrders so ON so.SortOrder = ai.SortOrder
ORDER BY so.SortOrder ASC



==================
====Attempt#9=====
==================
SELECT TOP (1000) [REF].[Kanban]
      ,[REF].[QtyPerTote]
      ,[REF].[StdInvDays]
      ,[REF].[UCL]
      ,[REF].[LCL]
      ,[REF].[AWNCLine]
      ,[REF].[SupplierAbbrev]
      ,[REF].[SInv]
      ,[REF].[AssignedPartNumber]
      ,[REF].[SortOrder]
	  --,[INV].[DailyQuantitySumByKanban]
FROM [AWNCInventory].[dbo].[Reference] REF
LEFT JOIN (
SELECT DISTINCT 
			  [OGTable].[SortOrder]
		      ,[OGTable].[KanbanAWNCKanbanNumber]
			  ,[OGTable].[SupplierAbbrev]
			  ,[OGTable].[AssignedPartNumber]
		      ,[OGTable].[QtyPerTote]
		      ,[OGTable].[SInv]
			  ,[AggTable].DailyQuantitySumByKanban
			  ,([OGTable].[QtyPerTote]*[AggTable].[DailyQuantitySumByKanban]) AS 'Part Inv'
			  ,([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv]) AS 'Difference'
			  ,(([AggTable].[DailyQuantitySumByKanban]-[OGTable].[SInv])/[OGTable].[SInv]) AS 'Variance'
		FROM [AWNCInventory].[aw].[v_Inventory] AS OGTable
		Inner Join 
		(
			 SELECT
				[KanbanAWNCKanbanNumber]
				,SUM(Quantity) AS 'DailyQuantitySumByKanban'
			 FROM [AWNCInventory].[aw].[v_Inventory]
			 WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'B800'
			 GROUP BY [KanbanAWNCKanbanNumber]
		) AS AggTable
		ON [OGTable].[KanbanAWNCKanbanNumber] = [AggTable].[KanbanAWNCKanbanNumber]
		) INV
ON REF.Kanban = INV.KanbanAWNCKanbanNumber AND REF.SortOrder = INV.SortOrder
--WHERE INV.KanbanAWNCKanbanNumber IS NULL AND
WHERE REF.AWNCLine = 'B800' AND REF.SortOrder IS NOT NULL
ORDER BY REF.SortOrder ASC

--NEEDS QUANTITY BY KANBAN





==================
====Attempt#10====
==================
SELECT DISTINCT ref.SortOrder
	,ref.Kanban
	,ref.AssignedPartNumber
	,ref.SupplierAbbrev
	,ref.QtyPerTote
	,ref.StdInvDays
	,ref.AWNCLine
	,inv.DailyQuantitySumByKanban
FROM [AWNCInventory].dbo.Reference ref
LEFT JOIN (
SELECT
  [KanbanAWNCKanbanNumber]
  ,SUM(Quantity) AS 'DailyQuantitySumByKanban'
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [UploadDate] LIKE '2019-11-18' AND [AWNCLine] LIKE 'B800'  GROUP BY [KanbanAWNCKanbanNumber]) AS inv
ON ref.Kanban = inv.KanbanAWNCKanbanNumber
WHERE ref.AWNCLine LIKE 'B800' AND SortOrder IS NOT NULL




==================
====Attempt#11====
==================
SELECT DISTINCT ref.SortOrder
	,ref.Kanban
	,ref.AssignedPartNumber
	,ref.SupplierAbbrev
	,ref.QtyPerTote
    ,ref.SInv
	,ref.StdInvDays
	,ref.AWNCLine
	,inv.DailyQuantitySumByKanban
FROM [AWNCInventory].dbo.Reference ref
LEFT JOIN (
SELECT
  [KanbanAWNCKanbanNumber]
  ,SUM(Quantity) AS 'DailyQuantitySumByKanban'
FROM [AWNCInventory].[aw].[v_Inventory]
WHERE [UploadDate] = (@UserSearchDate) AND [AWNCLine] LIKE 'B800'  GROUP BY [KanbanAWNCKanbanNumber]) AS inv
ON ref.Kanban = inv.KanbanAWNCKanbanNumber
WHERE ref.AWNCLine LIKE 'B800' AND SortOrder IS NOT NULL
 