-- =============================================================================
-- INTERMEDIATE: int_dim_products
-- =============================================================================
-- Descrição: dimensão intermediária de produtos, normalizando os dados de catálogo
--            vindos do staging para apoiar a camada final.
-- Origem: stg_products
-- Materialização: incremental
-- Objetivo: preparar atributos como produto, categoria e preço para consumo analítico.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    a.product_id as id,
    a.product,
    a.category,
    a.price
from {{ ref('stg_products') }} a