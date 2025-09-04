with tb_cliente_dia as (

        SELECT idcliente,
        substr(dtcriacao,1,10) as dtdia,
        sum(qtdepontos) as totalpontos,
        sum(case when qtdepontos > 0 then qtdepontos else 0 end) as pontospos

        from transacoes
        GROUP BY idcliente, dtdia
)

SELECT *,
        sum(totalpontos) OVER(PARTITION BY idcliente order by dtdia) as sumpontos,
        sum(pontospos) over (PARTITION BY idcliente order by dtdia) as total

        from tb_cliente_dia