select
   ahd.PURCHNUMBERSEQUENCE
   ,al.ITEMID as 'Item number'
   ,al.AWNCKANBANNOHTH as 'Kanban number'
   ,al.AWNCECINOHTH as 'ECI number'
   ,al.COMMITEDQUANTITY as 'Quantity'
   ,al.PRODUCTUNITOFMEASURE as 'UOM'
   ,al.PRICEPERUNIT as 'Unit price'
   ,al.EFFECTIVEDATE as 'Effective date'
   ,al.EXPIRATIONDATE as 'Expire date'
   ,dv_DEPT.DISPLAYVALUE as 'D1_Department'
   ,dv_PROJ.DISPLAYVALUE as 'D4_Project'
from MicrosoftDynamicsAX.dbo.AGREEMENTHEADER ahd
    inner join MicrosoftDynamicsAX.dbo.AGREEMENTLINE al
	on ahd.RECID = al.AGREEMENT
	inner join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dv_DEPT
	on al.DEFAULTDIMENSION = dv_DEPT.DEFAULTDIMENSION
	and dv_DEPT.REPORTCOLUMNNAME = 'DEPT'
	inner join MicrosoftDynamicsAX.dbo.DEFAULTDIMENSIONVIEW dv_PROJ
	on al.DEFAULTDIMENSION = dv_PROJ.DEFAULTDIMENSION
	and dv_PROJ.REPORTCOLUMNNAME = 'PROJ'