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



	DELETE FROM Items WHERE IdItem = 1 

	



	