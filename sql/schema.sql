CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(120)
);

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL UNIQUE,
    Modelo VARCHAR(60) NOT NULL,
    Marca VARCHAR(60) NOT NULL,
    Ano INT NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    NomeEquipe VARCHAR(60) NOT NULL
);

CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Especialidade VARCHAR(60),
    Equipe_idEquipe INT NOT NULL,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrdemServico (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    Numero VARCHAR(20) NOT NULL,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    Valor DECIMAL(10,2) NOT NULL,
    Status VARCHAR(30) NOT NULL,
    Veiculo_idVeiculo INT NOT NULL,
    Equipe_idEquipe INT NOT NULL,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE OrdemServico_Servico (
    OrdemServico_idOrdemServico INT NOT NULL,
    Servico_idServico INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (OrdemServico_idOrdemServico, Servico_idServico),
    FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);

CREATE TABLE OrdemServico_Peca (
    OrdemServico_idOrdemServico INT NOT NULL,
    Peca_idPeca INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (OrdemServico_idOrdemServico, Peca_idPeca),
    FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);
