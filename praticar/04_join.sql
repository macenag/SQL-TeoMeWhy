select 
        t2.DescCateogriaProduto ,
        substr(t3.DtCriacao, 1, 7) as MesJunho,
        sum(t1.QtdeProduto * t1.VlProduto)  as QtdePontos

from transacao_produto as t1

left join produtos as t2
on  t1.IdProduto = t2.IdProduto

left join transacoes as t3
on t1.idtransacao = t3.idtransacao


where t1.IdProduto IN ('14', '17')
and substr(t3.DtCriacao, 1, 7) = '2025-06'

group by t2.DescCateogriaProduto
and substr(t3.DtCriacao, 1, 7) = '2025-06'

