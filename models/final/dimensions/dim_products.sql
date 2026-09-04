-- =============================================================================
-- FINAL: dim_products
-- =============================================================================
-- Descrição: dimensão final de produtos, reunindo informações de catálogo para
--            análise de categoria, preço e performance comercial.
-- Origem: int_dim_products
-- Materialização: view
-- Objetivo: disponibilizar a base analítica de produtos para dashboards e relatórios.
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
*
from {{ ref('int_dim_products') }} a