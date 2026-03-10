# Database Car Workshop

Projeto de modelagem e implementação de um banco de dados relacional para um sistema de oficina mecânica, com foco em entidades, relacionamentos, organização estrutural e consultas SQL.

## 📊 Modelo do Banco

<img width="820" height="562" alt="modelo_banco_oficina" src="https://github.com/user-attachments/assets/91dac638-ba89-4f25-bc23-c77215c28466" />

## Estrutura do Projeto

- `sql/schema.sql` → criação das tabelas e relacionamentos
- `sql/inserts.sql` → inserção de dados para testes
- `sql/queries.sql` → consultas SQL do projeto

## Tecnologias Utilizadas

- SQL
- MySQL
- MySQL Workbench
- Modelagem EER
- Git
- GitHub

## Entidades do Sistema

- Cliente
- Veículo
- Ordem de Serviço
- Equipe
- Mecânico
- Serviço
- Peça

## Relacionamentos

- Um cliente pode possuir vários veículos
- Um veículo pode possuir várias ordens de serviço
- Uma ordem de serviço pode conter vários serviços
- Uma ordem de serviço pode utilizar várias peças
- Uma equipe pode possuir vários mecânicos

## Consultas Implementadas

O projeto inclui consultas SQL para análise e manipulação dos dados do sistema da oficina mecânica, como:

- Listagem de clientes cadastrados
- Listagem de veículos cadastrados
- Consulta de ordens de serviço
- Relacionamento entre cliente e veículo
- Relacionamento entre veículo e ordem de serviço
- Consultas com filtros e ordenação
- Consultas com junção entre tabelas

Essas consultas foram desenvolvidas para praticar comandos SQL fundamentais, como `SELECT`, `WHERE`, `ORDER BY` e `JOIN`.

## Exemplos de Consultas SQL

### 1. Valor total das ordens de serviço por cliente

```sql
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
```

### 2. Veículos sem ordens de serviço

```sql
SELECT
    v.idVeiculo,
    v.Placa,
    v.Modelo,
    v.Marca
FROM Veiculo v
LEFT JOIN OrdemServico os
    ON v.idVeiculo = os.Veiculo_idVeiculo
WHERE os.idOrdemServico IS NULL;
```

### 3. Total gasto com peças por ordem de serviço

```sql
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
```

## Como Executar o Projeto

1. Crie um banco de dados no MySQL.
2. Execute o arquivo `sql/schema.sql` para criar as tabelas e relacionamentos.
3. Execute o arquivo `sql/inserts.sql` para inserir os dados de teste.
4. Execute o arquivo `sql/queries.sql` para visualizar as consultas do projeto.

## Objetivo do Projeto

Este projeto foi desenvolvido com o objetivo de praticar modelagem de dados, criação de tabelas, definição de relacionamentos, organização estrutural e construção de consultas SQL em um cenário de oficina mecânica.
