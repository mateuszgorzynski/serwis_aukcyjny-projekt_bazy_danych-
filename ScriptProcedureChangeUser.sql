IF OBJECT_ID('ChangeEmailUser','P') IS NOT NULL
	DROP PROCEDURE ChangeEmailUser
GO

CREATE PROCEDURE ChangeEmailUser(
	@IdUser INT,
	@Email VARCHAR(254)
	
	)
AS
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser =@IdUser ) 
			RAISERROR (N'User with given IdUser does not exist..', 16, 1)

	IF  EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser =@IdUser AND Email = @Email ) 
			RAISERROR (N'You Written this same E-mail', 16, 1)

	IF (@Email NOT LIKE '%_@%_.__%' ) 
		RAISERROR (N'Email is incorrect or empty.', 16, 1)

	UPDATE adr7dev_mateusz.Users SET Email =@Email WHERE IdUser = @IdUser

GO

IF OBJECT_ID('ChangePhonenumberUser','P') IS NOT NULL
	DROP PROCEDURE ChangePhonenumberUser
GO

CREATE PROCEDURE ChangePhonenumberUser(
	@IdUser INT,
	@PhoneNumber VARCHAR(9)
	
	)
AS
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser =@IdUser ) 
			RAISERROR (N'User with given IdUser does not exist..', 16, 1)

	IF (@PhoneNumber NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) 
		RAISERROR (N'PhoneNumber format is incorrect.', 16, 1)

	IF  EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser =@IdUser AND PhoneNumber = @PhoneNumber ) 
			RAISERROR (N'You Written this same Phone Number ', 16, 1)

	UPDATE adr7dev_mateusz.Users SET PhoneNumber = @PhoneNumber WHERE IdUser = @IdUser

GO

IF OBJECT_ID('ChangeFullAdressUser','P') IS NOT NULL
	DROP PROCEDURE ChangeFullAdressUser
GO

CREATE PROCEDURE ChangeFullAdressUser(
	@IdUser INT,
	@Address VARCHAR(250),
	@City VARCHAR(250),
	@PostCode VARCHAR(250)
	
	)
AS
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser =@IdUser ) 
			RAISERROR (N'User with given IdUser does not exist..', 16, 1)

	IF (@Address IS NULL ) 
		RAISERROR (N'Address is empty.', 16, 1)

	IF (@City IS NULL ) 
		RAISERROR (N'City is empty.', 16, 1)


	IF (@PostCode NOT LIKE '[0-9][0-9]-[0-9][0-9][0-9]' ) 
		RAISERROR (N'PostCode format is incorrect.', 16, 1)

	UPDATE adr7dev_mateusz.Users SET [Address] = @Address, City=@City, PostCode = @PostCode WHERE IdUser = @IdUser

GO



BEGIN TRY
	
	--EXEC ChangeEmailUser @IdUser = 1, @Email = 'm.gorzynski96@gmail.com'
	--EXEC ChangePhonenumberUser @IdUser = 1, @PhoneNumber = '123456798'
	Exec ChangeFullAdressUser @IdUser = 1, @Address = 'RazDwaTrzy 3', @City = 'Koziolkowo', @PostCode = '12-345'
	
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

select * from Users