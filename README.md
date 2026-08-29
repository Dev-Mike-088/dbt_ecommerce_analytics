# 📊 dbt Ecommerce Analytics

Um projeto moderno de análise de e-commerce construído com **dbt** e **PostgreSQL**, seguindo as melhores práticas de transformação de dados com arquitetura em camadas (Staging → Intermediate → Final).

## 📋 Visão Geral

Este projeto implementa um pipeline de dados completo para análise de vendas de e-commerce, incluindo:
- **Limpeza e normalização** de dados brutos (Staging)
- **Transformações intermediárias** com agregações e joins (Intermediate)
- **Modelos analíticos** prontos para BI e relatórios (Final)
- **Testes automáticos** para garantir qualidade dos dados
- **Documentação integrada** de tabelas, colunas e relacionamentos

### Arquitetura de Dados

```
Raw Data (CSV Seeds)
    ↓
[STAGING] - Limpeza e validação
    ├─ stg_customers
    ├─ stg_orders
    ├─ stg_order_items
    └─ stg_products
    ↓
[INTERMEDIATE] - Agregações e joins
    ├─ int_customers
    ├─ int_order_details
    └─ int_products
    ↓
[FINAL] - Modelos analíticos
    ├─ DIMENSIONS
    │  ├─ dim_customers
    │  └─ dim_products
    ├─ FACTS
    │  └─ fct_sales
    └─ ANALYTICS
       ├─ customer_metrics
       ├─ product_performance
       └─ sales_summary
```

## 🛠️ Requisitos

- **Python** 3.9 ou superior
- **PostgreSQL** 12 ou superior (instalado e em execução)
- **pip** (gerenciador de pacotes Python)
- **Git** (opcional, para versionamento)

### Verificar versões instaladas

```bash
# Python
python --version

# PostgreSQL
psql --version
```

## 🚀 Instalação

Escolha o sistema operacional e execute os comandos na **raiz do projeto**.

### Linux e macOS

```bash
# 1. Criar ambiente virtual
python3 -m venv .venv

# 2. Ativar ambiente virtual
source .venv/bin/activate

# 3. Atualizar pip e instalar dependências
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# 4. Criar diretório dbt e copiar perfil
mkdir -p ~/.dbt
cp profiles.yml.example ~/.dbt/profiles.yml
```

### Windows PowerShell

```powershell
# 1. Criar ambiente virtual
py -m venv .venv

# 2. Ativar ambiente virtual
.\.venv\Scripts\Activate.ps1

# 3. Atualizar pip e instalar dependências
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# 4. Criar diretório dbt e copiar perfil
New-Item -ItemType Directory -Force "$HOME\.dbt" | Out-Null
Copy-Item profiles.yml.example "$HOME\.dbt\profiles.yml"
```

### Windows CMD

```cmd
# 1. Criar ambiente virtual
py -m venv .venv

# 2. Ativar ambiente virtual
.venv\Scripts\activate.bat

# 3. Atualizar pip e instalar dependências
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# 4. Criar diretório dbt e copiar perfil
if not exist "%USERPROFILE%\.dbt" mkdir "%USERPROFILE%\.dbt"
copy /Y profiles.yml.example "%USERPROFILE%\.dbt\profiles.yml"
```

## ⚙️ Configuração

### 1. Configurar PostgreSQL

Certifique-se de que PostgreSQL está rodando:

```bash
# Linux
sudo service postgresql status

# macOS (com Homebrew)
brew services list

# Windows (verificar nos Serviços)
```

### 2. Configurar Profile dbt

Edite o arquivo `~/.dbt/profiles.yml` com suas credenciais PostgreSQL:

```yaml
dbt_ecommerce_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: seu_usuario_postgres
      password: sua_senha_postgres
      port: 5432
      dbname: seu_banco_de_dados
      schema: analytics_staging
      threads: 4
      keepalives_idle: 0
```

### 3. Validar Conexão

```bash
dbt debug
```

Você deve ver: ✅ `All checks passed!`

## 📦 Estrutura do Projeto

```
dbt_ecommerce_analytics/
├── models/
│   ├── stg/              # Staging (limpeza de dados brutos)
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_products.sql
│   │   └── schema.yml
│   ├── int/              # Intermediate (transformações complexas)
│   │   ├── int_customers.sql
│   │   ├── int_order_details.sql
│   │   ├── int_products.sql
│   │   └── schema.yml
│   ├── final/            # Final (modelos analíticos)
│   │   ├── dimensions/
│   │   │   ├── dim_customers.sql
│   │   │   └── dim_products.sql
│   │   ├── facts/
│   │   │   └── fct_sales.sql
│   │   ├── analytics/
│   │   │   ├── customer_metrics.sql
│   │   │   ├── product_performance.sql
│   │   │   └── sales_summary.sql
│   │   └── schema.yml
│   └── stg.yml           # Testes para staging
├── seeds/                # Dados CSV para carregar
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   ├── raw_order_items.csv
│   ├── raw_products.csv
│   └── seeds.yml
├── tests/                # Testes customizados
├── macros/               # Macros reutilizáveis
├── analyses/             # Análises ad-hoc
├── dbt_project.yml       # Configuração do projeto
├── profiles.yml.example  # Exemplo de profile
├── requirements.txt      # Dependências Python
└── README.md             # Este arquivo
```

## ▶️ Execução

Ative o ambiente virtual antes de rodar qualquer comando dbt:

```bash
# Linux e macOS
source .venv/bin/activate

# Windows
.venv\Scripts\activate
```

### Comandos Principais

```bash
# 1. Carregar dados brutos (seeds)
dbt seed

# 2. Executar todos os modelos
dbt run

# 3. Executar testes
dbt test

# 4. Executar seed, run e test (pipeline completo)
dbt build

# 5. Gerar documentação
dbt docs generate

# 6. Servir documentação (abre no navegador)
dbt docs serve

# 7. Limpar artifacts
dbt clean

# 8. Visualizar DAG
dbt dag
```

### Exemplo: Executar Pipeline Completo

```bash
# Ativar ambiente
source .venv/bin/activate

# Validar conexão
dbt debug

# Executar pipeline completo
dbt build

# Ver resultados
dbt docs serve
```

## 📊 Exemplos de Consultas

Após executar `dbt build`, você pode consultar os dados em seu banco PostgreSQL:

### Resumo de Vendas

```sql
SELECT * FROM analytics_staging.fct_sales LIMIT 10;
```

### Métricas de Clientes

```sql
SELECT * FROM analytics_staging.customer_metrics LIMIT 10;
```

### Performance de Produtos

```sql
SELECT * FROM analytics_staging.product_performance ORDER BY total_revenue DESC;
```

## ✅ Testes e Validação

### Testes Automáticos

O projeto inclui testes automáticos para garantir qualidade dos dados:

```bash
# Rodar todos os testes
dbt test

# Rodar testes de um modelo específico
dbt test --select stg_customers

# Rodar com output detalhado
dbt test --debug
```

### Testes Implementados

- **Not Null**: Verifica se campos obrigatórios não contêm nulos
- **Unique**: Verifica se chaves primárias são únicas
- **Referential Integrity**: Verifica relacionamentos entre tabelas

### Exemplo de Resultado

```
Running with dbt 1.12.3
...
20 tests passed
0 tests failed
```

## 🔍 Visualizar Documentação

```bash
dbt docs generate
dbt docs serve
```

Isso abrirá uma interface web com:
- 📖 Documentação de cada modelo
- 🔗 Lineage (dependências entre modelos)
- 📋 Descrição de colunas
- 🧪 Resultados de testes

## 🐛 Troubleshooting

### Erro: "Profile not found"
```bash
# Verificar se profiles.yml existe
ls ~/.dbt/profiles.yml

# Recriá-lo
cp profiles.yml.example ~/.dbt/profiles.yml
```

### Erro: "Connection refused"
```bash
# Verificar se PostgreSQL está rodando
psql --version
sudo service postgresql status  # Linux
# ou verificar nas preferências do macOS/Windows
```

### Erro: "Schema does not exist"
```bash
# Criar schema no PostgreSQL
psql -U seu_usuario -d seu_banco -c "CREATE SCHEMA analytics_staging;"
```

### Erro: "Module not found"
```bash
# Reinstalar dependências
pip install -r requirements.txt --force-reinstall
```

## 📝 Exemplo de Desenvolvimento

Para adicionar um novo modelo:

1. **Criar arquivo SQL** em `models/stg/meu_modelo.sql`:
```sql
{{ config(materialized='view') }}

select
    id,
    nome,
    data_criacao
from {{ ref("raw_tabela") }}
```

2. **Documentar em** `models/stg.yml`:
```yaml
- name: meu_modelo
  description: "Descrição do modelo"
  columns:
    - name: id
      tests:
        - unique
        - not_null
```

3. **Testar**:
```bash
dbt run
dbt test
```

## 📚 Recursos Úteis

- [Documentação oficial dbt](https://docs.getdbt.com/)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Analytics Engineering Guide](https://www.getdbt.com/analytics-engineering/)

## 📄 Licença

Este projeto é fornecido como está para fins educacionais e comerciais.

---

**Última atualização:** 2026-08-29
**Versão do projeto:** 1.0.0

```bash
dbt debug
dbt seed
dbt run
dbt test
```

Os artefatos gerados em `target/` e os logs não devem ser versionados.

### Estrutura

- `seeds/`: dados brutos em CSV
- `models/stg/`: modelos de staging e testes de qualidade
- `profiles.yml.example`: configuração de conexão com PostgreSQL
- `requirements.txt`: dependência do adaptador PostgreSQL do dbt
