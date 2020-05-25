SELECT
	Registro,

	-- Colunas Fixas!
	Id				=  CONVERT(int,CONVERT(binary(4),REVERSE(SUBSTRING(Registro,5,4))))

	-- Começa depois de Id, isto é 5 + 4 bytes
	,Idade			=  IIF( Col3Null = 1, NULL , CONVERT(tinyint,SUBSTRING(Registro,9,1)) )	
	
	-- Começa depois de Idade, isto é 9 + 1 bytes
	,Tipo			=  IIF( Col4Null = 1, NULL, CONVERT(char(1),SUBSTRING(Registro,10,1)) )				

	 -- Começa depois de Tipo, isto é 10 + 1 bytes
	,DataCadastro	= IIF( Col5Null = 1, NULL, CONVERT(datetime,CONVERT(binary(8),REVERSE(SUBSTRING(Registro,11,8)))))

	-- Começa depois de DataCadastro, isto é 11 + 8
	,Codigo			= IIF( Col6Null = 1,NULL,CONVERT(int,CONVERT(binary(8),REVERSE(SUBSTRING(Registro,19,8)))))					
	
	-- Agora, colunas variáveis!
	
	,Nome		= CONVERT(varchar(100),SUBSTRING(Registro,VarStart,Col1Off-VarStart+1))
	,Sobrenome	= IIF( Col7Null = 1, null,CONVERT(varchar(100),SUBSTRING(Registro,Col1Off+1,Col2Off-Col1Off)))
	,VarStart
FROM
	LogDeletes 
	CROSS APPLY
	(
		SELECT
			M. *
			,NullBmpBytes	= CONVERT(int,CEILING(M.ColCount/8.0) * 8)/8								-- Quantidade de bytes  usado pro NULL bitmap
			,NullBmp		= SUBSTRING(Registro,29, CONVERT(int,CEILING(M.ColCount/8.0) * 8)/8)		-- NULL bitmap =  19+8 (ultima coluna fixedlen)
			,VarCount		= CONVERT(binary(2),REVERSE(SUBSTRING(Registro,30,2)))						-- número de colunas variáveis, começa depois do null bitmap, 29 + 1
		FROM
			(
				SELECT ColCount = CONVERT(smallint,CONVERT(binary(2),REVERSE(SUBSTRING(Registro,27,2))))
			) M
	) M
	CROSS APPLY
	(
		SELECT
			Col1Null = IIF(power(2,1-1) & NullBmp > 0,1,0)
			,Col2Null = IIF(power(2,2-1) & NullBmp > 0,1,0)
			,Col3Null = IIF(power(2,3-1) & NullBmp > 0,1,0)
			,Col4Null = IIF(power(2,4-1) & NullBmp > 0,1,0)
			,Col5Null = IIF(power(2,5-1) & NullBmp > 0,1,0)
			,Col6Null = IIF(power(2,6-1) & NullBmp > 0,1,0)
			,Col7Null = IIF(power(2,7-1) & NullBmp > 0,1,0)
	) N
	CROSS APPLY
	(
		SELECT	
			 VarStart	= 32+VarCount*2 -- 32(inicio do var offset) + 2 bytes por coluna variável.
			,Col1Off	= CONVERT(smallint,CONVERT(binary(2),REVERSE(SUBSTRING(Registro,32,2))))
			,Col2Off	= CONVERT(smallint,CONVERT(binary(2),REVERSE(SUBSTRING(Registro,34,2))))
	) V


