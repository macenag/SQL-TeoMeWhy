with tb_diario as (
        select substr(dtcriacao,1,10) as DtDia,
        count( DISTINCT idtransacao) as qtdtransacao
    
        from transacoes

        group by dtdia
        order by dtdia

),

tb_acum as (

select *,
        sum(qtdtransacao) over (order by dtdia) as qtdtransacaoacum

from tb_diario

)


SELECT *
from tb_acum
where qtdtransacaoacum > 100000

order by qtdtransacaoacum
limit 1