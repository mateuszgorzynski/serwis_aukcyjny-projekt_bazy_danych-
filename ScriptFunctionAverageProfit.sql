CREATE FUNCTION dbo.FunctionAverageProfit
	(@IdUser INT)
	returns INT
as
begin    
	RETURN (SELECT AVG(t.Price) FROM adr7dev_mateusz.Transactions t INNER JOIN adr7dev_mateusz.Items i ON t.IdItem = i.IdItem WHERE Seller = @IdUser)
end

-- PATTERN
-- SELECT *, dbo.FunctionAverageProfit(IdUser) as AverageProfit FROM Users

-- DROP FUNCTION FunctionAverageProfit
