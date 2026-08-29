-- =============================================================================
-- FINAL: Análise - Métricas de Clientes
-- =============================================================================
-- Descrição: Tabela analítica com métricas agregadas por cliente.
--            Inclui número de pedidos, total gasto, itens comprados, ticket médio.
--            Usada para análises de comportamento e segmentação de clientes.
-- Materialización: VIEW
-- Frequência: Atualizada a cada execução dbt run
-- Granularidade: Um registro por cliente
-- Uso: RFM analysis, customer segmentation, lifetime value
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
    a.customer_id as id,
    count(a.order_id) as orders,              -- Número total de pedidos
    sum(a.quantity) as items_bought,          -- Total de itens comprados
    sum(a.total_amount) as total_spent,       -- Valor total gasto
    round(avg(a.total_amount)::numeric, 2) as average_ticket  -- Ticket médio
from {{ ref('fct_sales') }} a
group by 1