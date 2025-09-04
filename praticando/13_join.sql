SELECT t1.IdTransacao,
        t1.IdProduto,
        t1.VlProduto,
        t2.DescProduto,
        t2.DescCateogriaProduto
        
from transacao_produto as t1
LEFT JOIN produtos as t2
on t1.IdProduto = t2.IdProduto

limit 10