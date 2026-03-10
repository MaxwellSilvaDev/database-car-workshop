-- CONSULTAS BÁSICAS
-- 1. Listar todos os clientes
SELECT *
FROM Cliente;

-- 2. Listar todos os veículos
SELECT *
FROM Veiculo;

-- 3. Listar todas as ordens de serviço
SELECT *
FROM OrdemServico;

-- FILTROS E ORDENAÇÃO
-- 4. Listar veículos por marca em ordem alfabética
SELECT idVeiculo, Placa, Modelo, Marca, Ano
FROM Veiculo
ORDER BY Marca, Modelo;

-- 5. Listar ordens de serviço com status específico
SELECT idOrdemServico, Numero, DataEmissao, DataConclusao, Valor, Status
FROM OrdemServico
WHERE Status = 'Em aberto';

-- 6. Listar mecânicos por especialidade
SELECT idMecanico, Nome, Especialidade
FROM Mecanico
ORDER BY Especialidade, Nome;

-- JOINS
-- 7. Listar clientes com seus veículos
SELECT
    c.idCliente,
    c.Nome AS Cliente,
    v.idVeiculo,
    v.Placa,
    v.Modelo,
    v.Marca,
    v.Ano
FROM Cliente c
INNER JOIN Veiculo v
    ON c.idCliente = v.Cliente_idCliente
ORDER BY c.Nome;

-- 8. Listar ordens de serviço com dados do veículo
SELECT
    os.idOrdemServico,
    os.Numero,
    os.DataEmissao,
    os.Status,
    v.Placa,
    v.Modelo,
    v.Marca
FROM OrdemServico os
INNER JOIN Veiculo v
    ON os.Veiculo_idVeiculo = v.idVeiculo
ORDER BY os.DataEmissao DESC;

-- 9. Listar ordens de serviço com veículo e cliente
SELECT
    os.idOrdemServico,
    os.Numero,
    os.Status,
    os.Valor,
    c.Nome AS Cliente,
    v.Placa,
    v.Modelo,
    v.Marca
FROM OrdemServico os
INNER JOIN Veiculo v
    ON os.Veiculo_idVeiculo = v.idVeiculo
INNER JOIN Cliente c
    ON v.Cliente_idCliente = c.idCliente
ORDER BY os.idOrdemServico;

-- 10. Listar equipes e seus mecânicos
SELECT
    e.NomeEquipe,
    m.Nome AS Mecanico,
    m.Especialidade
FROM Equipe e
INNER JOIN Mecanico m
    ON e.idEquipe = m.Equipe_idEquipe
ORDER BY e.NomeEquipe, m.Nome;

-- SERVIÇOS E PEÇAS POR ORDEM
-- 11. Listar serviços utilizados em cada ordem de serviço
SELECT
    os.idOrdemServico,
    os.Numero,
    s.Descricao AS Servico,
    s.Preco,
    oss.Quantidade,
    (s.Preco * oss.Quantidade) AS SubtotalServico
FROM OrdemServico os
INNER JOIN OrdemServico_Servico oss
    ON os.idOrdemServico = oss.OrdemServico_idOrdemServico
INNER JOIN Servico s
    ON oss.Servico_idServico = s.idServico
ORDER BY os.idOrdemServico;

-- 12. Listar peças utilizadas em cada ordem de serviço
SELECT
    os.idOrdemServico,
    os.Numero,
    p.Descricao AS Peca,
    p.Preco,
    osp.Quantidade,
    (p.Preco * osp.Quantidade) AS SubtotalPeca
FROM OrdemServico os
INNER JOIN OrdemServico_Peca osp
    ON os.idOrdemServico = osp.OrdemServico_idOrdemServico
INNER JOIN Peca p
    ON osp.Peca_idPeca = p.idPeca
ORDER BY os.idOrdemServico;

-- AGREGAÇÕES
-- 13. Quantidade de veículos por cliente
SELECT
    c.Nome AS Cliente,
    COUNT(v.idVeiculo) AS QuantidadeVeiculos
FROM Cliente c
INNER JOIN Veiculo v
    ON c.idCliente = v.Cliente_idCliente
GROUP BY c.Nome
ORDER BY QuantidadeVeiculos DESC;

-- 14. Quantidade de ordens de serviço por status
SELECT
    Status,
    COUNT(*) AS TotalOrdens
FROM OrdemServico
GROUP BY Status
ORDER BY TotalOrdens DESC;

-- 15. Valor total das ordens de serviço por cliente
SELECT
    c.Nome AS Cliente,
    SUM(os.Valor) AS ValorTotalGasto
FROM Cliente c
INNER JOIN Veiculo v
    ON c.idCliente = v.Cliente_idCliente
INNER JOIN OrdemServico os
    ON v.idVeiculo = os.Veiculo_idVeiculo
GROUP BY c.Nome
ORDER BY ValorTotalGasto DESC;

-- 16. Quantidade de mecânicos por equipe
SELECT
    e.NomeEquipe,
    COUNT(m.idMecanico) AS QuantidadeMecanicos
FROM Equipe e
INNER JOIN Mecanico m
    ON e.idEquipe = m.Equipe_idEquipe
GROUP BY e.NomeEquipe
ORDER BY QuantidadeMecanicos DESC;

-- 17. Clientes que nunca cadastraram veículos
SELECT
    c.idCliente,
    c.Nome
FROM Cliente c
LEFT JOIN Veiculo v
    ON c.idCliente = v.Cliente_idCliente
WHERE v.idVeiculo IS NULL;

-- 18. Veículos sem ordens de serviço
SELECT
    v.idVeiculo,
    v.Placa,
    v.Modelo,
    v.Marca
FROM Veiculo v
LEFT JOIN OrdemServico os
    ON v.idVeiculo = os.Veiculo_idVeiculo
WHERE os.idOrdemServico IS NULL;

-- 19. Ordem de serviço com maior valor
SELECT
    idOrdemServico,
    Numero,
    Valor,
    Status
FROM OrdemServico
WHERE Valor = (
    SELECT MAX(Valor)
    FROM OrdemServico
);

-- 20. Total gasto com serviços por ordem de serviço
SELECT
    os.idOrdemServico,
    os.Numero,
    SUM(s.Preco * oss.Quantidade) AS TotalServicos
FROM OrdemServico os
INNER JOIN OrdemServico_Servico oss
    ON os.idOrdemServico = oss.OrdemServico_idOrdemServico
INNER JOIN Servico s
    ON oss.Servico_idServico = s.idServico
GROUP BY os.idOrdemServico, os.Numero
ORDER BY TotalServicos DESC;

-- 21. Total gasto com peças por ordem de serviço
SELECT
    os.idOrdemServico,
    os.Numero,
    SUM(p.Preco * osp.Quantidade) AS TotalPecas
FROM OrdemServico os
INNER JOIN OrdemServico_Peca osp
    ON os.idOrdemServico = osp.OrdemServico_idOrdemServico
INNER JOIN Peca p
    ON osp.Peca_idPeca = p.idPeca
GROUP BY os.idOrdemServico, os.Numero
ORDER BY TotalPecas DESC;

-- 22. Resumo geral da ordem de serviço
SELECT
    os.idOrdemServico,
    os.Numero,
    c.Nome AS Cliente,
    v.Placa,
    os.Status,
    os.Valor
FROM OrdemServico os
INNER JOIN Veiculo v
    ON os.Veiculo_idVeiculo = v.idVeiculo
INNER JOIN Cliente c
    ON v.Cliente_idCliente = c.idCliente
ORDER BY os.idOrdemServico;
