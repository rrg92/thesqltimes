/***************
	M�TODO 01 - N�VEL F�CIL
*****************/

-- Cria um banco!
CREATE DATABASE �BackupTabelaCliente;

-- Salva a tabela desejada. Lembre-se de se de se conectar no banco onde est� a tabela desejada
SELECT * INTO BackupTabelaCliente..Cliente FROM MeuBanco.dbo.MinhaTabela

-- Agora, com o comando BACKUP DATABASE, voc� faz o backup da base.
BACKUP DATABASE BackupTabelaCliente TO DISK �= 'C:\temp\BackupTabelaCliente.bak'

-- Pronto, voc� fez um backup da tabela que queria com BACKUP DATABASE.


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