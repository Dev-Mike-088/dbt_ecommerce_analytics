# Changelog - dbt Ecommerce Analytics

Todas as mudanças notáveis neste projeto estão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
e este projeto segue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-08-29

### ✨ Adicionado

#### Documentação Completa
- 📖 **README.md** - Guia completo com instalação, configuração e exemplos
- 🏗️ **ARCHITECTURE.md** - Documentação da arquitetura em três camadas (medallion)
- ⚡ **QUICKSTART.md** - Guia rápido para começar em 5 minutos
- 📝 **CHANGELOG.md** - Este arquivo

#### Modelos de Dados (Staging)
- `stg_customers` - Limpeza de dados de clientes
- `stg_orders` - Limpeza de dados de pedidos
- `stg_order_items` - Limpeza de itens de pedidos
- `stg_products` - Limpeza de dados de produtos

#### Modelos Intermediários
- `int_customers` - Transformações de clientes
- `int_order_details` - Detalhes enriquecidos de pedidos (joins)
- `int_products` - Transformações de produtos

#### Modelos Finais - Dimensões
- `dim_customers` - Dimensão de clientes para BI
- `dim_products` - Dimensão de produtos para BI

#### Modelos Finais - Fatos
- `fct_sales` - Tabela de fatos de vendas

#### Modelos Finais - Analytics
- `customer_metrics` - Métricas agregadas por cliente
- `product_performance` - Performance de produtos
- `sales_summary` - Resumo de vendas mensais

#### Testes Automáticos
- Testes `not_null` para campos obrigatórios
- Testes `unique` para chaves primárias
- Testes `relationships` para integridade referencial
- Testes `accepted_values` para validação de domínio

#### Configuração do Projeto
- `dbt_project.yml` - Configuração completa com documentação
- `.gitignore` - Ignore patterns adequado
- `profiles.yml.example` - Template para conexão
- `requirements.txt` - Dependências Python

#### Seeds (Dados de Exemplo)
- `raw_customer.csv` - Dados brutos de clientes
- `raw_orders.csv` - Dados brutos de pedidos
- `raw_order_items.csv` - Dados brutos de itens
- `raw_products.csv` - Dados brutos de produtos

#### Documentação YAML
- `models/stg.yml` - Documentação de modelos staging
- `models/int.yml` - Documentação de modelos intermediate
- `models/final.yml` - Documentação de modelos final
- `seeds/seeds.yml` - Documentação de seeds

### 🏆 Recursos Principais

- ✅ Arquitetura em três camadas (medallion architecture)
- ✅ Materialização otimizada por camada (TABLE, VIEW, INCREMENTAL)
- ✅ Schemas separados para organização lógica
- ✅ Testes automáticos integrados
- ✅ Documentação completa em YAML
- ✅ Comentários explicativos em SQL
- ✅ Guias detalhados de setup e desenvolvimento
- ✅ Suporte multi-plataforma (Linux, macOS, Windows)

### 🔧 Configurações Técnicas

- **Versão dbt**: 1.12.3+
- **Banco de Dados**: PostgreSQL 12+
- **Python**: 3.9+
- **Materialização padrão**: TABLE para STG, INCREMENTAL para INT
- **Número de threads**: Configurável (recomendado: 4)

### 📊 Esquema do Banco de Dados

```
raw/                 # Dados brutos dos seeds
├── raw_customer
├── raw_orders
├── raw_order_items
└── raw_products

stg/                 # Staging (limpeza)
├── stg_customers
├── stg_orders
├── stg_order_items
└── stg_products

int/                 # Intermediate (joins)
├── int_customers
├── int_order_details
└── int_products

final_dimensions/    # Dimensões
├── dim_customers
└── dim_products

final_facts/         # Tabelas de fatos
└── fct_sales

final_analytics/     # Análises
├── customer_metrics
├── product_performance
└── sales_summary
```

### 📈 Lineage (DAG)

```
raw_customer ──┐
raw_orders ───┤──> stg_customers ──┐
raw_products ─┼──> stg_products ───┼──> int_customers ──> dim_customers
raw_order_items ──> stg_order_items │
                   stg_orders ──────┘──> int_order_details ──> fct_sales
                                                                    │
                                                                    ├──> customer_metrics
                                                                    ├──> product_performance
                                                                    └──> sales_summary
```

### 🎯 Casos de Uso Suportados

- ✅ Análise de vendas por período
- ✅ Segmentação de clientes (RFM)
- ✅ Performance de produtos
- ✅ Monitoramento de KPIs
- ✅ Relatórios de receita
- ✅ Dashboard de clientes

### 📚 Documentação por Arquivo

| Arquivo | Conteúdo |
|---------|----------|
| README.md | Setup, instalação, execução, troubleshooting |
| QUICKSTART.md | Guia rápido para começar em 5 minutos |
| ARCHITECTURE.md | Explicação detalhada da arquitetura |
| CONTRIBUTING.md | Guia para desenvolvimento e contribuições |
| dbt_project.yml | Configuração do projeto com comentários |
| .gitignore | Padrões de ignore adequados |
| models/stg.yml | Documentação de modelos staging |
| models/int.yml | Documentação de modelos intermediate |
| models/final.yml | Documentação de modelos final |
| seeds/seeds.yml | Documentação de seeds |

### 🚀 Primeiros Passos

1. Leia [QUICKSTART.md](QUICKSTART.md) para setup rápido
2. Leia [README.md](README.md) para guia completo
3. Explore [ARCHITECTURE.md](ARCHITECTURE.md) para entender estrutura
4. Consulte [CONTRIBUTING.md](CONTRIBUTING.md) para desenvolvimento

### 🐛 Problemas Conhecidos

- Nenhum no momento

### 🔮 Roadmap Futuro (v1.1.0+)

- [ ] Adicionar snapshots para SCD tipo 2
- [ ] Implementar macros reutilizáveis
- [ ] Adicionar testes de anomalia
- [ ] Integração com dbt Cloud
- [ ] Exposições (dbt exposures)
- [ ] Modelos incrementais mais sofisticados
- [ ] Macros para geração automática de testes
- [ ] Testes de contrato (contract tests)
- [ ] CI/CD com GitHub Actions
- [ ] Documentação em múltiplas línguas

---

## Convenção de Versionamento

Este projeto segue [Semantic Versioning](https://semver.org/):

- **MAJOR**: Mudanças incompatíveis (breaking changes)
- **MINOR**: Novas funcionalidades (backwards compatible)
- **PATCH**: Correções de bug (backwards compatible)

Exemplo: `1.0.0`
- `1` = MAJOR (versão principal)
- `0` = MINOR (novas features)
- `0` = PATCH (correções)

---

## Como Usar Este Changelog

- **Adicionado** para novas funcionalidades
- **Alterado** para mudanças em funcionalidades existentes
- **Deprecado** para funcionalidades a serem removidas
- **Removido** para funcionalidades removidas
- **Corrigido** para correções de bugs
- **Segurança** para vulnerabilidades de segurança

---

## Contribuições

Veja [CONTRIBUTING.md](CONTRIBUTING.md) para informações sobre como contribuir.

---

**Última atualização:** 29/08/2026