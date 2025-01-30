CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Veiculos (
    VeiculoID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    Modelo VARCHAR(255),
    Marca VARCHAR(255),
    Ano INT
);

CREATE TABLE Servicos (
    ServicoID INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Valor DECIMAL(10, 2)
);

CREATE TABLE OrdensServico (
    OrdemID INT PRIMARY KEY,
    VeiculoID INT FOREIGN KEY REFERENCES Veiculos(VeiculoID),
    ServicoID INT FOREIGN KEY REFERENCES Servicos(ServicoID),
    DataEntrada DATE,
    DataSaida DATE
);
SELECT * FROM Clientes; -- Seleciona todos os clientes
SELECT Nome, Telefone FROM Veiculos WHERE Marca = 'Fiat'; -- Seleciona nome e telefone de veículos da marca Fiat
SELECT * FROM OrdensServico WHERE DataEntrada BETWEEN '2023-01-01' AND '2023-03-31'; -- Seleciona ordens de serviço entre janeiro e março de 2023
SELECT * FROM Veiculos WHERE Ano > 2020; -- Seleciona veículos com ano de fabricação superior a 2020
SELECT Nome, YEAR(GETDATE()) - Ano AS IdadeVeiculo FROM Veiculos; -- Calcula a idade do veículo
SELECT ServicoID, Descricao, Valor * 1.10 AS ValorComTaxa FROM Servicos; -- Calcula o valor do serviço com uma taxa de 10%
SELECT * FROM Clientes ORDER BY Nome ASC; -- Ordena clientes por nome em ordem alfabética crescente
SELECT * FROM OrdensServico ORDER BY DataEntrada DESC; -- Ordena ordens de serviço por data de entrada decrescente
SELECT Marca, COUNT(*) AS Quantidade FROM Veiculos GROUP BY Marca HAVING COUNT(*) > 5; -- Seleciona marcas com mais de 5 veículos
SELECT ClienteID, SUM(Valor) AS TotalGasto FROM OrdensServico GROUP BY ClienteID HAVING SUM(Valor) > 1000; -- Seleciona clientes com gasto total superior a R$1000
SELECT 
    c.Nome AS NomeCliente,
    v.Modelo AS ModeloVeiculo,
    s.Descricao AS DescricaoServico
FROM 
    Clientes c
INNER JOIN 
    Veiculos v ON c.ClienteID = v.ClienteID
INNER JOIN 
    OrdensServico os ON v.VeiculoID = os.VeiculoID
INNER JOIN 
    Servicos s ON os.ServicoID = s.ServicoID; -- Exibe nome do cliente, modelo do veículo e descrição do serviço para cada ordem de serviço