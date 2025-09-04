SELECT round(avg(QtdePontos), 2) as MediaCarteira,
        min(QtdePontos) as minCarteira,
        max(QtdePontos) as maxCarteira,
        sum(FlTwitch) as UsuarioTwitch, 
        sum(FlEmail) as  UsuarioEmail

From clientes
