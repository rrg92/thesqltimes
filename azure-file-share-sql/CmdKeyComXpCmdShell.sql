-- DICA: Utilize CTRL + SHIFT + M  Para fornecer os parâmetros
DECLARE
     @Url nvarchar(max)                 = '<Url,,>'
    ,@AccountKey varchar(max)           = '<Account Key,,>'
    ,@StorageAccountName varchar(max)   = '<StorageAccountName,,>' -- Se deixar em brnaco, ele irá extrair automaticamente da URl
    
-- Daqui pra frente não precisa alterar nada!


DECLARE
    @XpCmdshellHabilitada_Atual int
    ,@XpCmdshellHabilitada_Config int
    ,@cmd varchar(8000)
    ,@res int

select @XpCmdshellHabilitada_Atual  = CONVERT(int,value_in_use)
    , @XpCmdshellHabilitada_Config  = CONVERT(int,value)
from sys.configurations where name  = 'xp_cmdshell';

IF LEN(TRIM(RTRIM(ISNULL(@StorageAccountName,'')))) = 0
    SET @StorageAccountName = LEFT(@Url,CHARINDEX('.',@Url)-1)

IF IS_SRVROLEMEMBER('sysadmin') = 0
BEGIN
    RAISERROR('Usuario atual não é sysadmin! Para a correta execução do cmdkey, este script deverá ser executado com um sysadmin',16,1);
    return;
END

-- Se não está, então habilita!
IF @XpCmdshellHabilitada_Atual = 0
BEGIN
    EXEC sp_configure 'show',1;
    RECONFIGURE;
    EXEC sp_configure 'xp_cmdshell',1;
    RECONFIGURE;
END

set @cmd = 'cmdkey /add:'+@Url+' /user:Azure\'+@StorageAccountName+' /pass:'+@AccountKey;

SELECT Comando = @cmd;

EXEC @res = xp_cmdshell @cmd;



-- Se é pra manter desablitado, volta a configuração original!
IF @XpCmdshellHabilitada_Config = 0
BEGIN
    print 'Alterando xp_cmdshell de volta para 0'
    EXEC sp_configure 'xp_cmdshell',0;

    -- Efetiva somente se estava efetivado antes
    IF @XpCmdshellHabilitada_Atual = 0
        RECONFIGURE;
    ELSE
        print ' RECONFIGURE nao executado, pois a configuracao original não estava EFETIVADA. Mensagem informacional apenas.'
END