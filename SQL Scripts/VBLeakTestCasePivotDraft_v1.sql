SELECT DISTINCT
	pvt.CaptureDateTime
	,pvt.TesterName
	,pvt.C1_MV
	,pvt.[C2_MV]
	,pvt.[C4_MV]
	,pvt.[LU_ON_MV]
	,pvt.[PL_MV]
	,pvt.[To_COOLER_MV]
	,pvt.[LUB_MV]
	,pvt.[C3_MV]
	,pvt.[B1_MV]
	,pvt.[B2_MV]
	,pvt.[TC_IN_MV]
	,pvt.[TC_OUT_MV]
	,pvt.[Rr_MV]
	,pvt.[From_COOLER_MV]
	,pvt.[OilRoad_MV]
	,pvt.[GeneralPort_MV]
	,pvt.[JUDGE_OK]
	,pvt.[JUDGE_IMPREG]
	,pvt.[JUDGE_DISPOSAL_IMPREG]
	,pvt.[JUDGE_DISPOSAL]
	,pvt.[BEFORE_IMPREG_PART]
	,pvt.[AFTER_IMPREG_PART]
	,pvt.[MASTER_PART]
	,pvt.[SerialNo]
	,pvt.[StampData]
	,pt.NGLimit
	,pt.COLUMNSORTORDER
FROM (
	SELECT TagName, CaptureValue, CaptureDateTime, TesterName
	FROM [Tableau].[aw].[v_ProductTester]	
) AS CaptureByTag
PIVOT (MIN(CaptureValue)
FOR TagName IN ([C1_MV], [C2_MV], [C4_MV], [LU_ON_MV], [PL_MV], [To_COOLER_MV], [LUB_MV], [C3_MV], [B1_MV], [B2_MV], [TC_IN_MV], [TC_OUT_MV], [Rr_MV],[From_COOLER_MV], [OilRoad_MV], [GeneralPort_MV], [JUDGE_OK], [JUDGE_IMPREG], [JUDGE_DISPOSAL_IMPREG], [JUDGE_DISPOSAL], [BEFORE_IMPREG_PART], [AFTER_IMPREG_PART], [MASTER_PART], [SerialNo], [StampData])) AS pvt
LEFT JOIN [Tableau].[aw].[v_ProductTester] pt
ON pvt.CaptureDateTime = pt.CaptureDateTime
WHERE TRY_CAST(pt.CaptureValue AS FLOAT) IS NULL 
ORDER BY CaptureDateTime DESC





--SELECT DISTINCT TagName
--FROM [Tableau].[aw].[v_ProductTester]


--SELECT TOP(1)*
--FROM [Tableau].[aw].[v_ProductTester]	
--WHERE InsertedOn = '2019-10-31 15:04:06.593'

 -- SELECT 
	--[TagName]
	--,[CaptureValue]
	--,CASE
	--WHEN TRY_CAST(CaptureValue AS FLOAT) = NULL THEN 666
	--WHEN TRY_CAST(CaptureValue AS FLOAT) IS NOT NULL THEN CAST(CaptureValue AS FLOAT)
	--END AS 'cvFLOAT'
 -- FROM [Tableau].[aw].[v_ProductTester]
  --WHERE TagName = 'SerialNo'

  --SELECT DISTINCT CaptureValue
  --FROM [Tableau].[aw].[v_ProductTester]
  --WHERE TagName = 'SerialNo' OR TagName = 'StampData'