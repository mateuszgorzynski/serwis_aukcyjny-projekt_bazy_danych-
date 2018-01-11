IF OBJECT_ID('InsertItemCategory','P') IS NOT NULL
DROP PROCEDURE InsertItemCategory
GO

CREATE PROCEDURE InsertItemCategory (
        @Name VARCHAR(250) ,
        @ParentCategory INT
        )
AS
		--declare @IdCategory
		DECLARE @IdCategory INT
		 
                 -- verification of internal parameters --
        --1. If Name is empty or wrong written -> call the error and finish the procedur
        IF (@Name IS NULL)     
		BEGIN
                RAISERROR (N'First Name is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Name 
						)
        END

		

		

		 --2. Set New I wowowowowowowow
        SET @IdCategory = (SELECT ISNULL(MAX(IdCategory),0)+1 FROM adr7dev_mateusz.ItemCategories)

		IF @IdCategory = @ParentCategory
		BEGIN
                RAISERROR (N'IdCategory and ParentCategory cant be same value . %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @ParentCategory
                )
        END

		if (@ParentCategory =0)
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
        
		EXEC InsertItemCategory @Name = 'Elektronika', @ParentCategory =0
		EXEC InsertItemCategory @Name = 'laptopy', @ParentCategory =1
		EXEC InsertItemCategory @Name = 'teleony', @ParentCategory =1


END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

select * from adr7dev_mateusz.ItemCategories