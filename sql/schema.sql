IF DB_ID('oficina_mecanica') IS NULL
    CREATE DATABASE oficina_mecanica;
GO

USE oficina_mecanica;
GO

CREATE TABLE Cliente (
    idCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(40),
    Endereco VARCHAR(60)
);
GO

CREATE TABLE Equipe (
    idEquipe INT IDENTITY(1,1) PRIMARY KEY,
    NomeEquipe VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Veiculo (
    idVeiculo INT IDENTITY(1,1) PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL UNIQUE,
    Modelo VARCHAR(20) NOT NULL,
    Marca VARCHAR(30) NOT NULL,
    Ano INT NOT NULL,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);
GO

CREATE TABLE Mecanico (
    idMecanico INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Endereco VARCHAR(60),
    Especialidade VARCHAR(40),
    Equipe_idEquipe INT NOT NULL,
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);
GO

CREATE TABLE Servico (
    idServico INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(60) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE Peca (
    idPeca INT IDENTITY(1,1) PRIMARY KEY,
    Descricao VARCHAR(60) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE OrdemServico (
    idOrdemServico INT IDENTITY(1,1) PRIMARY KEY,
    Numero INT NOT NULL,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Status VARCHAR(15) NOT NULL,
    Veiculo_idVeiculo INT NOT NULL,
    Equipe_idEquipe INT NOT NULL,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);
GO

CREATE TABLE OrdemServico_Servico (
    OrdemServico_idOrdemServico INT NOT NULL,
    Servico_idServico INT NOT NULL,
    Quantidade TINYINT NOT NULL,
    PRIMARY KEY (OrdemServico_idOrdemServico, Servico_idServico),
    FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);
GO

CREATE TABLE OrdemServico_Peca (
    OrdemServico_idOrdemServico INT NOT NULL,
    Peca_idPeca INT NOT NULL,
    Quantidade TINYINT NOT NULL,
    PRIMARY KEY (OrdemServico_idOrdemServico, Peca_idPeca),
    FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);
GO
