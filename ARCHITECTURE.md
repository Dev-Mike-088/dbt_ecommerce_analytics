# 🏗️ Arquitetura do Projeto dbt Ecommerce Analytics

Este documento descreve a arquitetura de dados e a estrutura do projeto dbt.

## Visão Geral

O projeto segue a **arquitetura em três camadas** (medallion architecture):

```
┌─────────────────────────────────────────────────────────────┐
│                    RAW DATA (Seeds CSV)                      │
│  raw_customers | raw_orders | raw_order_items | raw_products│
└────────────────────────────┬────────────────────────────────┘
                             │
                    ┌────────▼────────┐
                    │   STAGING (STG) │
                    │   Limpeza       │
                    │   Normalização  │
                    │   Validação     │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────▼────────┐  ┌────────▼────────┐  ┌───────▼─────┐
   │stg_customers│  │ stg_order_items │  │stg_products │
   └────┬────────┘  └────────┬────────┘  └───────┬─────┘
        │                    │                    │
        │          ┌─────────▼────────────┐       │
        │          │  stg_orders          │       │
        │          └─────────┬────────────┘       │
        │                    │                    │
        └────────────────────┼────────────────────┘
                             │
                    ┌────────▼────────────┐
                    │ INTERMEDIATE (INT)  │
                    │ Joins complexos     │
                    │ Agregações          │
                    │ Enriquecimento      │
                    └────────┬────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────▼────────┐  ┌────────▼────────┐  ┌───────▼─────────┐
   │int_customers│  │int_order_details│  │int_products     │
   └────┬────────┘  └────────┬────────┘  └───────┬─────────┘
        │                    │                    │
        └────────────────────┼────────────────────┘
                             │
                    ┌────────▼────────────┐
                    │  FINAL (FINAL)      │
                    │ Modelos Analíticos  │
                    │ Prontos para BI     │
                    └────────┬────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────▼──────────────┐    │      ┌──────────────▼─────────┐
   │  DIMENSIONS       │    │      │  FACTS & ANALYTICS     │
   │ ┌──────────────┐  │    │      │ ┌────────────────────┐ │
   │ │dim_customers │  │    │      │ │fct_sales (facts)   │ │
   │ │dim_products  │  │    │      │ │customer_metrics    │ │
   │ └──────────────┘  │    │      │ │product_performance │ │
   │                   │    │      │ │sales_summary       │ │
   └───────────────────┘    │      │ └────────────────────┘ │
                            │      └────────────────────────┘
                            │
                    ┌───────▼────────┐
                    │ BI TOOLS       │
                    │ Dashboards     │
                    │ Relatórios     │
                    │ Análises       │
                    └────────────────┘
```

## Camadas de Dados

### 1️⃣ STAGING (STG)

**Propósito:** Limpeza, normalização e validação de dados brutos.

**Características:**
- Transformações básicas (rename de colunas, tipos de dados)
- Validações de integridade (not_null, unique)
- Remoção de dados duplicados
- Materialização: TABLE (melhor performance)
- Schema: `stg`

**Modelos:**
- `stg_customers` - Clientes limpos e validados
- `stg_orders` - Pedidos limpos e validados
- `stg_order_items` - Itens de pedidos normalizados
- `stg_products` - Produtos limpos e categorizados

**Padrões:**
```sql
{{
    config(
        materialized = 'table',
        schema = 'stg'
    )
}}

select
    a.column_id,
    a.column_name as readable_name,
    a.created_date
from {{ ref('raw_table') }} a
```

### 2️⃣ INTERMEDIATE (INT)

**Propósito:** Transformações complexas, joins e agregações intermediárias.

**Características:**
- Joins entre múltiplas tabelas
- Cálculos intermediários
- Enriquecimento de dados
- Materialização: INCREMENTAL (otimização de performance)
- Schema: `int`

**Modelos:**
- `int_customers` - Clientes com transformações intermediárias
- `int_order_details` - Detalhes enriquecidos de pedidos (joins complexos)
- `int_products` - Produtos com transformações intermediárias

**Padrão:**
```sql
{{
    config(
        materialized = 'incremental',
        schema = 'int'
    )
}}

select
    a.id,
    b.name,
    sum(c.amount) as total
from {{ ref('stg_table_a') }} a
inner join {{ ref('stg_table_b') }} b on a.id = b.id
left join {{ ref('stg_table_c') }} c on a.id = c.id
group by 1, 2
```

### 3️⃣ FINAL (FINAL)

**Propósito:** Modelos prontos para BI, relatórios e dashboards.

#### Dimensions (Dimensões)

Tabelas que descrevem entidades (clientes, produtos, etc).

- `dim_customers` - Dimensão de clientes
  - Chave primária: `customer_id`
  - Campos: nome, email, data de criação
  - Uso: Análises por cliente

- `dim_products` - Dimensão de produtos
  - Chave primária: `product_id`
  - Campos: nome, categoria, preço
  - Uso: Análises por produto

**Características:**
- Materialização: TABLE
- Schema: `final_dimensions`
- Contêm informações descritivas
- Uma linha por entidade

#### Facts (Tabelas de Fatos)

Tabelas que contêm eventos e métricas (vendas, transações).

- `fct_sales` - Fatos de vendas
  - Granularidade: Um registro por item de pedido
  - Chaves estrangeiras: order_id, product_id, customer_id
  - Métricas: quantidade, preço, valor total
  - Uso: Análises de vendas, receita, performance

**Características:**
- Materialização: TABLE ou VIEW
- Schema: `final_facts`
- Contêm referências a dimensions
- Contêm métricas agregadas

#### Analytics (Análises)

Tabelas pré-agregadas para dashboards e relatórios.

- `customer_metrics` - Métricas por cliente
  - Granularidade: Um registro por cliente
  - Métricas: total de pedidos, total gasto, ticket médio
  - Uso: Dashboards de segmentação de clientes

- `product_performance` - Performance de produtos
  - Granularidade: Um registro por produto
  - Métricas: quantidade vendida, receita, número de clientes
  - Uso: Análises de portfólio de produtos

- `sales_summary` - Resumo de vendas
  - Granularidade: Um registro por mês
  - Métricas: receita, transações, itens, ticket médio
  - Uso: Monitoramento de KPIs

**Características:**
- Materialização: VIEW (atualizam constantemente)
- Schema: `final_analytics`
- Dados pré-agregados
- Otimizadas para performance em BI

## Materialização de Modelos

| Tipo | Uso | Performance | Atualização |
|------|-----|-------------|------------|
| **TABLE** | Dados que precisam ser acessados rapidamente | Alta | Completa a cada run |
| **VIEW** | Modelos simples, transformações rápidas | Depende da query | Recalcula sempre |
| **INCREMENTAL** | Modelos grandes, atualizações incrementais | Muito alta | Apenas novos dados |
| **SNAPSHOT** | Histórico/mudanças ao longo do tempo | Alta | Diffs apenas |

## Schemas no PostgreSQL

```
postgres/
├── raw/                      # Dados brutos dos seeds
│   ├── raw_customer
│   ├── raw_orders
│   ├── raw_order_items
│   └── raw_products
├── stg/                      # Staging (limpeza)
│   ├── stg_customers
│   ├── stg_orders
│   ├── stg_order_items
│   └── stg_products
├── int/                      # Intermediate (joins)
│   ├── int_customers
│   ├── int_order_details
│   └── int_products
├── final_dimensions/         # Dimensões
│   ├── dim_customers
│   └── dim_products
├── final_facts/              # Fatos
│   └── fct_sales
└── final_analytics/          # Análises
    ├── customer_metrics
    ├── product_performance
    └── sales_summary
```

## Fluxo de Dados (DAG)

```
raw_customer ──┐
raw_orders ───┤─→ stg_customers ─┐
              │                   │
raw_products ─┼─→ stg_products ───┼─→ int_customers ─→ dim_customers
              │                   │
raw_order_items ┬─→ stg_order_items │
                │                   │
                └──→ stg_orders ────┘
                     │
                     └─→ int_order_details ─→ fct_sales ─→ {
                                                           customer_metrics,
                                                           product_performance,
                                                           sales_summary
                                                         }
```

## Testes

O projeto inclui testes automáticos para garantir qualidade:

### Testes de Staging (stg.yml)

- **Not Null**: Campos obrigatórios não contêm nulos
- **Unique**: Chaves primárias são únicas
- **Relationships**: Chaves estrangeiras referenciam dados válidos
- **Accepted Values**: Status contêm valores esperados

### Testes Customizados

Podem ser criados em `tests/` para lógica específica.

## Versionamento

- **Semantic Versioning**: MAJOR.MINOR.PATCH
- Versão atual: **1.0.0**
- Atualizar em `dbt_project.yml` quando necessário

## Boas Práticas Implementadas

✅ Arquitetura em três camadas (medallion)  
✅ Namespacing em schemas separados  
✅ Testes automáticos integrados  
✅ Documentação em YAML (schema.yml)  
✅ Comentários nos modelos SQL  
✅ Naming conventions consistentes  
✅ Materialização otimizada por camada  
✅ Lineage explícito com `ref()`  

## Como Estender

### Adicionar um novo modelo

1. Criar arquivo em `models/stg/seu_modelo.sql`
2. Documentar em `models/stg.yml`
3. Executar: `dbt run --select seu_modelo`
4. Testar: `dbt test --select seu_modelo`

### Adicionar um novo teste

1. Criar teste em `tests/seu_teste.sql`
2. Adicionar referência em YAML
3. Executar: `dbt test`

## Recursos

- [dbt Documentation](https://docs.getdbt.com/)
- [Analytics Engineering Guide](https://www.getdbt.com/analytics-engineering/)
- [SQL Style Guide](https://docs.getdbt.com/guides/style-guide/sql-style-guide)