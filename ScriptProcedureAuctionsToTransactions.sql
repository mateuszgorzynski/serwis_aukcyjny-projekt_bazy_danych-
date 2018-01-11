IF OBJECT_ID('InsertAuctionToTransactions', 'P') IS NOT NULL
	DROP PROCEDURE InsertAuctionToTransactions
GO

CREATE PROCEDURE InsertAuctionToTransactions (
	@IdItem INT
	)
AS

	IF (@IdItem IS NULL)
		RAISERROR (N'IdItem can not be empty.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'Item with given IdItem does not exits.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND IsBlocked = 0)
		RAISERROR (N'Item can not be blocked.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND [Type] = 1)
		RAISERROR (N'Item must be auction type.', 16,  1)

	IF EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE FinishDate < GETDATE())
	BEGIN
	
		IF EXISTS (SELECT * FROM adr7dev_mateusz.Transactions WHERE IdItem = @IdItem)
		BEGIN
			RAISERROR (N'The action is already in transactions.', 16,  1)
		END

		ELSE

		BEGIN
			INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
			SELECT TOP 1 IdItem, IdBuyer, Price, GETDATE() as SendDate FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem ORDER BY Price DESC
		END
	END

GO


SELECT * FROM Auctions
SELECT * FROM Transactions


BEGIN TRY
	EXEC InsertAuctionToTransactions @IdItem = 5
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

SELECT * FROM Auctions
SELECT * FROM Transactions
