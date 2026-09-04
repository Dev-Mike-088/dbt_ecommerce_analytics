-- =============================================================================
-- STAGING: stg_customers
-- =============================================================================
-- Descrição: modelo de staging para clientes, padronizando e validando os dados
--            vindos da seed raw_customer antes de alimentar a camada intermediate.
-- Origem: raw_customer
-- Materialização: table
-- Objetivo: preparar a base para joins e enriquecimentos downstream.
-- =============================================================================

{{
    config(
        materialized = 'table'
    )
}}

select
    a.customer_id,
    a.customer_name as name,    -- Renomeia para padrão camelCase
    a.email,
    a.created_at
from {{ ref('raw_customer') }} a