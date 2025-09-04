select 
        count (DISTINCT t1.IdCliente)

from transacoes as t1

left join transacao_produto as t2
on t1.IdTransacao = t2.IdTransacao

left join produtos as t3
on t2.IdProduto = t3.IdProduto


where t1.dtcriacao >= '2025-08-25'
and t1.dtcriacao < '2025-08-30'
and t3.DescProduto = 'Lista de presença'

