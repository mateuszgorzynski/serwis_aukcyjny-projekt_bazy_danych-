IF OBJECT_ID('InsertItemCategory','P') IS NOT NULL
DROP PROCEDURE InsertItemCategory
GO

CREATE PROCEDURE InsertItemCategory (
        @Name VARCHAR(250),
        @ParentCategory INT
		)
AS
		DECLARE @IdCategory INT
		 
        IF (@Name IS NULL)     
			RAISERROR (N'First Name is empty.', 16, 1)

        SET @IdCategory = (SELECT ISNULL(MAX(IdCategory),0)+1 FROM adr7dev_mateusz.ItemCategories)

		IF @IdCategory = @ParentCategory
			RAISERROR (N'IdCategory and ParentCategory cant be same value . %s', 16, 1, @ParentCategory)

		IF (@ParentCategory = 0)
		BEGIN
			INSERT INTO adr7dev_mateusz.ItemCategories([Name])
			VALUES (@Name)
		END

		ELSE

		BEGIN
			INSERT INTO adr7dev_mateusz.ItemCategories([Name],ParentCategory)
			VALUES (@Name,@ParentCategory)
		END
GO


BEGIN TRY
        -- PATTERN (REPLACE # WITH CORRECT VALUE)
		--EXEC InsertItemCategory @Name = #, @ParentCategory = #
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH