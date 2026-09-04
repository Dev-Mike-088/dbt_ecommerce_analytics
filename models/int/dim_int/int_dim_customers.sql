-- =============================================================================
-- INTERMEDIATE: int_dim_customers
-- =============================================================================
-- Descrição: dimensão intermediária de clientes, preparada a partir do staging
--            para apoiar joins e transformações posteriores.
-- Origem: stg_customers
-- Materialização: view
-- Objetivo: estruturar atributos de cliente antes da camada final.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

select
    a.customer_id as id,
    a.name,
    a.email,
    a.created_at as first_login
from {{ ref('stg_customers') }} a