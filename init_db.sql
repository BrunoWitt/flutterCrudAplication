-- Tabela principal de cadastro
CREATE TABLE cadastro (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    texto TEXT NOT NULL,
    numero INTEGER NOT NULL UNIQUE CHECK (numero > 0)
);

-- Tabela de logs de auditoria
CREATE TABLE log_operacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    operacao TEXT NOT NULL,
    data_hora TEXT NOT NULL
);

-- Triggers para automação do Log (Requisito de validação no banco)
CREATE TRIGGER log_insert
AFTER INSERT ON cadastro
BEGIN
    INSERT INTO log_operacoes (operacao, data_hora)
    VALUES ('INSERT', datetime('now'));
END;

CREATE TRIGGER log_update
AFTER UPDATE ON cadastro
BEGIN
    INSERT INTO log_operacoes (operacao, data_hora)
    VALUES ('UPDATE', datetime('now'));
END;

CREATE TRIGGER log_delete
AFTER DELETE ON cadastro
BEGIN
    INSERT INTO log_operacoes (operacao, data_hora)
    VALUES ('DELETE', datetime('now'));
END;