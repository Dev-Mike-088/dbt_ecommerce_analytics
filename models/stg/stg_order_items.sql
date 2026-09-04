-- =============================================================================
-- STAGING: stg_order_items
-- =============================================================================
-- Descrição: modelo de staging para itens de pedido, trazendo quantidade e preço
--            unitário da seed raw_order_items para uso em agregações e fatos.
-- Origem: raw_order_items
-- Materialização: table
-- Objetivo: preparar os itens para joins com pedidos, clientes e produtos.
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