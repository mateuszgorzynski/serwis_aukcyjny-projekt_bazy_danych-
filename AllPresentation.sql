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
-- Wyœwietla tylko przedmioty, które mo¿na jeszcze kupiæ
-- lub zalicytowaæ.

SELECT * FROM ActiveAuctions


-- PROCEDURA RAPORTUJ¥CA
-- ----------------------------------------------------------
-- Wyœwietla przedmioty, które zosta³y zakupione.

BEGIN TRY
	EXEC RaportAuctions @IdItem = 2
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA WSTAWIAJ¥CA
-- ----------------------------------------------------------
-- Dodawanie nowego u¿ytkownika do bazy danych.

BEGIN TRY
	--EXEC InsertUser @FirstName = 'Adam', @LastName = 'Adamiak', @Email = 'adamadamiak@mail.pl', @PhoneNumber = '123456789', @Address = 'ul. Zwirowa 2', @City = 'Warszawa', @PostCode = '42-424', @IsBlocked = 0
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA USUWAJ¥CA
-- ----------------------------------------------------------
-- Usuwanie opinii odnosz¹cej siê do transakcji.

SELECT * FROM Opinions

BEGIN TRY
	-- EXEC DeleteOpinion @IdOpinion = 2
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA MODYFIKUJ¥CA
-- ----------------------------------------------------------
-- Modyfikowanie danych personalnych u¿ytkownika.

SELECT * FROM Users

BEGIN TRY
	-- EXEC ChangeFullAdressUser @IdUser = 1, @Address = 'ul. RazDwaTrzy 3', @City = 'Koziolkowo', @PostCode = '12-345'
END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


-- PROCEDURA OPERUJ¥CA NA TABELI TRANSAKCYJNEJ
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


-- PROCEDURA OPERUJ¥CA NA TABELI TRANSAKCYJNEJ (2)
-- ----------------------------------------------------------
-- Przerzucanie zamkniêtej aukcji do tabeli transakcyjnej.

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
-- Wyœwietla œredni zarobek u¿ytkownika na zakoñczonych
-- ofertach (które ju¿ widniej¹ w tabeli transakcyjnej).

SELECT *, dbo.FunctionAverageProfit(IdUser) as AverageProfit FROM Users
SELECT * FROM Transactions

-- WYZWALACZ
-- ----------------------------------------------------------
-- Zamiast kasowania u¿ytkownika nastêpuje jego zablokowanie.

SELECT * FROM Users
DELETE FROM Users WHERE IdUser = 2