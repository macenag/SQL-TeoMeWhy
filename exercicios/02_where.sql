SELECT IdTransacao, 
    DtCriacao,
    strftime('%w', datetime(substr(DtCriacao,1,19))) as DiaSemana
 FROM transacoes  

    WHERE strftime('%w', datetime(substr(DtCriacao,1,19))) IN ('6', '0')