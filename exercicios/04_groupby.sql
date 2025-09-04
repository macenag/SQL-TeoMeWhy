-- SELECT count(*) as QtRPG
-- FROM produtos
-- where DescCateogriaProduto = 'rpg'


SELECT DescCateogriaProduto,
    count(*) as QtdPorCategoria
from produtos
GROUP BY DescCateogriaProduto
HAVING DescCateogriaProduto = 'rpg'

