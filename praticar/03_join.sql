select 
        substr(t1.DtCriacao,1,7) as AnoMes,
        count(DISTINCT t1.IdTransacao) as QtdTransacao
        
from transacoes as t1

left join transacao_produto as t2
on t1.idtransacao = t2.idtransacao

left join produtos as t3
on t2.IdProduto = t3.IdProduto

where t3.DescProduto = 'Lista de presença'

GROUP BY substr(t1.DtCriacao,1,7)
ORDER BY count(DISTINCT t1.IdTransacao) DESC

limit 10