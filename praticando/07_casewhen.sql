SELECT IdCliente, 
    QtdePontos,

    CASE
        WHEN QtdePontos  <= 500 THEN 'Ponei'
        WHEN QtdePontos  <= 1000 THEN 'Ponei Premium'
        WHEN QtdePontos  <= 5000 then 'Mago Aprendiz'
        WHEN QtdePontos  <= 10000 then 'Mago Mestre'
        ELSE 'Mago Supremo'
    END AS NomeGrupo,

    CASE
        WHEN QtdePontos <= 1000 THEN 1
        ELSE 0
    END as FlPonei,

    CASE
        WHEN QtdePontos > 1000 THEN 1
        ELSE 0
    END as FlMago

 FROM clientes

 ORDER BY QtdePontos DESC

