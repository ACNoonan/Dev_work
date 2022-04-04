SELECT
  hb.CABBV
  ,hb.SHPINV
  ,hb.INVNO
  ,hb.CPART
  ,hb.QTYSHP
  ,hb.F3WRBG
  ,IIF(CAST(tb.PDATE AS TIME(0)) <= '5:59', DATEADD(DAY,-1,tb.PDATE), tb.PDATE) AS DateAdjustedForShifts
  ,IIF(CAST(tb.PDATE AS TIME(0)) BETWEEN '6:00' AND '18:00', 'A', 'B') AS Shift
  ,CAST(tb.PDATE AS TIME(0)) AS Guess
  ,tb.PDATE
FROM
  aw.v_RSPSHPB hb
INNER JOIN aw.v_RSPSHSTB tb
ON tb.PARTNO = hb.PARTNO
AND tb.SHPDTE = hb.SHPDTE
ORDER BY hb.SHPDTE DESC;