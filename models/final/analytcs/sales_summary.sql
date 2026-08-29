-- =============================================================================
-- FINAL: Análise - Resumo de Vendas
-- =============================================================================
-- Descrição: Tabela analítica com resumo de vendas agregadas por mês.
--            Inclui totais de vendas, transações, itens e ticket médio.
--            Usada para monitoramento de KPIs gerais e trends de negócio.
-- Materialización: VIEW
-- Frequência: Atualizada a cada execução dbt run
-- Granularidade: Um registro por mês
-- Uso: Sales monitoring, trend analysis, business health checks
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
    substring(cast(a.sell_date as varchar), 1, 7) as month,  -- Ano-Mês (YYYY-MM)
    count(a.order_id) as orders,                             -- Número de pedidos
    sum(a.quantity) as items_sold,                           -- Total de itens
    sum(a.total_amount) as revenue,                          -- Receita total
    round(avg(a.total_amount)::numeric, 2) as average_ticket -- Ticket médio
from {{ ref('fct_sales') }} a
group by 1