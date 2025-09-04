select IdTransacao,
        QtdePontos,
    CASE
        WHEN QtdePontos <10 then 'Baixo'
        WHEN QtdePontos <500 then 'Médio'
        ELSE 'Alto'
    End as QtdPontosAcum
 FROM transacoes

 ORDER BY QtdePontos DESC