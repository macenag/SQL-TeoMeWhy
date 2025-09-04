
with  tb_cliente_semana as (
select idcliente,
        strftime('%w', substr(dtcriacao,1,10)) as dtdiasemana,
        count( DISTINCT idtransacao) as qtdtransacao

        from transacoes
        group by idcliente, dtdiasemana

),

tb_rn as (

SELECT *,
        ROW_number () over (PARTITION BY idcliente order by qtdtransacao DESC) as rn

        from tb_cliente_semana

)

SELECT * 
FROM tb_rn 
where rn = 1