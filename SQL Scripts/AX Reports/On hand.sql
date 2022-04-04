select
    intt.ITEMID as 'Item number'
	,intt.NAMEALIAS as 'Product name'
	,intt.AW_SPECIFICATION as 'Vendor catalog number'
	,intt.AW_MANUNAME as 'Maker name'
    ,oh.INVENTLOCATIONID as 'Warehouse'
	,oh.WMSLOCATIONID as 'Location'
	,grp.ITEMGROUPID as 'Item group'
	,intt.AW_MachineTypeCode as 'IAC'
	,oh.OH as 'On hand'
	,oh.OO as 'On order'
--	,intt.CREATEDDATETIME as 'Created date and time'
from MicrosoftDynamicsAX.dbo.INVENTTABLE intt
	inner join MicrosoftDynamicsAX.dbo.INVENTITEMGROUPITEM grp
	on grp.ITEMID = intt.ITEMID
	inner join (
	select 
	    isum.ITEMID
		,dim.INVENTLOCATIONID
		,dim.WMSLOCATIONID
		,sum(isum.PHYSICALINVENT) as OH
		,sum(isum.ORDERED) as OO
	from MicrosoftDynamicsAX.dbo.INVENTSUM isum
		inner join MicrosoftDynamicsAX.dbo.INVENTDIM dim
		on dim.INVENTDIMID = isum.INVENTDIMID
	where isum.CLOSED != 1
	group by isum.ITEMID, dim.INVENTLOCATIONID, dim.WMSLOCATIONID) OH
	on OH.ITEMID = intt.ITEMID
order by intt.ITEMID