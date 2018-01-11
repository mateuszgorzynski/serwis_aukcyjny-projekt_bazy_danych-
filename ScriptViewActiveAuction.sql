CREATE VIEW ActiveAuctions
AS
   	SELECT * 
	FROM adr7dev_mateusz.Items i 
	WHERE (([Type] = 0 AND NOT EXISTS 
		(SELECT * 
		FROM adr7dev_mateusz.Transactions
		WHERE IdItem = i.IdItem)
	) OR ([Type] = 1 AND FinishDate > GETDATE())) AND IsBlocked = 0