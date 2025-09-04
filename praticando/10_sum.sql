SELECT 
       sum(QtdePontos),
        sum(CASE
            WHEN QtdePontos > 0 THEN QtdePontos
            END) AS QtdePontos_Pos,

        sum(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
        end) as QtdePontos_Neg

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'
