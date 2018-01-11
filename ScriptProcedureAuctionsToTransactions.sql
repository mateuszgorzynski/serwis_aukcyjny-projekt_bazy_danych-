IF OBJECT_ID('InsertAuctionToTransactions', 'P') IS NOT NULL
	DROP PROCEDURE InsertAuctionToTransactions
GO

CREATE PROCEDURE InsertAuctionToTransactions (
	@IdItem INT
	)
AS
	DECLARE @foo INT
	DECLARE @CurrentMax INT

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
		
		SET @CurrentMax = (SELECT MAX(Price) FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem)

		(SELECT ItemId, MAX(Price) FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem)
	END

	--INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
	--VALUES (@IdItem, @IdBuyer, @Price, @SendDate)

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	EXEC InsertAuctionToTransactions @IdItem = 5
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

SELECT * FROM Items
SELECT * FROM Auctions
SELECT * FROM Transactions