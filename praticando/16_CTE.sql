WITH tb_cliente_primeiro_dia as (

SELECT DISTINCT IdCliente
FROM transacoes
where substr(dtcriacao,1,10) = '2025-08-25'

),

tb_cliente_ultimo_dia AS (

SELECT DISTINCT IdCliente
FROM transacoes
where substr(dtcriacao,1,10) = '2025-08-29'

),

tb_join AS (

SELECT t1.IdCliente as primCliente,
        t2.IdCliente as ultCliente
FROM tb_cliente_primeiro_dia as t1
left join tb_cliente_ultimo_dia as t2
on t1.IdCliente = t2.IdCliente
)

SELECT count(primCliente),
        count(ultCliente),
        1. * count(ultcliente) / count(primcliente)
from tb_join
