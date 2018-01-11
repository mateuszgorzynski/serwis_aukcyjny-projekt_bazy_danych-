IF OBJECT_ID('InsertItem','P') IS NOT NULL
DROP PROCEDURE InsertItem
GO

CREATE PROCEDURE InsertItem (
        @Name VARCHAR(250) ,
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
		BEGIN
                RAISERROR (N'Name is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Name
                )
        END

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.ItemCategories WHERE IdCategory = @Category)
		BEGIN
                RAISERROR (N'IdCategory must be an existing category. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Category
                )
        END

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @Seller)
		BEGIN
                RAISERROR (N'Seller must be an existing user. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Seller
                )
        END


		IF (@Type IS NULL)
		BEGIN
                RAISERROR (N'Type can not be a null value. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Type
                )
        END

		IF (@Price IS NULL)
		BEGIN
                RAISERROR (N'Price can not be a null value. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Price
                )
        END      

		IF (@FinishDate IS NULL AND @FinishDate > GETDATE())
		BEGIN
                RAISERROR (N'Finish date can not be empty and must be in the future.', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1 -- State
                )
        END

		-- -----

        SET @IdItem = (SELECT ISNULL(MAX(IdItem),0)+1 FROM adr7dev_mateusz.Items)

		-- -----

        INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
        VALUES (@Name, @Description, @Category, @Seller, @Type, @Price, @MinRaise, @FinishDate)

GO


BEGIN TRY
        EXEC InsertItem @Name = 'Nokia 3310', @Description = 'Fajny telefonik...', @Category = '1', @Seller = '1', @Type = 1, @Price = 50, @MinRaise ='0', @FinishDate = '2018-04-02 21:37'

END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH



select * from adr7dev_mateusz.Items