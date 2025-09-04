SELECT
       strftime('%w', substr(DtCriacao,1,10)) as diaSemana,
       count(DISTINCT IdTransacao) as QtTransacao

from transacoes

where substr(DtCriacao,1,4) = '2025'

GROUP BY 1
ORDER BY 2 DESC

