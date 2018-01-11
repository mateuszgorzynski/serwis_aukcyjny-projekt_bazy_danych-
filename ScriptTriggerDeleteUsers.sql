CREATE TRIGGER DeleteUsers ON users
INSTEAD OF DELETE
AS
     PRINT 'User '+USER_NAME()+' has tried to remove record.';
     SELECT IdUser FROM deleted;

	 PRINT 'User '+USER_NAME()+' has tried to add record.';
	 SELECT IdUser FROM deleted;

GO

	DELETE FROM Users WHERE IdUser =1;


	SELECT * FROM Users