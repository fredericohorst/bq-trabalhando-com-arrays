WITH base_texugos AS (
	SELECT * FROM (
		SELECT 
			'Adisbaldo' AS nome_do_texugo , 
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [5,10,20,15,10]) AS distancia,
		UNION ALL
		SELECT 
			'Ayla' AS nome_do_texugo ,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [7,13,17,19,9]) AS distancia,
		UNION ALL
		SELECT 
			'Apolo' AS nome_do_texugo ,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [11,16,17,16,14]) AS distancia,
		UNION ALL
		SELECT 
			'Ícaro' AS nome_do_texugo,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [12,18,23,9,3]) AS distancia,
		UNION ALL
		SELECT 
			'Enzo' AS nome_do_texugo ,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [7,9,11,9,6]) AS distancia,
		UNION ALL
		SELECT 
			'Dione' AS nome_do_texugo ,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [13,20,24,22,17]) AS distancia,
		UNION ALL
		SELECT 
			'Adônis' AS nome_do_texugo ,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [16,23,27,26,15]) AS distancia,
		UNION ALL
		SELECT 
			'Kael' AS nome_do_texugo,
			(SELECT [5,5,5,5,5]) AS tempo,
			(SELECT [14,18,22,25,16]) AS distancia,
	)

)

SELECT 
    nome_do_texugo ,
    ARRAY_AGG(STRUCT (GENERATE_ARRAY(1, 5, 1) AS vetor_id, tempo, distancia)) AS vetor_velocidade

FROM base_texugos
GROUP BY 1