-- =============================================================================
-- INTERMEDIATE: int_product_performance
-- =============================================================================
-- Descrição: métricas por produto para avaliação de performance comercial,
--            calculadas com base no fato de vendas e na dimensão intermediária.
-- Origem: int_fct_sales, int_dim_products
-- Materialização: incremental
-- Objetivo: medir unidades vendidas e receita por produto antes da camada final.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    a.product_id,
    b.product,
    b.category,
    count(a.quantity) as units_sold,                          -- Quantidade vendida
    round(sum(a.total_amount)::numeric, 2) as revenue         -- Receita total
from {{ ref('int_fct_sales') }} a
left join {{ ref('int_dim_products') }} b
    on a.product_id = b.id
group by 1, 2, 3