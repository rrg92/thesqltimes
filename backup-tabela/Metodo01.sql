/***************
	MÉTODO 01 - NÍVEL FÁCIL
*****************/

-- Cria um banco!
CREATE DATABASE  BackupTabelaCliente;

-- Salva a tabela desejada. Lembre-se de se de se conectar no banco onde está a tabela desejada
SELECT * INTO BackupTabelaCliente..Cliente FROM MeuBanco.dbo.MinhaTabela

-- Agora, com o comando BACKUP DATABASE, você faz o backup da base.
BACKUP DATABASE BackupTabelaCliente TO DISK  = 'C:\temp\BackupTabelaCliente.bak'

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