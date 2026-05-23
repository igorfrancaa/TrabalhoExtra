-- ============================================================
--  Sistema de Matrícula Escolar — Script de criação do banco
--  Execute este script ANTES de rodar a aplicação pela 1ª vez,
--  caso prefira criar as tabelas manualmente.
--  O Hibernate com hbm2ddl.auto=update cria automaticamente.
-- ============================================================

CREATE DATABASE IF NOT EXISTS escola_matriculas
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE escola_matriculas;

-- Tabela de Alunos
CREATE TABLE IF NOT EXISTS alunos (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100)  NOT NULL,
    cpf             VARCHAR(11)   NOT NULL UNIQUE,
    cep             VARCHAR(10)   NOT NULL,
    logradouro      VARCHAR(150),
    bairro          VARCHAR(100),
    cidade          VARCHAR(100),
    uf              VARCHAR(2),
    data_nascimento DATE          NOT NULL,
    email           VARCHAR(100)  NOT NULL UNIQUE,
    telefone        VARCHAR(15)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de Matrículas
CREATE TABLE IF NOT EXISTS matriculas (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(20)   NOT NULL UNIQUE,
    curso           VARCHAR(100)  NOT NULL,
    turno           VARCHAR(50)   NOT NULL,
    serie           VARCHAR(10)   NOT NULL,
    data_matricula  DATE          NOT NULL,
    status          VARCHAR(20)   NOT NULL DEFAULT 'ATIVA',
    observacoes     VARCHAR(255),
    aluno_id        BIGINT        NOT NULL,
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (aluno_id)
        REFERENCES alunos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
