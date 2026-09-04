-- =============================================================================
-- STAGING: stg_orders
-- =============================================================================
-- Descrição: modelo de staging para pedidos, padronizando a estrutura e os dados
--            vindos da seed raw_orders para uso na camada intermediate.
-- Origem: raw_orders
-- Materialização: table
-- Objetivo: consolidar pedidos e status para joins com clientes e itens.
-- =============================================================================

{{
    config(
        materialized = 'table'
    )
}}

select
    a.order_id,
    a.customer_id,
    a.order_date,
    a.status              -- Valores esperados: completed, pending, cancelled
from {{ ref('raw_orders') }} a