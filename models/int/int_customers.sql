-- =============================================================================
-- INTERMEDIATE: Transformações de dados de clientes
-- =============================================================================
-- Descrição: Tabela intermediária que aplica transformações e enriquecimentos
--            aos dados de clientes do staging. Serve como base para dim_customers.
-- Materialização: INCREMENTAL (para otimizar atualizações)
-- Frequência: Atualizada incrementalmente a cada execução dbt run
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    *
from {{ ref('stg_customers') }}