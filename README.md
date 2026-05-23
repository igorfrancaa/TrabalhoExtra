# 🏫 Sistema de Matrícula Escolar

Sistema de gerenciamento de matrículas escolares com CRUD completo para **Aluno** e **Matrícula**, integração com banco de dados MySQL via Hibernate/JPA e consumo da API pública **ViaCEP** para preenchimento automático de endereço.

---

## ✅ Funcionalidades

- **CRUD completo de Alunos** (cadastrar, listar, buscar, atualizar, excluir)
- **CRUD completo de Matrículas** (criar, listar, filtrar por status, atualizar, excluir)
- **Relação entre entidades**: um aluno pode ter várias matrículas (OneToMany)
- **Busca automática de endereço por CEP** via API ViaCEP
- **Validação de CPF** com algoritmo de dígitos verificadores
- **Validação de e-mail**, campos obrigatórios e formatos de data
- **Menu interativo** via terminal (Scanner)
- **Variáveis sensíveis** protegidas em arquivo `.env`

---

## 🗂️ Estrutura do Projeto

```
matricula-escolar/
├── src/main/java/com/escola/
│   ├── Main.java                    # Ponto de entrada
│   ├── model/
│   │   ├── Aluno.java               # Entidade Aluno (JPA)
│   │   └── Matricula.java           # Entidade Matrícula (JPA)
│   ├── dao/
│   │   ├── AlunoDAO.java            # Operações CRUD Aluno
│   │   └── MatriculaDAO.java        # Operações CRUD Matrícula
│   ├── service/
│   │   ├── AlunoService.java        # Regras de negócio Aluno
│   │   └── MatriculaService.java    # Regras de negócio Matrícula
│   ├── menu/
│   │   ├── MenuAluno.java           # Menu interativo Aluno
│   │   └── MenuMatricula.java       # Menu interativo Matrícula
│   └── util/
│       ├── EnvConfig.java           # Carrega variáveis do .env
│       ├── JPAUtil.java             # Gerencia EntityManagerFactory
│       ├── ViaCepClient.java        # Consome API ViaCEP
│       └── Validator.java           # Validações (CPF, email, data)
├── src/main/resources/
│   └── META-INF/persistence.xml    # Configuração JPA/Hibernate
├── .env                            # Variáveis de ambiente (NÃO commitar)
├── .env.example                    # Modelo do .env
├── database.sql                    # Script SQL (opcional)
└── pom.xml                         # Dependências Maven
```

---

## 🔧 Pré-requisitos

| Ferramenta | Versão mínima |
|------------|---------------|
| Java JDK   | 17+           |
| Maven      | 3.8+          |
| MySQL      | 8.0+          |

---

## 🚀 Como Rodar

### 1. Clone o repositório

```bash
git clone https://github.com/SEU_USUARIO/matricula-escolar.git
cd matricula-escolar
```

### 2. Configure o banco de dados

Crie o banco no MySQL (o Hibernate cria as tabelas automaticamente):

```sql
CREATE DATABASE escola_matriculas
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
```

> Ou execute o script `database.sql` para criar tudo manualmente.

### 3. Configure o arquivo `.env`

```bash
cp .env.example .env
```

Edite o `.env` com suas credenciais:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=escola_matriculas
DB_USER=root
DB_PASSWORD=sua_senha
```

### 4. Compile e execute

```bash
# Compilar e gerar JAR com todas as dependências
mvn clean package -q

# Executar (sem logs do Hibernate)
java -Djava.util.logging.config.file=src/main/resources/logging.properties -jar target/matricula-escolar-jar-with-dependencies.jar
```

> ⚠️ O arquivo `.env` deve estar na mesma pasta de onde você executa o `java -jar`.

---

## 🌐 API Externa — ViaCEP

O sistema consome a [API ViaCEP](https://viacep.com.br) gratuitamente (sem token necessário).

**Quando é utilizada:**
- Ao **cadastrar um aluno**: o endereço é preenchido automaticamente pelo CEP
- Ao **atualizar um aluno** com novo CEP
- No menu de **consulta avulsa de CEP**

**Exemplo de resposta:**
```
CEP: 01310100 | Avenida Paulista, Bela Vista - São Paulo/SP
```

---

## 📋 Entidades

### Aluno
| Campo          | Tipo        | Regra                        |
|----------------|-------------|------------------------------|
| id             | Long        | PK, auto-gerado              |
| nome           | String      | Obrigatório                  |
| cpf            | String      | Obrigatório, único, validado |
| cep            | String      | Obrigatório, via ViaCEP      |
| logradouro     | String      | Preenchido pela API          |
| bairro         | String      | Preenchido pela API          |
| cidade         | String      | Preenchido pela API          |
| uf             | String      | Preenchido pela API          |
| dataNascimento | LocalDate   | Obrigatório                  |
| email          | String      | Obrigatório, único, validado |
| telefone       | String      | Opcional                     |

### Matrícula
| Campo         | Tipo      | Regra                             |
|---------------|-----------|-----------------------------------|
| id            | Long      | PK, auto-gerado                   |
| codigo        | String    | Único, gerado automaticamente     |
| curso         | String    | Obrigatório                       |
| turno         | String    | MATUTINO / VESPERTINO / NOTURNO   |
| serie         | String    | Ex: 1º ANO                        |
| dataMatricula | LocalDate | Preenchida automaticamente        |
| status        | String    | ATIVA / CANCELADA / TRANCADA / CONCLUIDA |
| observacoes   | String    | Opcional                          |
| aluno         | Aluno     | FK → alunos.id                    |

---

## 📦 Dependências (pom.xml)

| Biblioteca                    | Versão   | Uso                        |
|-------------------------------|----------|----------------------------|
| hibernate-core                | 6.4.4    | ORM / JPA                  |
| mysql-connector-j             | 8.3.0    | Driver MySQL               |
| dotenv-java                   | 3.0.0    | Leitura do arquivo .env    |
| gson                          | 2.10.1   | Parse JSON da API ViaCEP   |
| jakarta.persistence-api       | 3.1.0    | API JPA                    |

---

## 🔒 Segurança

- O arquivo `.env` **não deve ser commitado** no Git
- Adicione `.env` ao `.gitignore`:
  ```
  .env
  ```

---

## 📝 Licença

Projeto acadêmico — uso educacional.
