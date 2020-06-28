-- Backup with 64K to trigger error.
-- 5GB/64k blocks  = 81000 blocks

BACKUP DATABASE BigBakTest TO URL  = 'https://thest.blob.core.windows.net/sqlbackup/BakTest.bak'
WITH MAXTRANSFERSIZE = 65536