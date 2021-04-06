--Part 1  (Unresolved quantites from the previous month)
--Group by Job for the Part 2 and 3 Union. Inner joing with laborEntry, select all non-discrep quantities
SELECT ld2.JobNum, ld2.DiscrepQty, ld2.CreateDate
FROM EpicorLive10.dbo.LaborDtl ld2 
INNER JOIN 
		(SELECT	src.JobNum[JobNum], SUM(src.DiscrepQty)[DiscrepQty] 
	FROM (SELECT ld.JobNum, ld.DiscrepQty
			FROM EpicorLive10.dbo.LaborDtl ld 
			WHERE ld.CreateDate > {before} and ld.Company = 'JPMC' and ld.DiscrepQty <> 0
			UNION ALL
			SELECT dh.JobNum, da.Quantity
			FROM EpicorLive10.dbo.DMRActn da
			LEFT OUTER JOIN EpicorLive10.dbo.DMRHead dh on da.DMRNum = dh.DMRNum 
			WHERE da.ActionDate > {before} and (da.ActionType = 'R' OR da.DestinationType = 'M') and da.JobNum <> '' and da.Company = 'JPMC' and dh.JobNum <> '') src
	GROUP BY src.JobNum) src2
ON ld2.JobNum  = src2.JobNum
WHERE ld2.CreateDate <= {before} AND ld2.DiscrepQty <> 0
ORDER BY ld2.JobNum ASC

--Backup with hardcoded dates
--SELECT ld2.JobNum, ld2.DiscrepQty, ld2.CreateDate
--FROM EpicorLive10.dbo.LaborDtl ld2 
--INNER JOIN 
--		(SELECT	src.JobNum[JobNum], SUM(src.DiscrepQty)[DiscrepQty] 
--	FROM (SELECT ld.JobNum, ld.DiscrepQty
--			FROM EpicorLive10.dbo.LaborDtl ld 
--			WHERE ld.CreateDate > '2021-03-01' and ld.Company = 'JPMC' and ld.DiscrepQty <> 0
--			UNION ALL
--			SELECT dh.JobNum, da.Quantity
--			FROM EpicorLive10.dbo.DMRActn da
--			LEFT OUTER JOIN EpicorLive10.dbo.DMRHead dh on da.DMRNum = dh.DMRNum 
--			WHERE da.ActionDate > '2021-03-01' and (da.ActionType = 'R' OR da.DestinationType = 'M') and da.JobNum <> '' and da.Company = 'JPMC' and dh.JobNum <> '') src
--	GROUP BY src.JobNum) src2
--ON ld2.JobNum  = src2.JobNum
--WHERE ld2.CreateDate <= '2021-03-01' AND ld2.DiscrepQty <> 0
--ORDER BY ld2.JobNum ASC