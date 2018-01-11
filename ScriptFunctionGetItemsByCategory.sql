CREATE FUNCTION dbo.FunctionGetItemsByCategory
	(@IdCategory INT)
	RETURNS TABLE
AS
	RETURN SELECT * FROM adr7dev_mateusz.Items WHERE Category = @IdCategory AND IsBlocked = 0 AND FinishDate > GETDATE()


-- PATTERN
-- SELECT * FROM FunctionGetItemsByCategory(1)

-- DROP FUNCTION dbo.FunctionGetItemsByCategory
