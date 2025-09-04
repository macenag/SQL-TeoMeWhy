SELECT IdCliente,
count(DISTINCT IdTransacao) as TotalTransacao

FROM transacoes

where DtCriacao >= '2024-01-01'
and DtCriacao <= '2024-12-31'

GROUP BY IdCliente
order by count(IdTransacao) desc
limit 1