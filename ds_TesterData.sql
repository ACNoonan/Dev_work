SELECT DISTINCT
        p.[CaptureDateTime]
       ,p.[TesterName]
       ,p.[C1_MV]
       ,p.[C2_MV]
       ,p.[C4_MV]
       ,p.[LU_ON_MV]
       ,p.[PL_MV]
       ,p.[To_COOLER_MV]
       ,p.[LUB_MV]
       ,p.[C3_MV]
       ,p.[B1_MV]
       ,p.[B2_MV]
       ,p.[TC_IN_MV]
       ,p.[TC_OUT_MV]
       ,p.[Rr_MV]
       ,p.[From_COOLER_MV]
       ,p.[OilRoad_MV]
       ,p.[GeneralPort_MV]
       ,p.[JUDGE_OK]
       ,p.[JUDGE_IMPREG]
       ,p.[JUDGE_DISPOSAL_IMPREG]
       ,p.[JUDGE_DISPOSAL]
       ,p.[BEFORE_IMPREG_PART]
       ,p.[AFTER_IMPREG_PART]
       ,p.[MASTER_PART]
       ,p.[SerialNo]
       ,p.[StampData]
    ,p.[ConcentTank1]
    ,p.[ConcentTank2]
from (
              select [TagName], [CaptureValue], [CaptureDateTime], [TesterName]
              from [Tableau].[aw].[v_ProductTester] 
) x
PIVOT (min([CaptureValue])
              for [TagName] in (
                                                [C1_MV], [C2_MV], [C4_MV], [LU_ON_MV], [PL_MV], [To_COOLER_MV], [LUB_MV], [C3_MV], [B1_MV], [B2_MV], [TC_IN_MV], [TC_OUT_MV], [Rr_MV],[From_COOLER_MV], 
                                                [OilRoad_MV],[GeneralPort_MV], [JUDGE_OK], [JUDGE_IMPREG], [JUDGE_DISPOSAL_IMPREG], [JUDGE_DISPOSAL], [BEFORE_IMPREG_PART], [AFTER_IMPREG_PART], [MASTER_PART], 
                                                [SerialNo], [StampData], [ConcentTank1], [ConcentTank2]
                                         )
) p

where 
       p.[TesterName] in (@UserSearchTesterName)
       and p.[CaptureDateTime] between @UserStartDate AND @UserEndDate
order by
       p.[CaptureDateTime] DESC