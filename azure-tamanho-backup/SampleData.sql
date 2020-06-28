/*
use master;
alter database BakTest set restricted_user with rollback immediate;
drop database BakTest
*/
CREATE DATABASE BakTest;
GO

USE BakTest;
GO

CREATE TABLE BigRow(id int not null identity primary key, txt char(7000), pageNum int, extentNum as (pageNum/8)+1);

-- 20 mil páginas!
insert into BigRow(txt)
select top 20000 newid() from sys.all_objects a,sys.all_objects b;

-- Atualiza cada linha com as informações das páginas!
update bigRow set pageNum = CONVERT(int,convert(binary(4),reverse(substring(%%physloc%%,1,4))))

--> SETUP PROCESS MONITOR
	-- sqlserve.exe
	-- path BakTest

-- Criar credenciais para o backup!
CREATE CREDENTIAL [https://ACCOUNT.blob.core.windows.net/CONTAINER]
with identity = 'SHARED ACCESS SIGNATURE'
,secret = 'TOKEN_HERE'