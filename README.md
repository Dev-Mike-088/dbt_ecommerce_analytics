# dbt Ecommerce Analytics

Bem-vindo ao projeto de analytics de e-commerce com dbt. Este repositório foi estruturado para transformar dados brutos em modelos prontos para análise, relatórios e dashboards.

## Visão geral

O projeto segue uma arquitetura em camadas:

- Staging: limpeza, padronização e validação dos dados brutos.
- Intermediate: joins, enriquecimento e agregações preparatórias.
- Final: dimensões, fatos e métricas analíticas prontas para consumo.

A base de entrada está em `seeds/`, onde os arquivos CSV são carregados e convertidos em modelos SQL para análise.

---

## Objetivo do projeto

O objetivo principal é criar uma base analítica para:

- entender o comportamento dos clientes;
- acompanhar a performance de produtos;
- analisar vendas, receitas e ticket médio;
- servir como fonte para dashboards e relatórios de BI.

---

## Stack tecnológica

- Python
- dbt Core
- PostgreSQL
- Git
- Arquivos CSV como dados de origem

---

## Estrutura do projeto

```text
dbt_ecommerce_analytics/
├── analyses/
├── macros/
├── models/
│   ├── final/
│   │   ├── analytcs/
│   │   │   ├── customer_metrics.sql
│   │   │   ├── product_performance.sql
│   │   │   └── sales_summary.sql
│   │   ├── dimensions/
│   │   │   ├── dim_customers.sql
│   │   │   └── dim_products.sql
│   │   └── facts/
│   │       └── fct_sales.sql
│   ├── int/
│   │   ├── analytcs_int/
│   │   │   ├── int_customer_metrics.sql
│   │   │   ├── int_product_performance.sql
│   │   │   └── int_sales_summary.sql
│   │   ├── dim_int/
│   │   │   ├── int_dim_customers.sql
│   │   │   └── int_dim_products.sql
│   │   └── facts_int/
│   │       └── int_fct_sales.sql
│   ├── final.yml
│   ├── int.yml
│   ├── stg/
│   │   ├── stg_customers.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_orders.sql
│   │   └── stg_products.sql
│   └── stg.yml
├── seeds/
│   ├── raw_customer.csv
│   ├── raw_order_items.csv
│   ├── raw_orders.csv
│   ├── raw_products.csv
│   └── seeds.yml
├── snapshots/
├── tests/
├── ARCHITECTURE.md
├── CHANGELOG.md
├── QUICKSTART.md
├── dbt_project.yml
├── profiles.yml.example
├── requirements.txt
├── README.md
├── .gitignore
└── target/
```

---

## Modelos principais

### Staging

- `stg_customers`
- `stg_orders`
- `stg_order_items`
- `stg_products`

Esses modelos recebem os dados brutos e realizam limpeza, normalização e organização inicial.

### Intermediate

- `int_dim_customers`
- `int_dim_products`
- `int_fct_sales`
- `int_customer_metrics`
- `int_product_performance`
- `int_sales_summary`

Esses modelos unem as fontes e preparametrizam agregações e joins utilizados na camada final.

### Final

- `dim_customers`
- `dim_products`
- `fct_sales`
- `customer_metrics`
- `product_performance`
- `sales_summary`

Esses modelos são os mais adequados para consultas analíticas, BI e relatórios.

---

## Requisitos

Antes de começar, você precisa ter instalado:

- Python 3.9+
- PostgreSQL
- Git
- Ambiente de terminal (PowerShell, bash ou zsh)

> Se você ainda não tiver PostgreSQL instalado, acompanhe os passos abaixo para cada sistema operacional.

---

## Instalação do zero

## 1 Linux (Ubuntu/Debian)

### Instalar Python

```bash
sudo apt update
sudo apt install -y python3 python3-venv python3-pip git postgresql postgresql-contrib
```

### Verificar instalação

```bash
python3 --version
pip --version
psql --version
```

### Iniciar o PostgreSQL

```bash
sudo service postgresql start
```

### Criar banco e usuário PostgreSQL

```bash
sudo -u postgres psql
```

Dentro do `psql`:

```sql
CREATE USER meu_usuario WITH PASSWORD 'minha_senha';
CREATE DATABASE dbt_ecommerce OWNER meu_usuario;
GRANT ALL PRIVILEGES ON DATABASE dbt_ecommerce TO meu_usuario;
\q
```

---

## 2 macOS

### Instalar via Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Depois:

```bash
brew update
brew install python postgresql git
```

### Iniciar PostgreSQL

```bash
brew services start postgresql
```

### Criar banco e usuário PostgreSQL

```bash
psql postgres
```

Dentro do `psql`:

```sql
CREATE USER meu_usuario WITH PASSWORD 'minha_senha';
CREATE DATABASE dbt_ecommerce OWNER meu_usuario;
GRANT ALL PRIVILEGES ON DATABASE dbt_ecommerce TO meu_usuario;
\q
```

---

## 3 Windows 10/11

### Opção A: instalar o PostgreSQL oficial

1. Baixe o PostgreSQL em: https://www.postgresql.org/download/windows/
2. Instale com a opção de incluir `pgAdmin` e `psql`.
3. Durante a instalação, defina uma senha para o usuário `postgres`.
4. Após instalar, abra o `SQL Shell (psql)`.

### Criar banco e usuário no Windows

```sql
CREATE USER meu_usuario WITH PASSWORD 'minha_senha';
CREATE DATABASE dbt_ecommerce OWNER meu_usuario;
GRANT ALL PRIVILEGES ON DATABASE dbt_ecommerce TO meu_usuario;
```

### Opção B: instalar com winget

```powershell
winget install PostgreSQL.PostgreSQL
```

Depois, abra o terminal do PostgreSQL e execute os comandos acima.

---

## Clonar o projeto

No terminal, rode:

```bash
git clone <url-do-repositorio>
cd dbt_ecommerce_analytics
```

Se o projeto já estiver localmente no seu computador, basta entrar na pasta:

```bash
cd dbt_ecommerce_analytics
```

---

## Instalar dependências do projeto

### Criar ambiente virtual

#### Linux/macOS

```bash
python3 -m venv .venv
source .venv/bin/activate
```

#### Windows PowerShell

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
```

#### Windows CMD

```cmd
py -m venv .venv
.venv\Scripts\activate.bat
```

### Instalar as dependências

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

A dependência principal do projeto está no arquivo `requirements.txt`:

```txt
dbt-core==1.12.3
dbt-postgres==1.11.0
```

---

## Configurar o profile do dbt

O dbt usa o arquivo `profiles.yml` para conectar ao PostgreSQL.

### Linux/macOS

```bash
mkdir -p ~/.dbt
cp profiles.yml.example ~/.dbt/profiles.yml
```

### Windows

No PowerShell:

```powershell
New-Item -ItemType Directory -Force "$HOME\.dbt" | Out-Null
Copy-Item profiles.yml.example "$HOME\.dbt\profiles.yml"
```

### Conteúdo inicial do profile

```yaml
dbt_ecommerce_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: meu_usuario
      password: minha_senha
      port: 5432
      dbname: dbt_ecommerce
      schema: public
      threads: 4
```

Edite o arquivo com os dados reais do seu PostgreSQL.

---

## Validar a conexão

Execute:

```bash
dbt debug
```

Se tudo estiver correto, você verá uma mensagem confirmando que os checks passaram.

Se ocorrer algum erro, verifique:

- se o PostgreSQL está rodando;
- se o banco existe;
- se o usuário e senha estão corretos;
- se o arquivo `~/.dbt/profiles.yml` foi criado corretamente.

---

## Executar o projeto

### Carregar seeds

```bash
dbt seed
```

### Rodar os modelos

```bash
dbt run
```

### Executar testes

```bash
dbt test
```

### Rodar tudo em um único comando

```bash
dbt build
```

### Gerar documentação

```bash
dbt docs generate
```

### Servir a documentação localmente

```bash
dbt docs serve
```

Em seguida, abra no navegador a URL exibida no terminal, normalmente:

```text
http://localhost:8000
```

---

## Fluxo recomendado para uso diário

```bash
dbt seed
dbt run
dbt test
```

Ou, para uma execução completa:

```bash
dbt build
```

---

## Exemplos de consultas

Depois de rodar os modelos, você pode consultar os dados no PostgreSQL.

### Ver as vendas detalhadas

```sql
SELECT * FROM public.fct_sales LIMIT 20;
```

### Ver métricas por cliente

```sql
SELECT * FROM public.customer_metrics ORDER BY total_spent DESC LIMIT 10;
```

### Ver performance de produtos

```sql
SELECT * FROM public.product_performance ORDER BY revenue DESC LIMIT 10;
```

### Ver resumo mensal

```sql
SELECT * FROM public.sales_summary ORDER BY month DESC LIMIT 12;
```

---

## Documentação do projeto

Os principais metadados do projeto ficam em:

- `models/stg.yml`
- `models/int.yml`
- `models/final.yml`
- `seeds/seeds.yml`

Esses arquivos descrevem as tabelas e colunas, além de testes como `not_null` e `unique`.

---

## Dicas de troubleshooting

### Erro: profile not found

```bash
ls ~/.dbt
```

Se o arquivo não existir:

```bash
mkdir -p ~/.dbt
cp profiles.yml.example ~/.dbt/profiles.yml
```

### Erro: connection refused

Verifique se o PostgreSQL está ativo.

Linux:

```bash
sudo service postgresql status
```

macOS:

```bash
brew services list
```

### Erro: database does not exist

Crie o banco manualmente no PostgreSQL:

```sql
CREATE DATABASE dbt_ecommerce;
```

### Erro: permission denied

Ajuste as permissões do usuário no PostgreSQL:

```sql
GRANT ALL PRIVILEGES ON DATABASE dbt_ecommerce TO meu_usuario;
```

---

## Boas práticas

- mantenha o ambiente virtual ativo ao trabalhar com o projeto;
- sempre valide a conexão com `dbt debug` antes de rodar o pipeline;
- execute `dbt build` para validar o fluxo completo;
- use `dbt docs serve` para navegar pela documentação e lineage dos modelos;
- não versionar arquivos gerados em `target/` em ambientes de produção.

---

## Recursos úteis

- Documentação oficial do dbt: https://docs.getdbt.com/
- Documentação do PostgreSQL: https://www.postgresql.org/docs/
- Arquitetura do projeto: [ARCHITECTURE.md](ARCHITECTURE.md)
- Guia rápido: [QUICKSTART.md](QUICKSTART.md)

---

## Conclusão

Este projeto fornece uma base sólida para analytics de e-commerce com dbt, cobrindo desde a ingestão de dados em CSV até a criação de modelos analíticos finalizados para BI.

Com os passos acima, qualquer pessoa consegue configurar o ambiente do zero, instalar as dependências, conectar ao PostgreSQL e executar o pipeline completo.

