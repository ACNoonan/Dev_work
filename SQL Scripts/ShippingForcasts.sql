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
	,[JTP].[QTYRQ]/[CD].[WORKDAYS] AS 'Weekly Average'
	,[ALT].[ATModel]
FROM Central.aw.v_jtpload JTP
INNER JOIN [Sandbox].[dbo].[CalendarData] CD
ON [JTP].[DABBV] = [CD].[CABBV] AND CONVERT(DATE,[JTP].[REQDAT]) = [CD].[WEEK]
LEFT JOIN Sandbox.dbo.AT_LineTranslation ALT
ON [JTP].[CPART] = [ALT].[AWNCPartNumber]
WHERE reqtyp='D' AND reqfrq='W' AND QTYRQ > 0 --AND [JTP].[DABBV] = 'TMMC' 
ORDER BY DABBV, REQDAT, PARTNO