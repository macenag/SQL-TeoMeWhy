SELECT IdCliente,
    DtCriacao,

    datetime(substr(DtCriacao,1,19)) as DtCriacaoNova,

    strftime('%w', datetime(substr(DtCriacao,1,19))) as DiaSemana

 FROM clientes