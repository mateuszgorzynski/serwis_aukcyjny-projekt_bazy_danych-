IF OBJECT_ID('InsertOpinion','P') IS NOT NULL
DROP PROCEDURE InsertOpinion
GO

CREATE PROCEDURE InsertOpinion (
        @IdSeller INT ,
        @IdTransaction INT ,
        @Note BINARY ,
        @Decsription TEXT)
AS

--1. If someone is empty or wrong written -> call the error and finish the procedur
        /*IF (@Decsription IS NULL)     
		BEGIN
                RAISERROR (N'Decsription is empty, or wrong written. %s', 16,  1, -- State
                        @Decsription)
		END*/
		 IF (@Note IS NULL)     
		BEGIN
                RAISERROR (N'Note is empty. %s', 16,  1,  @Note)
        END
		
		IF NOT EXISTS(SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdSeller  )
		BEGIN
				RAISERROR (N'This Seller not exists. %s', 16,  1,  @IdSeller)
		END

		IF NOT EXISTS(SELECT * FROM adr7dev_mateusz.Transactions WHERE IdTransaction = @IdTransaction  )
		BEGIN
				RAISERROR (N'This Transaction not exists. %s', 16,  1,  @IdTransaction)
		END

		--7. Insert new opinion:
      INSERT INTO adr7dev_mateusz.Opinions( IdSeller,IdTransaction,Note,Description)
        VALUES (@IdSeller, @IdTransaction, @Note, @Decsription)

GO

BEGIN TRY
        EXEC InsertOpinion @IdSeller = 1, @IdTransaction=1, @Note=1, @Decsription='Pikny'
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH