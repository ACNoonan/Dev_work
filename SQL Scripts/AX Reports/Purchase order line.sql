Select
	pl.PURCHID AS 'Purchase order',
	isnull(pr.PURCHREQID, pl.REQPOID) AS Requisition,
	poe.REQEMLORIG AS Requisitioner,
	pl.LINENUMBER AS Line,
	pl.ITEMID AS Item,
	pl.NAME AS 'Item Description',
	idim.INVENTLOCATIONID AS Warehouse,
	ig.ITEMGROUPID AS 'Item group',
	convert(decimal(15,2), pl.PURCHQTY) AS 'Order Quantity',
	pl.PURCHUNIT AS UM,
	convert(decimal(15,4),pl.PURCHPRICE) AS Price,
	convert(decimal(15,2),pl.LINEAMOUNT) AS Amount,
	case pl.PURCHSTATUS
		when 1 then 'Open order'
		when 2 then 'Received'
		when 3 then 'Invoiced'
		when 4 then 'Canceled' end AS 'Line Status',
	pl.DELIVERYDATE as 'Delivery date',
	pl.CONFIRMEDDLV as 'Confirmed delivery date',
	isnull(format(POREP.ReqDate,'MM/dd/yyyy'),'') AS 'Received date',
	isnull(convert(decimal(15,2), POREP.RecQty),0.00) AS 'Received qty',
	dim_dpt.DISPLAYVALUE AS 'D1_Department',
	isnull(dim_ringi.DISPLAYVALUE,'') AS 'D3_Ringi',
	dim_proj.DISPLAYVALUE AS 'D4_Project',
	format(pl.CREATEDDATETIME,'MM/dd/yyyy') AS 'Created date'
from MicrosoftDynamicsAX.dbo.PURCHLINE pl
	left join MicrosoftDynamicsAX.dbo.PURCHREQTABLE pr
      on pr.PURCHREQID = pl.PURCHREQID
	inner join MicrosoftDynamicsAX.dbo.purchtable po
	  on po.PURCHID = pl.PURCHID
	inner join MicrosoftDynamicsAX.dbo.AW_PURCHTABLEEX poe
	  on poe.PURCHID = po.PURCHID
	left join (
	select vpt.ORIGPURCHID, vpt.PURCHASELINELINENUMBER, vpt.ITEMID, sum(vpt.QTY) as RecQty, min(vpt.ACCOUNTINGDATE) as ReqDate
    from MicrosoftDynamicsAX.dbo.VENDPACKINGSLIPTRANS vpt
	group by vpt.ORIGPURCHID, vpt.PURCHASELINELINENUMBER, vpt.ITEMID ) POREP
	  on pl.PURCHID = POREP.ORIGPURCHID
	  and pl.LINENUMBER = POREP.PURCHASELINELINENUMBER
	  and pl.ITEMID = POREP.ITEMID
	inner join MicrosoftDynamicsAX.dbo.INVENTDIM idim
	  on idim.INVENTDIMID = pl.INVENTDIMID
	inner join MicrosoftDynamicsAX.dbo.INVENTITEMGROUPITEM ig
	  on ig.ITEMID = pl.ITEMID
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_dpt
	  on dim_dpt.DEFAULTDIMENSION = pl.DEFAULTDIMENSION
	  and dim_dpt.REPORTCOLUMNNAME = 'DEPT'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_ringi
	  on dim_ringi.DEFAULTDIMENSION = pl.DEFAULTDIMENSION
	  and dim_ringi.REPORTCOLUMNNAME = 'RINGI'
	left join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dim_proj
	  on dim_proj.DEFAULTDIMENSION = pl.DEFAULTDIMENSION
	  and dim_proj.REPORTCOLUMNNAME = 'PROJ'
order by pl.PURCHID, pl.LINENUMBER