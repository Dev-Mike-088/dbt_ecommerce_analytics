-- =============================================================================
-- FINAL: Dimensão de Clientes
-- =============================================================================
-- Descrição: Tabela de dimensão contendo informações demográficas e de contato
--            de clientes. Utilizada em análises e relatórios de vendas por cliente.
-- Materialización: VIEW
-- Frequência: Atualizada a cada execução dbt run
-- Uso: Análises de comportamento, segmentação e lifetime value de clientes
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
    a.customer_id as id,
    a.name,
    a.email,
    a.created_at as first_login
from {{ ref('int_customers') }} a