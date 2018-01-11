IF OBJECT_ID('InsertAuctions','P') IS NOT NULL
	DROP PROCEDURE InsertAuctions
GO

CREATE PROCEDURE InsertAuctions (
	@IdItem INT,
	@IdBuyer INT,
	@Price INT
	)
AS
	DECLARE @IdAuction INT
	DECLARE @MinRaise INT
	DECLARE @CurrentMax INT

	IF (@Price IS NULL)
		RAISERROR (N'Price can not be a null value.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'IdItem must be an existing item.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE Seller != @IdBuyer)
		RAISERROR (N'The buyer can not be the item seller.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE FinishDate > GETDATE())
		RAISERROR (N'User can not bid after FinishDate.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE [Type] = 1)
		RAISERROR (N'Item must be set to auction mode.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdBuyer)
		RAISERROR (N'IdBuyer must be an existing user.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem)
	BEGIN
			
		IF @Price < (SELECT Price FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'User can not bid below asking price.', 16, 1)
	END

	ELSE

	BEGIN

		SET @MinRaise = (SELECT MinRaise FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		SET @CurrentMax = (SELECT MAX(Price) FROM adr7dev_mateusz.Auctions)

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Auctions WHERE Price = @CurrentMax AND IdBuyer != @IdBuyer)
			RAISERROR (N'User can not beat its own bid.', 16, 1)

		IF (@Price - (SELECT Price FROM adr7dev_mateusz.Auctions WHERE Price = @CurrentMax)) < @MinRaise
			RAISERROR (N'Minimal raise is required to beat the bid.', 16, 1)			
	END

	INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
	VALUES (@IdItem, @IdBuyer, @Price, GETDATE())

GO


BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	-- EXEC InsertAuctions @IdItem = #, @IdBuyer = #, @Price = #
END TRY
BEGIN CATCH
	SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH