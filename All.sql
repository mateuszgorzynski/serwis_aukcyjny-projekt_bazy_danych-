DROP TABLE adr7dev_mateusz.Opinions
DROP TABLE adr7dev_mateusz.Transactions
DROP TABLE adr7dev_mateusz.Auctions
DROP TABLE adr7dev_mateusz.Items
DROP TABLE adr7dev_mateusz.Users
DROP TABLE adr7dev_mateusz.ItemCategories

CREATE TABLE Users (
	IdUser INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	FirstName VARCHAR(250) CHECK (FirstName LIKE '[A-Z]%') NOT NULL,
	LastName VARCHAR(250) CHECK (LastName LIKE '[A-Z]%') NOT NULL,
	Email VARCHAR(254) CHECK (Email LIKE '%_@%_._%') NOT NULL,
	PhoneNumber VARCHAR(9) CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') NOT NULL,
	[Address] VARCHAR(250) NOT NULL,
	City VARCHAR(250) CHECK (City LIKE '[A-Z]%'),
	PostCode VARCHAR(6) CHECK (PostCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]%') NOT NULL,
	IsBlocked BIT DEFAULT(0)

)

CREATE TABLE ItemCategories (
	IdCategory INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	[Name] VARCHAR(250) CHECK ([Name] LIKE '[A-Z]%') NOT NULL,
	ParentCategory INT DEFAULT(NULL),

	CONSTRAINT FKItemCategoriesParentCategory FOREIGN KEY (ParentCategory) REFERENCES ItemCategories(IdCategory),
)

CREATE TABLE Items (
	IdItem INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	[Name] VARCHAR(250) NOT NULL,
	[Description] TEXT,
	Category INT NOT NULL,
	Seller INT NOT NULL,
	[Type] BIT NOT NULL,
	Price INT NOT NULL,
	MinRaise INT NULL,
	FinishDate DATETIME NOT NULL,
	IsBlocked BIT DEFAULT(0)

	CONSTRAINT FKItemsCategory FOREIGN KEY (Category) REFERENCES ItemCategories(IdCategory),
	CONSTRAINT FKItemsSeller FOREIGN KEY (Seller) REFERENCES Users(IdUser),
)
CREATE TABLE Auctions (
	IdAuction INT PRIMARY KEY IDENTITY (1,1),
	IdItem INT NOT NULL,
	IdBuyer INT NOT NULL,
	Price INT NOT NULL,
	BiddingDate DATETIME NOT NULL,

	CONSTRAINT FKAuctionsItem FOREIGN KEY (IdItem) REFERENCES Items(IdItem),
	CONSTRAINT FKAuctionsBuyer FOREIGN KEY (IdBuyer) REFERENCES Users(IdUser),
)

CREATE TABLE Transactions(
	IdTransaction INT PRIMARY KEY IDENTITY (1,1),
	IdItem INT NOT NULL,
	IdBuyer INT NOT NULL,
	Price INT NOT NULL,
	SendDate DATE NOT NULL,

	CONSTRAINT FKTransactionsItem FOREIGN KEY (IdItem) REFERENCES Items(IdItem),
	CONSTRAINT FKTransactionsIdBuyer FOREIGN KEY (IdBuyer) REFERENCES Users(IdUser)
)

CREATE TABLE Opinions (
	IdOpinion INT PRIMARY KEY IDENTITY (1,1),
	IdSeller INT NOT NULL,
	IdTransaction INT NOT NULL,
	Note BIT NOT NULL,
	[Description] TEXT NOT NULL,

	CONSTRAINT FKOpinionsIdSeller FOREIGN KEY (IdSeller) REFERENCES Users(IdUser),
	CONSTRAINT FKOpinionsIdTransaction FOREIGN KEY (IdTransaction) REFERENCES Transactions(IdTransaction)
)

---------------------------------------------------------------
---------------------------------------------------------------

-- Users

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Jan', 'Kowalski', 'jankowalski@mail.pl', 100200300, 'ul. Poziomkowa 5', 'Gdañsk', '70-700', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Tomasz', 'Nowak', 'tnowakk@zmail.uk', 110250306, 'ul. D³uga 11', 'Warszawa', '40-555', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Aleksandra', 'Kaczmarek', 'akaczmarek@mail.pl', 448651247, 'ul. Poznañska 43', 'Zielona Góra', '88-100', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Patryk', 'Kwiatkowski', 'patrykkwiat@xmail.pl', 578987145, 'ul. Ruchliwa 63', 'Pabianice', '84-420', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Anna', 'Borowska', 'aniaborowska@mail.pl', 674879254, 'ul. Krótka 97', 'Koszalin', '44-120', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Micha³', 'WoŸniak', 'misiekwozniak@email.pl', 874621478, 'ul. Powstañców 74', 'Inowroc³aw', '95-120', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Karolina', 'Miros³awska', 'kmirosl467@mail.pl', 674587478, 'os. Króla Artura 74B/3', 'Kraków', '33-120', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Antoni', 'Kaczyñski', 'antoine213@mail.com', 944451240, 'os. Po³udnie 12/3', 'Olsztyn', '73-150', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Samanta', 'Wielb³¹d', 'sambigerror5@mail.pl', 472137547, 'ul. Kaktusowa 10', 'Mi³os³aw', '45-789', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Ewa', 'Bywa³a', 'ewamusial@mail.eu', 931451550, 'ul. Wiatrakowa 15', 'Nowy S¹cz', '78-745', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Leon', 'Taczka', 'leo112@mail.pl', 237451240, 'ul. Œniegowa 7', 'Suwa³ki', '58-111', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Gerwazy', 'Zeberko', 'gzeb112@mail.pl', 111222333, 'ul. Pomarañczowa 118', 'Przemyœl', '14-785', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Hanna', 'Lisek', 'hanalisek2@mail.pl', 552333240, 'ul. Jana Paw³a II', 'Pi³a', '78-444', 0)

INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
VALUES ('Cezary', 'Werner', 'czarekwerner@mail.pl', 344874698, 'ul. ¯arówkowa 87', 'Pi³a', '78-444', 0)

-- ItemCategories

INSERT INTO adr7dev_mateusz.ItemCategories([Name])
VALUES ('Elektronika')

INSERT INTO adr7dev_mateusz.ItemCategories([Name], ParentCategory)
VALUES ('Telefony', 1)

INSERT INTO adr7dev_mateusz.ItemCategories([Name], ParentCategory)
VALUES ('Laptopy', 1)

INSERT INTO adr7dev_mateusz.ItemCategories([Name])
VALUES ('Moda')

INSERT INTO adr7dev_mateusz.ItemCategories([Name])
VALUES ('Rozrywka')

-- Items

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Nokia 3310 OKAZJA', 'Solidny telefon w rozs¹dnej cenie!', 2, 10, 0, 150, 0, '2018-01-01')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Samsung Galaxy S8', 'Poczuj nowoczesn¹ technologiê na w³asnej skórze.', 2, 10, 0, 4000, 0, '2018-01-07')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('iPhone 8 64GB', 'Amazing...', 2, 12, 1, 2500, 10, '2018-01-10')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Lenovo 320-15', 'Intel Core i5, 1TB HDD, 250GB SSD, 16GB RAM', 3, 11, 0, 3900, 0, '2018-01-25')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Dell XPS 13', 'Intel Core i7 - 512GB SSD - 16GB RAM', 3, 11, 1, 1800, 50, '2018-02-25')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('T-shirt mêski rozmiar M', 'kolor czerwony, nowy! okazja!', 4, 9, 0, 79, 0, '2018-01-05')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Skarpety mêskie 43-46 5x', 'Kolor czarny i bia³y', 4, 9, 0, 14, 0, '2018-01-06')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Bluza szara mêska - rozmiar L', 'Okazja!', 4, 9, 0, 90, 0, '2018-02-10')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Buty Nike Air Force 1 MID 44', 'Kolor bia³y', 4, 9, 0, 350, 0, '2018-02-02')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Buty Jim Rickey Chop 42', 'Kolor bia³y', 4, 9, 0, 390, 0, '2018-02-16')

INSERT INTO adr7dev_mateusz.Items([Name], [Description], Category, Seller, [Type], Price, MinRaise, FinishDate)
VALUES ('Laptop HP ZXY 15', 'Intel Core i7, 1TB HDD, 120GB SSD, 16GB RAM', 3, 11, 1, 1000, 10, '2018-02-15')

-- Transactions

INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
VALUES (1, 2, 150, '2018-01-03')

INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
VALUES (2, 3, 4000, '2018-01-08')

INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
VALUES (2, 2, 350, '2018-01-11')

-- Auctions

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (3, 1, 2500, '2018-01-02 16:03')

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (3, 2, 3000, '2018-01-09 21:37')

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (5, 1, 1800, '2018-01-11 12:08')

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (5, 2, 1850, '2018-01-11 13:23')

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (5, 3, 1900, '2018-01-11 14:22')

INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
VALUES (5, 2, 2000, '2018-01-11 16:38')

-- Opinions

INSERT INTO adr7dev_mateusz.Opinions(IdSeller, IdTransaction, Note, [Description])
VALUES (10, 1, 1, 'Dobry produkt i szybka wysylka')

INSERT INTO adr7dev_mateusz.Opinions(IdSeller, IdTransaction, Note, [Description])
VALUES (10, 2, 0, 'Partacz! Paczka póŸno przysz³a i w z³ym stanie, nie polecam!!11')

---------------------------------------------------------------
---------------------------------------------------------------

-- PROCEDURES

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

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND Seller != @IdBuyer)
		RAISERROR (N'The buyer can not be the item seller.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND FinishDate > GETDATE())
		RAISERROR (N'User can not bid after FinishDate.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND [Type] = 1)
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
		SET @CurrentMax = (SELECT MAX(Price) FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem)

		IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Auctions WHERE Price = @CurrentMax AND IdBuyer != @IdBuyer)
			RAISERROR (N'User can not beat its own bid.', 16, 1)

		IF (@Price - (SELECT Price FROM adr7dev_mateusz.Auctions WHERE Price = @CurrentMax)) < @MinRaise
			RAISERROR (N'Minimal raise is required to beat the bid.', 16, 1)			
	END

	INSERT INTO adr7dev_mateusz.Auctions(IdItem, IdBuyer, Price, BiddingDate)
	VALUES (@IdItem, @IdBuyer, @Price, GETDATE())

GO

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

IF OBJECT_ID('InsertOpinion', 'P') IS NOT NULL
	DROP PROCEDURE InsertOpinion
GO

CREATE PROCEDURE InsertOpinion (
	@IdSeller INT,
	@IdTransaction INT,
	@Note BINARY,
	@Decsription TEXT
	)
AS

	IF (@Note IS NULL)     
		RAISERROR (N'Note is empty.', 16,  1)
		
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdSeller)
		RAISERROR (N'User with given IdUser does not exist.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Transactions WHERE IdTransaction = @IdTransaction)
		RAISERROR (N'Transaction with given IdTransaction does not exist.', 16,  1)

	IF NOT EXISTS 
	(SELECT * FROM adr7dev_mateusz.Transactions t 
	INNER JOIN adr7dev_mateusz.Items i 
	ON i.IdItem = t.IdItem 
	WHERE IdTransaction = @IdTransaction AND Seller = @IdSeller)
		RAISERROR (N'IdSeller must be authentical seller of transaction which id is IdTransaction.', 16, 1)

	INSERT INTO adr7dev_mateusz.Opinions(IdSeller, IdTransaction, Note, Description)
	VALUES (@IdSeller, @IdTransaction, @Note, @Decsription)

GO

IF OBJECT_ID('InsertTransactions', 'P') IS NOT NULL
	DROP PROCEDURE InsertTransactions
GO

CREATE PROCEDURE InsertTransactions (
	@IdItem INT,
	@IdBuyer INT,
	@Price BINARY,
	@SendDate DATE
	)
AS

	IF (@Price IS NULL)     
		RAISERROR (N'Price is empty.', 16,  1)

	IF (@SendDate IS NULL)     
		RAISERROR (N'SendDate is empty.', 16,  1)
		
	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'Item with given IdItem does not exist.', 16, 1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Users WHERE IdUser = @IdBuyer)
		RAISERROR (N'User with given IdUser does not exist.', 16,  1)

	INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
	VALUES (@IdItem, @IdBuyer, @Price, @SendDate)

GO

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
	@PostCode VARCHAR(6),
	@IsBlocked BINARY
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

	INSERT INTO adr7dev_mateusz.Users(FirstName, LastName, Email, PhoneNumber, [Address], City, PostCode, IsBlocked)
	VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @Address, @City, @PostCode, @IsBlocked)

GO

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

IF OBJECT_ID('InsertAuctionToTransactions', 'P') IS NOT NULL
	DROP PROCEDURE InsertAuctionToTransactions
GO

CREATE PROCEDURE InsertAuctionToTransactions (
	@IdItem INT
	)
AS

	IF (@IdItem IS NULL)
		RAISERROR (N'IdItem can not be empty.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem)
		RAISERROR (N'Item with given IdItem does not exits.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND IsBlocked = 0)
		RAISERROR (N'Item can not be blocked.', 16,  1)

	IF NOT EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE IdItem = @IdItem AND [Type] = 1)
		RAISERROR (N'Item must be auction type.', 16,  1)

	IF EXISTS (SELECT * FROM adr7dev_mateusz.Items WHERE FinishDate < GETDATE())
	BEGIN
	
		IF EXISTS (SELECT * FROM adr7dev_mateusz.Transactions WHERE IdItem = @IdItem)
		BEGIN
			RAISERROR (N'The auction is already in transactions.', 16,  1)
		END

		ELSE

		BEGIN
			INSERT INTO adr7dev_mateusz.Transactions(IdItem, IdBuyer, Price, SendDate)
			SELECT TOP 1 IdItem, IdBuyer, Price, GETDATE() as SendDate FROM adr7dev_mateusz.Auctions WHERE IdItem = @IdItem ORDER BY Price DESC
		END
	END

GO

---------------------------------------------------------------
---------------------------------------------------------------

-- TRIGGERS

IF OBJECT_ID('DeleteRecords') IS NOT NULL
	DROP TRIGGER DeleteRecords
GO

CREATE TRIGGER DeleteRecords ON Items
AFTER  DELETE
AS
     PRINT 'User '+USER_NAME()+' has tried to remove record.';
     SELECT IdItem,[Name] FROM deleted;

	 PRINT 'User '+USER_NAME()+' has tried to add record.';
	 SELECT IdItem,[Name] FROM deleted;
     

	 UPDATE Items SET IsBlocked = 1 WHERE IdItem = 1 ;

     ROLLBACK;
GO

IF OBJECT_ID('DeleteUsers') IS NOT NULL
	DROP TRIGGER DeleteUsers
GO

CREATE TRIGGER DeleteUsers ON users
INSTEAD OF DELETE
AS
     PRINT 'User '+USER_NAME()+' has tried to remove record.';
     SELECT IdUser FROM deleted;

	 PRINT 'User '+USER_NAME()+' has tried to add record.';
	 SELECT IdUser FROM deleted;

	 UPDATE Users SET IsBlocked = 1 WHERE IdUser = 1 ;

GO

---------------------------------------------------------------
---------------------------------------------------------------

-- VIEW

IF OBJECT_ID('ActiveAuctions') IS NOT NULL
	DROP VIEW ActiveAuctions
GO

CREATE VIEW ActiveAuctions
AS
   	SELECT * 
	FROM adr7dev_mateusz.Items i 
	WHERE (NOT EXISTS 
		(SELECT * 
		FROM adr7dev_mateusz.Transactions
		WHERE IdItem = i.IdItem)
	) AND FinishDate > GETDATE() AND IsBlocked = 0
GO


---------------------------------------------------------------
---------------------------------------------------------------

-- FUNCTIONS

IF OBJECT_ID('FunctionAverageProfit') IS NOT NULL
	DROP FUNCTION dbo.FunctionAverageProfit
GO

CREATE FUNCTION dbo.FunctionAverageProfit
	(@IdUser INT)
	RETURNS INT
AS
BEGIN
	RETURN (SELECT AVG(t.Price) FROM adr7dev_mateusz.Transactions t INNER JOIN adr7dev_mateusz.Items i ON t.IdItem = i.IdItem WHERE Seller = @IdUser)
END
GO

IF OBJECT_ID('FunctionGetItemsByCategory') IS NOT NULL
	DROP FUNCTION dbo.FunctionGetItemsByCategory
GO

CREATE FUNCTION dbo.FunctionGetItemsByCategory
	(@IdCategory INT)
	RETURNS TABLE
AS
	RETURN SELECT * FROM adr7dev_mateusz.Items WHERE Category = @IdCategory AND IsBlocked = 0 AND FinishDate > GETDATE()
GO