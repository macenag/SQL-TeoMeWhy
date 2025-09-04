select t1.idcliente,
        sum(t1.qtdepontos) as TotalPontos

from transacoes as t1

left join transacao_produto as t2
on t1.IdTransacao = t2.IdTransacao

left join produtos as t3
on t2.IdProduto = t3.IdProduto

WHERE t3.DescCateogriaProduto = 'lovers'

group by t1.idcliente

order by sum(t1.qtdepontos) ASC

limit 5 
