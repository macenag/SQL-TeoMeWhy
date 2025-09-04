SELECT 
        t1.IdCliente,
        CAST(julianday('now') - julianday(substr(t1.DtCriacao,1,19)) as INT) as IdadeBase,
        count(t2.IdTransacao) as QtdTransacoes

from clientes as t1

left join transacoes as t2
on t1.IdCliente = t2.IdCliente

group by t1.IdCliente, IdadeBase