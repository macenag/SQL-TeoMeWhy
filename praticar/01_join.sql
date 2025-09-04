select 
        t2.DescCateogriaProduto,
        count(DISTINCT t1.IdTransacao) as QtdTransacao
       
from transacao_produto as t1

left JOIN produtos as t2
on t1.IdProduto = t2.IdProduto
GROUP BY t2.DescCateogriaProduto
ORDER by count(DISTINCT t1.IdTransacao) DESC
