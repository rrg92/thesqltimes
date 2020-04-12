/***************
	MÉTODO 02 - NÍVEL MÉDIO
*****************/


-- Adicione um filegroup pro banco onde está sua tabela!
ALTER DATABASE MeuBanco ADD FILEGROUP MinhaTabela;

-- Adicione um arquivo para seu novo filegroup!
ALTER DATABASE MeuBanco ADD FILE (NAME='Arquivo_MinhaTabela', FILENAME = 'C:\temp\Arquivo_MinhaTabela.ndf') TO FILEGROUP MinhaTabela

-- Mude sua tabela para o novo filegroup... Você pode recriar (ou criar) o indice cluster no novo filegroup para moê-la...
CREATE CLUSTERED INDEX  ixcluster ON MeuBanco..MinhaTabela(c) ON MinhaTabela /*WITH DROP_EXISTING*/

-- Faça o backup do filegroup!
BACKUP DATABASE MeuBanco FILEGROUP='MinhaTabela' TO DISK = 'C:\Temp\MinhaTabela.bak'  

-- Pronto, você fez um backup da tabela que queria com BACKUP DATABASE.


/*************************************************
   ____    ____
  /	   |  |    |
 /	   |  |    |
/___   |  |____|
   |   |   
   |   |   ABRIL
   |   |
   |   |
   |   |
   |   |
   |   |

			#AprilFoolsDay
		www.thesqltimes.com

*************************************************/