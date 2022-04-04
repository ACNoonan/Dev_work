SELECT 
	vpt.DELIVERYDATE as 'Receipt date',
	vpj.AW_EMPLID as 'Receiver',
	vpt.ORIGPURCHID as 'Purchase order',
	vpt.ITEMID as 'Item number',
	vpt.NAME as 'Item description',
	vpt.QTY as 'Received qty',
	dim_dpt.DISPLAYVALUE AS 'D1_Department',
	isnull(dim_ringi.DISPLAYVALUE,'') AS 'D3_Ringi',
	dim_proj.DISPLAYVALUE AS 'D4_Project'
from MicrosoftDynamicsAX.dbo.VENDPACKINGSLIPTRANS vpt
	inner join MicrosoftDynamicsAX.dbo.VENDPACKINGSLIPJOUR vpj
	on vpt.VENDPACKINGSLIPJOUR = vpj.RECID
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_dpt
	  on dim_dpt.DEFAULTDIMENSION = vpt.DEFAULTDIMENSION
	  and dim_dpt.REPORTCOLUMNNAME = 'DEPT'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_ringi
	  on dim_ringi.DEFAULTDIMENSION = vpt.DEFAULTDIMENSION
	  and dim_ringi.REPORTCOLUMNNAME = 'RINGI'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_proj
	  on dim_proj.DEFAULTDIMENSION = vpt.DEFAULTDIMENSION
	  and dim_proj.REPORTCOLUMNNAME = 'PROJ'