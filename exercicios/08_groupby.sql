SELECT IdProduto,
count(IdTransacao) as QtdTransacao,
count(IdTransacao) * VlProduto as TotalPontos
FROM transacao_produto
GROUP BY IdProduto
ORDER BY count(IdTransacao) * VlProduto DESC
limit 1

