SELECT sum(QtdePontos) as TotalPontos,
       COUNT(DISTINCT substr(DtCriacao,1,10)) as DiasComRegistro,
       sum(QtdePontos) / COUNT(DISTINCT substr(DtCriacao,1,10)) as MediaPontosDia

FROM transacoes

WHERE QtdePontos > 0;

