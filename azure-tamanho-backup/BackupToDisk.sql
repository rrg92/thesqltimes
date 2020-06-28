USE BakTest
GO

-- (olhar no procmon)
	select name,type_desc,size,UsedPages = FILEPROPERTY(name,'SpaceUsed') from sys.database_files

-- Defaults... full data with no gaps!
	BACKUP DATABASE BakTest TO DISK = 'T:\BakTest.bak' with init,format;

-- Small buffer... full data with no gaps!
	BACKUP DATABASE BakTest TO DISK = 'T:\BakTest.bak' WITH init,format,BUFFERCOUNT = 1

-- Large buffer... full data with no gaps!
	BACKUP DATABASE BakTest TO DISK = 'T:\BakTest.bak' WITH init,format,BUFFERCOUNT = 1000

-- Smallest transer size... full data with no gaps!
	BACKUP DATABASE BakTest TO DISK = 'T:\BakTest.bak' WITH init,format,BUFFERCOUNT = 1,MAXTRANSFERSIZE = 65536

-- Greatest transer size... full data with no gaps!
	BACKUP DATABASE BakTest TO DISK = 'T:\BakTest.bak' WITH init,format,BUFFERCOUNT = 1,MAXTRANSFERSIZE = 4194304

	-- gaps each 1!
	select *,extentNum%3 from bigrow
	delete from BigRow where extentNum%2 = 0;
	checkpoint

		 -- repeat all!

	-- gaps each 2!
	delete from BigRow where extentNum%3 = 0;
	checkpoint
		
		 -- repeat all again!!

