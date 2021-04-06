
SELECT pn.NCR_Date, pn.Origin_ref, pn.Reference, pn.Class, pn.Status 
FROM uniPoint_JPMC.dbo.PT_NC pn
WHERE pn.Origin_ref <> 'TITANFIN' AND pn.Origin_ref IS NOT NULL AND pn.Reference <> '' AND pn.Class IS NOT NULL AND pn.NCR_Date >= {start} AND pn.NCR_Date <= {end}
ORDER BY NCR_Date ASC

--Harcoded Date for Reference
--SELECT pn.NCR_Date, pn.Origin_ref, pn.Reference, pn.Class, pn.Status 
--FROM uniPoint_JPMC.dbo.PT_NC pn
--WHERE pn.Origin_ref <> 'TITANFIN' AND pn.Origin_ref IS NOT NULL AND pn.Reference <> '' AND pn.Class IS NOT NULL AND pn.NCR_Date > '2021-03-01'
--ORDER BY NCR_Date ASC