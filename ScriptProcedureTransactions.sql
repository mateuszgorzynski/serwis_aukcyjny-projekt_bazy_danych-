IF OBJECT_ID('InsertTransactions', 'P') IS NOT NULL
	DROP PROCEDURE InsertTransactions
GO

CREATE PROCEDURE InsertTransactions (
	@IdItem INT,
	@IdBuyer INT,
	@Price BINARY,
	@SendDate TEXT
	)
AS

	IF (@Price IS NULL)     
		RAISERROR (N'Price is empty.', 16,  1)

	IF (@SendDate IS NULL)     
		RAISERROR (N'SendDate is empty.', 16,  1)
		
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'Item with given IdItem does not exist.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdBuyer)
		RAISERROR (N'User with given IdUser does not exist.', 16,  1)

	INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
	VALUES (@IdItem, @IdBuyer, @Price, @SendDate)

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	-- EXEC InsertOpinion @IdItem = #, @IdBuyer = #, @Price = #, @SendDate = #
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH