# ⚡ Quick Start - dbt Ecommerce Analytics

Este guia rápido te coloca em funcionamento em 5 minutos!

## 🚀 Instalação Rápida (5 minutos)

### 1. Setup Inicial

```bash
# Clone o repositório
git clone <repo-url>
cd dbt_ecommerce_analytics

# Crie ambiente virtual e instale
python3 -m venv .venv
source .venv/bin/activate  # Linux/macOS
# ou .venv\Scripts\activate (Windows)

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

### 2. Configure o PostgreSQL

```bash
# Certifique-se que PostgreSQL está rodando
sudo service postgresql start  # Linux
# ou abra PostgreSQL app (macOS/Windows)

# Crie um banco de dados (no psql)
createdb dbt_analytics
```

### 3. Configure o dbt

```bash
# Copie o template
mkdir -p ~/.dbt
cp profiles.yml.example ~/.dbt/profiles.yml

# Edite profiles.yml com suas credenciais
nano ~/.dbt/profiles.yml  # ou seu editor favorito
```

**profiles.yml exemplo:**
```yaml
dbt_ecommerce_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: seu_usuario
      password: sua_senha
      port: 5432
      dbname: dbt_analytics
      schema: public
      threads: 4
```

### 4. Teste a Conexão

```bash
dbt debug
# Esperado: ✓ All checks passed!
```

## 🎯 Execução Rápida

```bash
# Carregar dados de exemplo (seeds)
dbt seed

# Executar todos os modelos
dbt run

# Rodar testes
dbt test

# Ou tudo junto (seed + run + test)
dbt build

# Ver documentação
dbt docs generate
dbt docs serve  # Abre http://localhost:8000
```

## 📊 Primeiro Uso

### 1. Explorar Dados

```bash
# Conecte ao PostgreSQL
psql -U seu_usuario -d dbt_analytics

# Veja os schemas criados
\dn

# Veja os modelos staging
\dt public.stg_*

# Veja as análises finais
\dt public.fct_*
```

### 2. Queries de Exemplo

```sql
-- Ver dados de clientes
SELECT * FROM public.dim_customers LIMIT 10;

-- Ver resumo de vendas
SELECT * FROM public.sales_summary ORDER BY month DESC;

-- Ver métricas de clientes
SELECT * FROM public.customer_metrics ORDER BY total_spent DESC;

-- Ver performance de produtos
SELECT * FROM public.product_performance ORDER BY revenue DESC;
```

### 3. Conectar ao BI (Metabase, Tableau, etc)

```
Host: localhost
Port: 5432
Database: dbt_analytics
User: seu_usuario
Password: sua_senha
Schema: public

Tables disponíveis:
- dim_customers
- dim_products
- fct_sales
- customer_metrics
- product_performance
- sales_summary
```

## 🔄 Desenvolvimento

### Adicionar um Novo Modelo

```bash
# Crie arquivo
touch models/stg/novo_modelo.sql

# Edite com SQL + config
# (veja CONTRIBUTING.md para template)

# Execute
dbt run --select novo_modelo

# Teste
dbt test --select novo_modelo
```

### Fazer Alterações

```bash
# 1. Edite um modelo
nano models/stg/stg_customers.sql

# 2. Teste localmente
dbt run --select stg_customers

# 3. Valide testes
dbt test --select stg_customers

# 4. Veja impacto downstream
dbt dag --select stg_customers
```

## 📚 Estrutura Importante

```
models/
├── stg/          # Staging: limpeza de dados
├── int/          # Intermediate: joins complexos
└── final/        # Final: analytics prontos para BI
    ├── dimensions/       # Tabelas de dimensão
    ├── facts/            # Tabelas de fato
    └── analytcs/         # Análises pré-agregadas
```

## 🆘 Troubleshooting

### "Profile not found"
```bash
ls ~/.dbt/profiles.yml
# Se não existir:
cp profiles.yml.example ~/.dbt/profiles.yml
```

### "Connection refused"
```bash
# PostgreSQL não está rodando
sudo service postgresql start  # Linux
brew services start postgresql@15  # macOS

# Ou abra a app do PostgreSQL
```

### "Schema does not exist"
```bash
# No psql:
CREATE SCHEMA stg;
CREATE SCHEMA int;
CREATE SCHEMA final;
```

### "Module not found"
```bash
# Reinstale dependências
pip install -r requirements.txt --force-reinstall
```

## 📖 Próximos Passos

1. **Ler README.md completo** - Setup detalhado
2. **Ler ARCHITECTURE.md** - Entender estrutura
3. **Ler CONTRIBUTING.md** - Como contribuir
4. **Explorar models/** - Ver exemplos
5. **Executar `dbt docs serve`** - Documentação interativa

## 🎯 Comandos Mais Usados

```bash
# Desenvolvimento
dbt run                    # Rodar todos os modelos
dbt run -s modelo         # Rodar modelo específico
dbt test                  # Rodar todos os testes
dbt build                 # Seed + run + test

# Exploração
dbt docs serve            # Ver documentação web
dbt dag                   # Ver dependências
dbt freshness             # Ver freshness das fontes

# Limpeza
dbt clean                 # Remover artifacts
dbt clean && dbt run      # Clean restart

# Debug
dbt debug                 # Testar conexão
dbt run --debug           # Verbose logging
dbt parse                 # Parsear modelos
```

## ⚙️ Verificação

```bash
# Confirme que tudo está funcionando:
dbt build && dbt docs generate

# Se tudo passou:
✓ Seeds carregados
✓ Modelos executados
✓ Testes passaram
✓ Documentação gerada
```

Pronto! 🚀 Você está configurado e pronto para começar!

---

**Próximo passo:** Leia [README.md](README.md) para mais detalhes.