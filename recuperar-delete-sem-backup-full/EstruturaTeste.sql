USE master
GO

-- Crie o banco de teste!
	IF DB_ID('TheSqlTimes') IS NOT NULL 
		EXEC('ALTER DATABASE TheSqlTimes SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE TheSqlTimes');

	CREATE DATABASE TheSqlTimes;
	GO

-- Recovery Model FULL
	ALTER DATABASE TheSqlTimes SET RECOVERY FULL;

-- Tabela e dados de teste!
	USE TheSqlTimes
	GO

	DROP TABLE IF EXISTS dbo.Cliente;
	CREATE TABLE dbo.Cliente (
			Id int  PRIMARY KEY IDENTITY
			,Nome varchar(100) NOT NULL
			,Idade tinyint
			,Tipo char(1) NULL
			,DataCadastro datetime 
			,Codigo bigint
			,Sobrenome varchar(100)  NULL
		)

-- Inserindo 10 mil linhas de teste!
INSERT INTO 
	dbo.Cliente
SELECT TOP 10000
	Nome	= CHOOSE(T.N,'Rodrigo','Natalia','Miguel','Fulano','Beltrano','Maria','Joao') 
	,Idade	= T.R%60 + 1
	,Tipo	= CHOOSE(T.N2,'A','B',NULL)
	,DataCadastro	= DATEFROMPARTS( ((T.N*100)%29) + 1992, ((T.N*100)%12) + 1 ,((T.N*100)%27) + 1)
	,Codigo	= T.R
	,Sobrenome = CHOOSE(T.N2,'Gomes','Ribeiro','Benedita')
				
FROM 
	sys.all_objects O1
	CROSS JOIN
	sys.all_objects O2
	CROSS APPLY (
		SELECT 
			N	= R.R%7 + 1
			,N2 = R.R2%4 + 1
			,R.*
		FROM
			(
				SELECT 
					R	= CONVERT(int,ABS(CHECKSUM(O1.object_id,O2.object_id,rand()*2000)))
					,R2	= CONVERT(int,ABS(CHECKSUM(O1.object_id,O2.object_id,rand()*1000)))
			) R
	) T

-- Faz backup FULL para o nada!
BACKUP  DATABASE TheSqlTimes TO DISK = 'nul';

-- Faz um backup de log
BACKUP  LOG TheSqlTimes TO DISK = 'nul';