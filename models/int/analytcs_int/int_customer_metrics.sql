-- =============================================================================
-- INTERMEDIATE: int_customer_metrics
-- =============================================================================
-- Descrição: métricas agregadas por cliente calculadas a partir do fato de vendas,
--            antes de expor a visão final para análise comercial.
-- Origem: int_fct_sales
-- Materialização: incremental
-- Objetivo: calcular pedidos, itens comprados, gasto total e ticket médio.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    a.customer_id as id,
    count(a.order_id) as orders,              -- Número total de pedidos
    sum(a.quantity) as items_bought,          -- Total de itens comprados
    sum(a.total_amount) as total_spent,       -- Valor total gasto
    round(avg(a.total_amount)::numeric, 2) as average_ticket  -- Ticket médio
from {{ ref('int_fct_sales') }} a
group by 1