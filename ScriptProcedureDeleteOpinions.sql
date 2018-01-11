IF OBJECT_ID('DeleteOpinion','P') IS NOT NULL
	DROP PROCEDURE DeleteOpinion
GO

CREATE PROCEDURE DeleteOpinion (
	@IdOpinion INT
	)
AS

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Opinions WHERE IdOpinion = @IdOpinion)
		RAISERROR (N'Opinion with given IdOpinion does not exist.', 16, 1)

	DELETE FROM adr7dev_mateusz.Opinions WHERE IdOpinion = @IdOpinion

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	-- EXEC DeleteOpinion @IdOpinion = #
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH