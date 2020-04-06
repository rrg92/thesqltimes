USE TheSqlTimes


/*
	-- Guardar pra ver que recuperou certinho...
	select * into dbo.ClienteOriginal from dbo.Cliente
*/

-- 16h25
DELETE FROM dbo.Cliente;

-- 16h30 -backup de log!
BACKUP LOG  TheSqlTimes TO DISK = 'T:\Backup16h30.trn' WITH INIT,FORMAT;
