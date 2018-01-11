IF OBJECT_ID('RaportAuctions','P') IS NOT NULL
	DROP PROCEDURE RaportAuctions
GO

CREATE PROCEDURE RaportAuctions(
	@IdItem INT
	)
AS
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem ) 
			RAISERROR (N'Item with given @IdItem does not exist..', 16, 1)

	IF  NOT EXISTS (SELECT * FROM adr7dev_mateusz.Transactions WHERE IdItem = @IdItem ) 
			RAISERROR (N'Transactions with given @IdItem does not exist..', 16, 1)



	Select Price,IdBuyer from Transactions where IdItem = @IdItem
GO


BEGIN TRY
	
	
	Exec RaportAuctions @IdItem = 2
	
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH
