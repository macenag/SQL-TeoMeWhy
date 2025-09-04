select *
from transacao_produto as t1

where t1.IdProduto in (
        SELECT IdProduto
        from produtos
        where IdProduto = '15'
)