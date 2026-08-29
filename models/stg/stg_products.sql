-- =============================================================================
-- STAGING: Limpeza e normalização de dados de produtos
-- =============================================================================
-- Descrição: Tabela de staging que padroniza e valida dados de produtos
--            vindos da seed raw_products. Normaliza nomes e categorias.
-- Materialização: TABLE (para melhor performance em joins downstream)
-- Frequência: Atualizada a cada execução dbt run
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