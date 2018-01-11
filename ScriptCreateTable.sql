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