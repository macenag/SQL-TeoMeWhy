-- 

SELECT IdCliente,
        sum(QtdePontos) as 'Pontos',
        COUNT(IdTransacao)

From transacoes
where DtCriacao >= '2025-07-01'
and DtCriacao < '2025-08-01'

GROUP BY IdCliente 
HAVING sum(QtdePontos) >= 4000

ORDER by sum(QtdePontos) DESC
limit 10