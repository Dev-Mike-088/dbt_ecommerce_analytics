-- =============================================================================
-- FINAL: dim_customers
-- =============================================================================
-- Descrição: dimensão final de clientes, expondo atributos principais para análise
--            comercial, segmentação e acompanhamento do relacionamento com o cliente.
-- Origem: int_dim_customers
-- Materialização: view
-- Objetivo: disponibilizar a tabela analítica de clientes para BI e relatórios.
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
*
from {{ ref('int_dim_customers') }} a