Select DISTINCT
	pl.PURCHID AS 'Purchase order',
	pl.ITEMID AS Item,
	pl.NAME AS 'Item Description',
	convert(decimal(15,2), pl.PURCHQTY) AS 'Order Quantity',
	pl.PURCHUNIT AS UM,
	convert(decimal(15,4),pl.PURCHPRICE) AS Price,
	convert(decimal(15,2),pl.LINEAMOUNT) AS Amount,
	case pl.PURCHSTATUS
		when 1 then 'Open order'
		when 2 then 'Received'
		when 3 then 'Invoiced'
		when 4 then 'Canceled' end AS 'Line Status',
	pl.CONFIRMEDDLV as 'Confirmed delivery date',
	vit.PurchPrice AS 'Invoice Price',
	pl.LINENUMBER AS 'Line Number',
	vit.INVOICEDATE AS 'Invoice Date',
                vit.INVOICEID AS 'Invoice ID',
                pl.VENDACCOUNT
from MicrosoftDynamicsAX.dbo.PURCHLINE pl
	left join MicrosoftDynamicsAX.dbo.VendInvoiceTrans vit
	on vit.PURCHID = pl.PURCHID
	  AND vit.ITEMID = pl.ITEMID
	  AND vit.DATAAREAID=pl.DATAAREAID
WHERE pl.ITEMID LIKE '35607TBG020' AND (pl.CONFIRMEDDLV BETWEEN '2019-08-02' AND '2019-09-03') 
order by pl.CONFIRMEDDLV desc