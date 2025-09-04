SELECT IdProduto,
count(DISTINCT IdTransacao) as QtdTransacao 
FROM transacao_produto
GROUP BY IdProduto
ORDER BY count(IdTransacao) DESC
limit 1