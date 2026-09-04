-- =============================================================================
-- FINAL: product_performance
-- =============================================================================
-- Descrição: tabela analítica final para avaliação da performance de produtos,
--            agregando unidades vendidas e receita por categoria e item.
-- Origem: int_product_performance
-- Materialização: view
-- Objetivo: monitorar produtos mais vendidos e indicadores de lucratividade.
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
*
from {{ ref('int_product_performance') }} 