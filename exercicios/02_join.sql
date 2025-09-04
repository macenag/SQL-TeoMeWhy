select t1.IdCliente,
count (*)

from transacoes as t1

left join transacao_produto as t2
on t1.IdTransacao = t2.IdTransacao

left join produtos as t3
on t2.IdProduto = t3.IdProduto


where substr(t1.dtcriacao, 1, 10) = '2025-08-25'
and t3.DescProduto = 'Lista de presença'

group by t1.IdCliente
