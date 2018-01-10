DROP table adr7dev_mateusz.Users
DROP table adr7dev_mateusz.ItemCategories

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
IdCategories INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
CategoryName VARCHAR CHECK (CategoryName LIKE '[A-Z]%') NOT NULL,
ParentCategory INT not null,
CONSTRAINT FKCategoryItem FOREIGN KEY (ParentCategory) REFERENCES ItemCategories(IdCategories),
)