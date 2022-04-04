Select
	pr.PURCHREQID AS Requisition,
	pr.PURCHREQNAME AS Name,
	poe.REQEMLORIG AS Requester,
	prl.LINENUM AS Line,
	prl.ITEMID AS Item,
	prl.NAME AS 'Item Description',
	idim.INVENTLOCATIONID AS Warehouse,
	ig.ITEMGROUPID AS 'Item group',
	convert(decimal(15,2), prl.PURCHQTY) AS 'Order Quantity',
	prl.PURCHUNITOFMEASURE AS UM,
	convert(decimal(15,4),prl.PURCHPRICE) AS Price,
	convert(decimal(15,2),prl.LINEAMOUNT) AS Amount,
	dim_dpt.DISPLAYVALUE AS 'D1_Department',
	isnull(dim_ringi.DISPLAYVALUE,'') AS 'D3_Ringi',
	dim_proj.DISPLAYVALUE AS 'D4_Project',
	format(prl.CREATEDDATETIME,'MM/dd/yyyy') AS 'Created date',
	format(prl.REQUIREDDATE,'MM/dd/yyyy') AS 'Required date',
	ISNULL(pl.PURCHID, '') as 'Purchase order'

from MicrosoftDynamicsAX.dbo.PURCHREQTABLE pr
	inner join MicrosoftDynamicsAX.dbo.PURCHREQLINE prl
	on prl.PURCHREQTABLE = pr.RECID
	inner join MicrosoftDynamicsAX.dbo.INVENTDIM idim
	  on idim.INVENTDIMID = prl.INVENTDIMID
	inner join MicrosoftDynamicsAX.dbo.INVENTITEMGROUPITEM ig
	  on ig.ITEMID = prl.ITEMID
	left join MicrosoftDynamicsAX.dbo.PURCHLINE pl
      on prl.LINEREFID = pl.PURCHREQLINEREFID
	left join MicrosoftDynamicsAX.dbo.purchtable po
	  on po.PURCHID = pl.PURCHID
	left join MicrosoftDynamicsAX.dbo.AW_PURCHTABLEEX poe
	  on poe.PURCHID = po.PURCHID
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_dpt
	  on dim_dpt.DEFAULTDIMENSION = prl.DEFAULTDIMENSION
	  and dim_dpt.REPORTCOLUMNNAME = 'DEPT'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_ringi
	  on dim_ringi.DEFAULTDIMENSION = prl.DEFAULTDIMENSION
	  and dim_ringi.REPORTCOLUMNNAME = 'RINGI'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_proj
	  on dim_proj.DEFAULTDIMENSION = prl.DEFAULTDIMENSION
	  and dim_proj.REPORTCOLUMNNAME = 'PROJ'
order by pr.PURCHREQID, prl.LINENUM