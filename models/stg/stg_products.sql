-- =============================================================================
-- STAGING: stg_products
-- =============================================================================
-- Descrição: modelo de staging para produtos, normalizando nome, categoria e preço
--            vindos da seed raw_products para uso nas camadas downstream.
-- Origem: raw_products
-- Materialização: table
-- Objetivo: alimentar dimensões e fatos de produtos.
-- =============================================================================

{{
    config(
        materialized = 'table',
    )
}}

select
    a.product_id,
    a.product_name as product,  -- Renomeia para padrão camelCase
    a.category,
    a.price
from {{ ref('raw_products') }} a