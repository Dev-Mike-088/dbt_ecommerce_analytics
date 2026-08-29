-- =============================================================================
-- STAGING: Limpeza e normalização de itens de pedidos
-- =============================================================================
-- Descrição: Tabela de staging que relaciona produtos com pedidos
--            e inclui quantidades e preços de cada item.
-- Materialização: TABLE (para melhor performance em joins downstream)
-- Frequência: Atualizada a cada execução dbt run
-- =============================================================================

{{
    config(
        materialized = 'table'
    )
}}

select
    a.order_item_id,
    a.order_id,
    a.product_id,
    a.quantity,
    a.unit_price
from {{ ref('raw_order_items') }} a 