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

select * from Users