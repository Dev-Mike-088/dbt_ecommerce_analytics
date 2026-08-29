-- =============================================================================
-- INTERMEDIATE: Transformações de dados de produtos
-- =============================================================================
-- Descrição: Tabela intermediária que aplica transformações aos dados
--            de produtos do staging. Serve como base para dim_products.
-- Materialización: INCREMENTAL (para otimizar atualizações)
-- Frequência: Atualizada incrementalmente a cada execução dbt run
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    *
from {{ ref('stg_products') }}