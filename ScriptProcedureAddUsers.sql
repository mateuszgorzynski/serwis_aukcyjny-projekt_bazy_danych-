IF OBJECT_ID('InsertUser','P') IS NOT NULL
	DROP PROCEDURE InsertUser
GO

CREATE PROCEDURE InsertUser (
	@FirstName VARCHAR(250),
	@LastName VARCHAR(250),
	@Email VARCHAR(254),
	@PhoneNumber VARCHAR(9),
	@Address VARCHAR(250),
	@City VARCHAR(250),
	@PostCode VARCHAR(6)
	)
AS

	DECLARE @IdUser INT

	IF (@FirstName IS NULL)     
		RAISERROR (N'FirstName is empty.', 16, 1)

	IF (@LastName IS NULL)  
		RAISERROR (N'LastName is empty.', 16, 1)

	IF (@Email NOT LIKE '%_@%_.__%' ) 
		RAISERROR (N'Email is incorrect or empty.', 16, 1)

	IF EXISTS (SELECT * from adr7dev_mateusz.Users where Email = @Email)
		RAISERROR (N'User with given Email is already in database.', 16, 1)

	IF (@Address IS NULL ) 
		RAISERROR (N'Address is empty.', 16, 1)

	IF (@City IS NULL ) 
		RAISERROR (N'City is empty.', 16, 1)
		
	IF (@PostCode NOT LIKE '[0-9][0-9]-[0-9][0-9][0-9]' ) 
		RAISERROR (N'PostCode format is incorrect.', 16, 1)

	INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode)
	VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Address, @City, @PostCode)

GO

BEGIN TRY
	-- PATTERN (REPLACE # WITH CORRECT VALUE)
	-- EXEC InsertUser @FirstName = #, @LastName = #, @Email = #, @PhoneNumber = #, @Address = #, @City = #, @PostCode = #
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH