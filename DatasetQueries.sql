--BASIC TMMI TABLE
SELECT   
	[JTP].[PARTNO]
	,[JTP].[CPART]
	,[JTP].[REQDAT]
	,[JTP].[QTYRQ]
	,[CD].[CABBV]
	,[CD].[WEEK]
	,[CD].[WORKDAYS]
	,[JTP].[QTYRQ]/[CD].[WORKDAYS] AS 'Weekly Average'
	,[ALT].[ATModel]
FROM Central.aw.v_jtpload JTP
INNER JOIN [Sandbox].[dbo].[CalendarData] CD
ON [JTP].[DABBV] = [CD].[CABBV] AND CONVERT(DATE,[JTP].[REQDAT]) = [CD].[WEEK]
LEFT JOIN Sandbox.dbo.AT_LineTranslation ALT
ON  [JTP].[PARTNO] = [ALT].[AWNCPartNumber]
WHERE reqtyp='D' AND reqfrq='W' AND QTYRQ > 0 AND [JTP].[DABBV] = 'TMMI'
ORDER BY DABBV, REQDAT, PARTNO


--SUMMARY TABLE
SELECT 
	 [JTP].[DABBV]
	,[JTP].[PARTNO]
	,[JTP].[CPART]
	,[JTP].[REQDAT]
	,[JTP].[QTYRQ]
	,[JTP].[RANNO]
	,[CD].[CABBV]
	,[CD].[WEEK]
	,[CD].[WORKDAYS]
	,[ALT].[ATModel]
    ,[ALT].[ATLine]
	,[JTP].[QTYRQ]/[CD].[WORKDAYS] AS 'Weekly Average'
FROM Central.aw.v_jtpload JTP
LEFT JOIN [Sandbox].[dbo].[CalendarData] CD
ON (DATEADD(DAY,1,CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]) OR (DATEADD(DAY,-1,CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]) OR (CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]
LEFT JOIN Sandbox.dbo.AT_LineTranslation ALT
ON [JTP].[PARTNO] = [ALT].[AWNCPartNumber]
WHERE reqtyp='D' AND reqfrq='W' AND QTYRQ > 0 
ORDER BY DABBV, REQDAT, PARTNO


--B800 SUMMARY TABLE
SELECT 
	 [JTP].[DABBV]
	,[JTP].[PARTNO]
	,[JTP].[CPART]
	,[JTP].[REQDAT]
	,[JTP].[QTYRQ]
	,[JTP].[RANNO]
	,[CD].[CABBV]
	,[CD].[WEEK]
	,[CD].[WORKDAYS]
	,[ALT].[ATModel]
    ,[ALT].[ATLine]
	,[JTP].[QTYRQ]/[CD].[WORKDAYS] AS 'Weekly Average'
FROM Central.aw.v_jtpload JTP
LEFT JOIN [Sandbox].[dbo].[CalendarData] CD
ON (DATEADD(DAY,1,CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]) OR (DATEADD(DAY,-1,CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]) OR (CONVERT(DATE,[JTP].[REQDAT])) = [CD].[WEEK]
LEFT JOIN Sandbox.dbo.AT_LineTranslation ALT
ON [JTP].[PARTNO] = [ALT].[AWNCPartNumber]
WHERE reqtyp='D' AND reqfrq='W' AND QTYRQ > 0 AND [ALT].[ATLine] = 'B800'
ORDER BY DABBV, REQDAT, PARTNO