/*
use master;
alter database BigBakTest set restricted_user with rollback immediate;
drop database BigBakTest

-- ENABLE IFI
*/
CREATE DATABASE BigBakTest;
GO

ALTER DATABASE BigBakTest SET DELAYED_DURABILITY = Forced;

USE BigBakTest;
GO

CREATE TABLE BigRow(id int not null identity primary key, txt char(7000), pageNum int, extentNum as (pageNum/8)+1);

-- 5gb = 600k páginas!
insert into BigRow(txt)
select top 600000 newid() from sys.all_objects a,sys.all_objects b;

-- shrink log!
checkpoint;
dbcc shrinkfile(2,500)

