--Part 2 (Discrep Qty action over the given month)
--Select from the jobs occuring over a given month that have a non-zero discrep qty but a sum total qty of 0
SELECT ld.JobNum, ld.DiscrepQty, ld.CreateDate
FROM EpicorLive10.dbo.LaborDtl ld 
WHERE ld.CreateDate > {before} and ld.Company = 'JPMC' and ld.DiscrepQty <> 0
UNION ALL
--Part3
--Select from DMRs where we either accepted parts as job material or we failed parts
SELECT dh.JobNum, (-da.Quantity), da.ActionDate
FROM EpicorLive10.dbo.DMRActn da
LEFT OUTER JOIN EpicorLive10.dbo.DMRHead dh on da.DMRNum = dh.DMRNum 
WHERE da.ActionDate > {before} and (da.ActionType = 'R' OR da.DestinationType = 'M') and da.JobNum <> '' and da.Company = 'JPMC' and dh.JobNum <> ''
ORDER BY ld.CreateDate  ASC



--Backup with hardcoded dates
--Part 2 (Discrep Qty action over the given month)
--Select from the jobs occuring over a given month that have a non-zero discrep qty but a sum total qty of 0
--SELECT ld.JobNum, ld.DiscrepQty, ld.CreateDate
--FROM EpicorLive10.dbo.LaborDtl ld 
--WHERE ld.CreateDate > '2021-03-01' and ld.Company = 'JPMC' and ld.DiscrepQty <> 0
--UNION ALL
--Part3
--Select from DMRs where we either accepted parts as job material or we failed parts
--SELECT dh.JobNum, (-da.Quantity), da.ActionDate
--FROM EpicorLive10.dbo.DMRActn da
--LEFT OUTER JOIN EpicorLive10.dbo.DMRHead dh on da.DMRNum = dh.DMRNum 
--WHERE da.ActionDate > '2021-03-01' and (da.ActionType = 'R' OR da.DestinationType = 'M') and da.JobNum <> '' and da.Company = 'JPMC' and dh.JobNum <> ''
--ORDER BY ld.CreateDate  ASC