WITH tb_transacoes AS (

        SELECT IdTransacao,
                IdCliente,
                QtdePontos,
                datetime(substr(DtCriacao,1,19)) as DtCriacao,
                julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate,
                CAST(strftime('%h', substr(Dtcriacao,1,19)) AS INTERGER) as DtHora

        FROM transacoes
),

tb_clientes AS (

        SELECT IdCliente,
        datetime(substr(DtCriacao,1,19)) as DtCriacao,
        julianday('now') - julianday(substr(DtCriacao,1,10)) as IdadeBase
    
    FROM transacoes
    GROUP BY IdCliente

),

tb_sumario_transacoes AS (

    SELECT IdCliente,
        count(IdTransacao) as QtdTransacoesVida,
        count(CASE WHEN diffDate <=56 THEN IdTransacao END) as QtdTransacoes56,
        count(CASE WHEN diffDate <=28 THEN IdTransacao END) as QtdTransacoes28,
        count(CASE WHEN diffDate <=14 THEN IdTransacao END) as QtdTransacoes14,
        count(CASE WHEN diffDate <=7 THEN IdTransacao END) as QtdTransacoes7,
        MIN(diffDate) as DiasUltimaInteracao,
        sum(QtdePontos) as saldoPontos,

        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) as PontosPositivos,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdPontosPositivos56,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdPontosPositivos28,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdPontosPositivos14,
        sum(CASE WHEN QtdePontos > 0 AND diffDate <= 7 THEN QtdePontos ELSE 0 END) AS QtdPontosPositivos7,

        sum(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) as PontosNegativos,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 56 THEN QtdePontos ELSE 0 END) AS QtdPontosNegativos56,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 28 THEN QtdePontos ELSE 0 END) AS QtdPontosNegativos28,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 14 THEN QtdePontos ELSE 0 END) AS QtdPontosNegativos14,
        sum(CASE WHEN QtdePontos < 0 AND diffDate <= 7 THEN QtdePontos ELSE 0 END) AS QtdPontosNegativos7

    FROM tb_transacoes
    GROUP BY IdCliente

),


tb_transacao_produto AS (
SELECT t1.*,
        t3.DescProduto,
        t3.DescCateogriaProduto

FROM tb_transacoes as t1

LEFT JOIN transacao_produto as t2
on t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos as t3
ON t2.IdProduto = t3.IdProduto

),

tb_cliente_produto AS (

        SELECT IdCliente,
        DescProduto,
        count(*) as QtdVida,
        count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtdVida56,
        count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtdVida28,
        count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtdVida14,
        count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtdVida7

FROM tb_transacao_produto
GROUP BY IdCliente, DescProduto

),

tb_cliente_produto_rn AS (
        SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdVida DESC) as rnVida,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdVida56 DESC) as rnVida56,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdVida28 DESC) as rnVida28,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdVida14 DESC) as rnVida14,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QtdVida7 DESC) as rnVida7

FROM tb_cliente_produto
),

tb_cliente_dia AS (
SELECT IdCliente,
        strftime('%w', DtCriacao) as DtDia,
        count(*) as QtdTransacao

FROM tb_transacoes
WHERE diffDate <= 28
GROUP BY IdCliente, DtDia
),

tb_cliente_dia_rn AS (

SELECT *,
    row_number() OVER(PARTITION BY IdCliente ORDER BY QtdTransacao DESC) as rnDia
FROM tb_cliente_dia
),


tb_cliente_periodo AS (
SELECT IdTransacao,
        IdCliente,
        DtCriacao,
        CASE 
            WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
            WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
            ELSE 'MADRUGADA'
        END as periodo,
        count(*) as qtdtransacao

from tb_transacoes
where diffdate <=28

group by 1, 2

),

tb_cliente_periodo_rn AS (
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdtransacao DESC) AS rnperiodo
from tb_cliente_periodo
),

tb_join AS (
    SELECT t1.*,
        t2.idadeBase,
        t3.DescProduto as ProdutoVida,
        t4.DescProduto as Produto56,
        t5.DescProduto as Produto28,
        t6.DescProduto as Produto14,
        t7.DescProduto as Produto7,
        COALESCE(t8.dtDia, -1) as DtDia,
        COALESCE(t9.periodo, 'SEM INFORMACAO') as PeriodoMaisTransacao28 

    FROM tb_sumario_transacoes as t1

    LEFT JOIN tb_clientes AS t2
    ON t1.IdCliente = t2.IdCliente 

    LEFT JOIN tb_cliente_produto_rn as t3
    ON t1.IdCliente = t3.IdCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn as t4
    ON t1.IdCliente = t4.IdCliente
    AND t4.rnVida56 = 1

    LEFT JOIN tb_cliente_produto_rn as t5
    ON t1.IdCliente = t5.IdCliente
    AND t5.rnVida28 = 1

    LEFT JOIN tb_cliente_produto_rn as t6
    ON t1.IdCliente = t6.IdCliente
    AND t6.rnVida14 = 1

    LEFT JOIN tb_cliente_produto_rn as t7
    ON t1.IdCliente = t7.IdCliente
    AND t7.rnVida7 = 1

    LEFT JOIN tb_cliente_dia_rn as T8
    on  t1.IdCliente = t8.IdCliente
    AND t8.rnDia = 1

    left JOIN tb_cliente_periodo_rn as t9
    on t1.IdCliente = t9.IdCliente
    and t9.rnPeriodo = 1
)

SELECT *,
    1. * qtdTransacoes28 / qtdTransacoesVida as Engajamento28Vida

from tb_join 

