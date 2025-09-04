select 
        count(DISTINCT t1.IdTransacao) as QtdTransacao,
        t3.DescCateogriaProduto

from transacoes as t1

left join transacao_produto as t2
on t1.IdTransacao = t2.IdTransacao

left join produtos as t3
on t2.IdProduto = t3.IdProduto

where substr(DtCriacao,1,4) = '2024'
-- and t3.DescCateogriaProduto = 'lovers'

group BY t3.DescCateogriaProduto
having  count(DISTINCT t1.IdTransacao) < 1000

ORDER BY  count(DISTINCT t1.IdTransacao) DESC
