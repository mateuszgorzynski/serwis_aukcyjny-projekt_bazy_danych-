DROP TABLE adr7dev_mateusz.Auctions
DROP TABLE adr7dev_mateusz.Items
DROP TABLE adr7dev_mateusz.Users
DROP TABLE adr7dev_mateusz.ItemCategories

CREATE TABLE Users(
IdUser INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FirstName VARCHAR CHECK (FirstName LIKE '[A-Z]%') NOT NULL,
LastName VARCHAR CHECK (LastName LIKE '[A-Z]%') NOT NULL,
Email VARCHAR CHECK (Email LIKE '%_@%_._%') NOT NULL,
PhoneNumber VARCHAR(6) CHECK (PhoneNumber LIKE '%[^0-9]%') NOT NULL,
Adress VARCHAR NOT NULL,
City VARCHAR CHECK (City LIKE '[A-Z]%'),
PostCode VARCHAR(6) CHECK (PostCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]%') NOT NULL
)
CREATE TABLE ItemCategories(
IdCategory INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
CategoryName VARCHAR CHECK (CategoryName LIKE '[A-Z]%') NOT NULL,
ParentCategory INT NOT NULL,
CONSTRAINT FKParentCategory FOREIGN KEY (ParentCategory) REFERENCES ItemCategories(IdCategory),
)
CREATE TABLE Items(
IdItem INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ItemName VARCHAR NOT NULL,
ItemDescription TEXT,
Category INT NOT NULL,
Seller INT NOT NULL,
TheType BIT NOT NULL,
Price INT NOT NULL,
MinRaise INT NOT NULL,
FinishDate DATETIME NOT NULL,
CONSTRAINT FKCategory FOREIGN KEY (Category) REFERENCES ItemCategories(IdCategory),
CONSTRAINT FKSeller FOREIGN KEY (Seller) REFERENCES Users(IdUser),
)
CREATE TABLE Auctions(
IdAuction INT PRIMARY KEY IDENTITY(1,1),
IdItem INT NOT NULL,
IdBuyer INT NOT NULL,
Price INT NOT NULL,
BiddingDate DATETIME NOT NULL,
CONSTRAINT FKItem FOREIGN KEY (IdItem) REFERENCES Items(IdItem),
CONSTRAINT FKBuyer FOREIGN KEY (IdBuyer) REFERENCES Users(IdUser),
)