SELECT count(DISTINCT IdCliente)

from transacoes as t1

WHERE t1.IdCliente in (
    SELECT DISTINCT IdCliente
    from transacoes
    where substr(DtCriacao, 1, 10) = '2025-08-25'
)

and substr(t1.DtCriacao,1,10) = '2025-08-29'