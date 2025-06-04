-- === CRIAÇÃO DE TABELAS ===

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS aluguel_veiculos;
USE aluguel_veiculos;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    ano INT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    status ENUM('disponivel', 'alugado', 'manutencao') DEFAULT 'disponivel'
);

-- Tabela Aluguel
CREATE TABLE Aluguel (
    id_aluguel INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


-- === INSERÇÃO DE DADOS ===

-- Inserindo clientes
INSERT INTO Cliente (nome, email, telefone) VALUES
('Carlos Silva', 'carlos@email.com', '11999990000'),
('Marina Costa', 'marina@email.com', '11988880000');

-- Inserindo veículos
INSERT INTO Veiculo (modelo, marca, ano, placa, status) VALUES
('Civic', 'Honda', 2020, 'ABC1234', 'disponivel'),
('Gol', 'Volkswagen', 2018, 'XYZ5678', 'alugado'),
('Onix', 'Chevrolet', 2021, 'DEF4321', 'disponivel');

-- Inserindo aluguéis
INSERT INTO Aluguel (id_cliente, id_veiculo, data_inicio, data_fim, valor_total) VALUES
(1, 2, '2025-05-20', '2025-05-25', 750.00),
(2, 1, '2025-06-01', NULL, NULL);


-- === CONSULTAS SQL ===

-- Selecionar todos os veículos
SELECT * FROM Veiculo;

-- Selecionar veículos disponíveis para aluguel
SELECT * FROM Veiculo WHERE status = 'disponivel';

-- Ordenar veículos por ano (mais recente primeiro)
SELECT * FROM Veiculo ORDER BY ano DESC;

-- Quantidade de aluguéis por cliente
SELECT id_cliente, COUNT(*) AS total_alugueis
FROM Aluguel
GROUP BY id_cliente;

-- Atualizar status de veículo para ‘disponível’
UPDATE Veiculo SET status = 'disponivel' WHERE id_veiculo = 2;

-- Excluir um cliente
DELETE FROM Cliente WHERE id_cliente = 2;

-- Consulta com JOIN
SELECT 
    a.id_aluguel,
    c.nome AS cliente,
    v.modelo AS veiculo,
    a.data_inicio,
    a.data_fim,
    a.valor_total
FROM Aluguel a
JOIN Cliente c ON a.id_cliente = c.id_cliente
JOIN Veiculo v ON a.id_veiculo = v.id_veiculo;
