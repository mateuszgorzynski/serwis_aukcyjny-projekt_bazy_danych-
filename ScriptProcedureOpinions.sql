IF OBJECT_ID('InsertOpinion', 'P') IS NOT NULL
	DROP PROCEDURE InsertOpinion
GO

CREATE PROCEDURE InsertOpinion (
	@IdSeller INT,
	@IdTransaction INT,
	@Note BINARY,
	@Decsription TEXT
	)
AS

	IF (@Note IS NULL)     
		RAISERROR (N'Note is empty.', 16,  1)
		
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdSeller)
		RAISERROR (N'This Seller not exists.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Transactions WHERE IdTransaction = @IdTransaction)
		RAISERROR (N'This Transaction not exists.', 16,  1)

	INSERT INTO adr7dev_mateusz.Opinions(IdSeller, IdTransaction, Note, Description)
	VALUES (@IdSeller, @IdTransaction, @Note, @Decsription)

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	-- EXEC InsertOpinion @IdSeller = #, @IdTransaction = #, @Note = #, @Decsription = #
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH