USE oficina_mecanica;
GO

INSERT INTO Cliente (Nome, Telefone, Email, Endereco) VALUES
('Carlos Silva', '62999990001', 'carlos@email.com', 'Rua A, 100'),
('Marina Souza', '62999990002', 'marina@email.com', 'Rua B, 200');
GO

INSERT INTO Equipe (NomeEquipe) VALUES
('Equipe A'),
('Equipe B');
GO

INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, Cliente_idCliente) VALUES
('ABC1D23', 'Onix', 'Chevrolet', 2019, 1),
('XYZ9K88', 'HB20', 'Hyundai', 2021, 2);
GO

INSERT INTO Mecanico (Nome, Endereco, Especialidade, Equipe_idEquipe) VALUES
('João Mecânico', 'Rua das Oficinas, 10', 'Motor', 1),
('Pedro Freios', 'Av. Central, 200', 'Freios', 2);
GO

INSERT INTO Servico (Descricao, Preco) VALUES
('Troca de óleo', 120.00),
('Alinhamento', 80.00);
GO

INSERT INTO Peca (Descricao, Preco) VALUES
('Filtro de óleo', 35.00),
('Pastilha de freio', 90.00);
GO

INSERT INTO OrdemServico (Numero, DataEmissao, DataConclusao, Valor, Status, Veiculo_idVeiculo, Equipe_idEquipe) VALUES
(1001, '2026-03-01', '2026-03-02', 155.00, 'Concluida', 1, 1),
(1002, '2026-03-03', NULL, 170.00, 'Em aberto', 2, 2);
GO

INSERT INTO OrdemServico_Servico (OrdemServico_idOrdemServico, Servico_idServico, Quantidade) VALUES
(1, 1, 1),
(2, 2, 1);
GO

INSERT INTO OrdemServico_Peca (OrdemServico_idOrdemServico, Peca_idPeca, Quantidade) VALUES
(1, 1, 1),
(2, 2, 1);
GO
