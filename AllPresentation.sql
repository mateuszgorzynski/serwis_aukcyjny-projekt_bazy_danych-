-- WSZYSTKIE TABELE
-- ----------------------------------------------------------
SELECT * FROM Auctions
SELECT * FROM ItemCategories
SELECT * FROM Items
SELECT * FROM Opinions
SELECT * FROM Transactions
SELECT * FROM Users


-- WIDOK
-- ----------------------------------------------------------
-- Wy�wietla tylko przedmioty, kt�re mo�na jeszcze kupi�
-- lub zalicytowa�.

SELECT * FROM ActiveAuctions


-- PROCEDURA RAPORTUJ�CA
-- ----------------------------------------------------------
-- Wy�wietla przedmioty, kt�re zosta�y zakupione.

BEGIN TRY
	EXEC RaportAuctions @IdItem = 2
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA WSTAWIAJ�CA
-- ----------------------------------------------------------
-- Dodawanie nowego u�ytkownika do bazy danych.

BEGIN TRY
	--EXEC InsertUser @FirstName = 'Adam', @LastName = 'Adamiak', @Email = 'adamadamiak@mail.pl', @PhoneNumber = '123456789', @Address = 'ul. Zwirowa 2', @City = 'Warszawa', @PostCode = '42-424', @IsBlocked = 0
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA USUWAJ�CA
-- ----------------------------------------------------------
-- Usuwanie opinii odnosz�cej si� do transakcji.

SELECT * FROM Opinions

BEGIN TRY
	-- EXEC DeleteOpinion @IdOpinion = 2
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA MODYFIKUJ�CA
-- ----------------------------------------------------------
-- Modyfikowanie danych personalnych u�ytkownika.

SELECT * FROM Users

BEGIN TRY
	-- EXEC ChangeFullAdressUser @IdUser = 1, @Address = 'ul. RazDwaTrzy 3', @City = 'Koziolkowo', @PostCode = '12-345'
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA OPERUJ�CA NA TABELI TRANSAKCYJNEJ
-- ----------------------------------------------------------
-- Licytowanie przedmiotu.

SELECT * FROM Items WHERE IdItem = 5
SELECT * FROM Auctions WHERE IdItem = 5

BEGIN TRY
	EXEC InsertAuctions @IdItem = 5, @IdBuyer = 2, @Price = 2000
END TRY
BEGIN CATCH
	SELECT  ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA OPERUJ�CA NA TABELI TRANSAKCYJNEJ (2)
-- ----------------------------------------------------------
-- Przerzucanie zamkni�tej aukcji do tabeli transakcyjnej.

SELECT * FROM Auctions
SELECT * FROM Transactions

BEGIN TRY
	EXEC InsertAuctionToTransactions @IdItem = 5
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

SELECT * FROM Auctions
SELECT * FROM Transactions

-- FUNKCJA
-- ----------------------------------------------------------
-- Wy�wietla �redni zarobek u�ytkownika na zako�czonych
-- ofertach (kt�re ju� widniej� w tabeli transakcyjnej).

SELECT *, dbo.FunctionAverageProfit(IdUser) as AverageProfit FROM Users
SELECT * FROM Transactions

-- WYZWALACZ
-- ----------------------------------------------------------
-- Zamiast kasowania u�ytkownika nast�puje jego zablokowanie.

SELECT * FROM Users
DELETE FROM Users WHERE IdUser = 2