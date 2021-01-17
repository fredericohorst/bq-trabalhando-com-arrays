WITH 
    feriados_nacionais AS (
            SELECT * FROM `projeto.dataset.feriados_nacionais`
        ),

    base_texugos AS (
        SELECT * FROM (
            SELECT 
                'Adisbaldo' AS nome_do_texugo , 
                TIMESTAMP('2020-04-08 16:51:54.882 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-04-08 16:51:54.882 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Ayla' AS nome_do_texugo ,
                TIMESTAMP('2020-05-28 10:25:32.373 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-05-28 10:25:32.373 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Apolo' AS nome_do_texugo ,
                TIMESTAMP('2019-10-15 15:02:51.819 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2019-10-15 15:02:51.819 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Ícaro' AS nome_do_texugo,
                TIMESTAMP('2020-07-20 09:58:26.608 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-07-20 09:58:26.608 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Enzo' AS nome_do_texugo ,
                TIMESTAMP('2020-04-13 14:05:28.794 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-04-13 14:05:28.794 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Dione' AS nome_do_texugo ,
                TIMESTAMP('2020-06-22 15:30:33.899 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-06-22 15:30:33.899 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Adônis' AS nome_do_texugo ,
                TIMESTAMP('2020-03-23 11:42:54.691 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-03-23 11:42:54.691 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
            UNION ALL
            SELECT 
                'Kael' AS nome_do_texugo,
                TIMESTAMP('2020-11-12 11:44:06.508 UTC') AS timestamp_inicio_da_jornada,
                TIMESTAMP_ADD(TIMESTAMP('2020-11-12 11:44:06.508 UTC'), 
                    INTERVAL CAST(TRUNC(RAND()*230) AS INT64) HOUR) AS timestamp_final_da_jornada,
        )
    ),

    base_tratada AS (
        SELECT * ,
            ARRAY(
                SELECT data
                FROM UNNEST((
                    GENERATE_TIMESTAMP_ARRAY(timestamp_inicio_da_jornada, timestamp_final_da_jornada, 
                    INTERVAL 1 DAY))) AS array_de_data
                JOIN feriados_nacionais as fn 
                    ON CAST(fn.data AS DATE) = CAST(array_de_data AS DATE)
            ) AS datas_fn_array,
            ARRAY(
                SELECT dia_util_nao_feriado
                FROM UNNEST((
                    GENERATE_TIMESTAMP_ARRAY(timestamp_inicio_da_jornada, timestamp_final_da_jornada, 
                    INTERVAL 1 DAY))) AS array_de_data
                JOIN feriados_nacionais as fn 
                    ON CAST(fn.data AS DATE) = CAST(array_de_data AS DATE)
            ) AS dia_util_nao_feriado_array
        FROM base_texugos
    )

SELECT * EXCEPT (dia_util_nao_feriado_array , datas_fn_array),
    (SELECT COUNTIF(a) FROM UNNEST(dia_util_nao_feriado_array) AS a) AS dias_uteis,
    (SELECT COUNTIF(a IS FALSE) FROM UNNEST(dia_util_nao_feriado_array) AS a) AS dias_nao_uteis
FROM base_tratada

