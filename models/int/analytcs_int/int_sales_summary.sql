-- =============================================================================
-- INTERMEDIATE: int_sales_summary
-- =============================================================================
-- Descrição: resumo mensal de vendas, calculado a partir do fato de vendas para
--            preparar a camada final de indicadores de performance.
-- Origem: int_fct_sales
-- Materialização: incremental
-- Objetivo: consolidar pedidos, itens vendidos, receita e ticket médio por mês.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    substring(cast(a.sell_date as varchar), 1, 7) as month,  -- Ano-Mês (YYYY-MM)
    count(a.order_id) as orders,                             -- Número de pedidos
    sum(a.quantity) as items_sold,                           -- Total de itens
    sum(a.total_amount) as revenue,                          -- Receita total
    round(avg(a.total_amount)::numeric, 2) as average_ticket -- Ticket médio
from {{ ref('int_fct_sales') }} a
group by 1