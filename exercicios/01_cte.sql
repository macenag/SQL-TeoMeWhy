with tb_prim_dia as (
    
    SELECT DISTINCT IdCliente
    From transacoes
    where substr(dtcriacao,1,10) = '2025-08-25'

),

tb_dias_curso as (  

    SELECT DISTINCT
            IdCliente, 
            substr(DtCriacao,1,10) as presenteDia
    FROM transacoes
    where DtCriacao >= '2025-08-25'
    and DtCriacao < '2025-08-30'

    order by idcliente, presentedia
),

tb_cliente_dias AS(
SELECT t1.IdCliente,
        count(DISTINCT t2.presenteDia) as QtdeDias

FROM tb_prim_dia as t1

LEFT JOIN tb_dias_curso as t2
on  t1.IdCliente = t2.IdCliente

group by t1.IdCliente
)

SELECT avg(qtdedias),
        min(qtdedias),
        max(qtdedias)
FROM tb_cliente_dias

