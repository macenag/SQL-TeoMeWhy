with tb_dia_cliente as(
        SELECT substr(dtcriacao,1,10) as dtdia,
        count(DISTINCT idcliente) as qtdcliente

    from clientes
    GROUP BY dtdia
),

tb_acum as (

        SELECT *,
        sum(qtdcliente) over (order by dtdia) as clientacum
    from tb_dia_cliente
    
)

SELECT *  
from tb_acum
order by dtdia