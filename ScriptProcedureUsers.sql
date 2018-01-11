IF OBJECT_ID('...','...') IS NOT NULL
DROP PROCEDURE InsertUser
GO

CREATE PROCEDURE InsertUser (
        @FirstName VARCHAR(250) ,
        @LastName VARCHAR(250) ,
        @Email VARCHAR(254) ,
        @PhoneNumber VARCHAR(9),
		@Address VARCHAR(250),
		@City VARCHAR(250),
		@PostCode VARCHAR(6)
		)
AS

		--declare IdUser
		DECLARE @IdUser INT
		 
                 -- verification of internal parameters --
        --1. If someone is empty or wrong written -> call the error and finish the procedur
        IF (@FirstName IS NULL)     
		BEGIN
                RAISERROR (N'First Name is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @FirstName
                )
        END

		IF  (@LastName IS NULL)  
		BEGIN
                RAISERROR (N'LAST Name is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @LastName
                )
        END
		IF (@Email NOT LIKE '%_@%_.__%' ) 
		BEGIN
                RAISERROR (N'Address Email is empty, or wrong written . %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Email
                )
        END
		IF EXISTS (SELECT * from adr7dev_mateusz.Users where Email = @Email)
		BEGIN
                RAISERROR (N'Address Email is empty, or wrong written . %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Email
                )
        END


		IF (@Address IS NULL ) 
		BEGIN
                RAISERROR (N'Address is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @Address
                )
        END
		IF (@City IS NULL ) 
		BEGIN
                RAISERROR (N'City is empty. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @City
                )
        END
		

		IF (@PostCode NOT LIKE '[0-9][0-9]-[0-9][0-9][0-9]' ) 
		BEGIN
                RAISERROR (N'PostCode is empty, or wrong written. %s', -- Message text.
                        16, -- Severity, severity 11-19 will cause execution to jump to CATCH block
                        1, -- State
                        @PostCode
                )
        END
		 --5. Set New Iduser wowowowowowowow
        SET @IdUser = (SELECT ISNULL(MAX(IdUser),0)+1 FROM adr7dev_mateusz.Users)

		--7. Wstaw nowego pracownika:
        INSERT INTO adr7dev_mateusz.Users(FirstName,LastName,Email, PhoneNumber,[Address],City,PostCode)
        VALUES (@FirstName, @LastName, @Email, @PhoneNumber,@Address,@City,@PostCode)



GO






BEGIN TRY
        --EXEC InsertUser @FirstName = 'Mateusz', @LastName='Górzyński', @Email='matgor9@st.amu.edu.pl', @PhoneNumber='123456789', @Address='Piątkowska 80 B', @City ='Poznań', @PostCode='60-649'
		EXEC InsertUser @FirstName = 'Adrian', @LastName='Parniewicz', @Email='adrpar1@st.amu.edu.pl', @PhoneNumber='987654321', @Address='Ściegiennego 38', @City ='Poznań', @PostCode='60-134'  

END TRY
BEGIN CATCH
        SELECT  ERROR_NUMBER() AS ErrorNumber ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH



select * from adr7dev_mateusz.Users