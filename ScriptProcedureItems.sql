IF OBJECT_ID('InsertItem','P') IS NOT NULL
DROP PROCEDURE InsertItem
GO

CREATE PROCEDURE InsertItem (
        @Name VARCHAR(250),
        @Description TEXT,
        @Category INT,
        @Seller INT,
		@Type BINARY,
		@Price INT,
		@MinRaise INT,
		@FinishDate DATETIME
		)
AS
		DECLARE @IdItem INT
		 
        IF (@Name IS NULL)     
			RAISERROR (N'Name is empty.', 16, 1, @Name)

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.ItemCategories WHERE IdCategory = @Category)
			RAISERROR (N'IdCategory must be an existing category.', 16, 1)

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @Seller)
			RAISERROR (N'Seller must be an existing user.', 16, 1)

		IF (@Type IS NULL)
			RAISERROR (N'Type can not be a null value.', 16, 1)

		IF (@Price IS NULL)
			RAISERROR (N'Price can not be a null value.', 16, 1)

		IF (@FinishDate IS NULL AND @FinishDate > GETDATE())
			RAISERROR (N'Finish date can not be empty and must be in the future.', 16, 1)

        INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
        VALUES (@Name, @Description, @Category, @Seller, @Type, @Price, @MinRaise, @FinishDate)

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
    -- EXEC InsertItem @Name = #, @Description = #, @Category = #, @Seller = #, @Type = #, @Price = #, @MinRaise = #, @FinishDate = #

END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH