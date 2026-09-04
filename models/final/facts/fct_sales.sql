-- =============================================================================
-- FINAL: fct_sales
-- =============================================================================
-- Descrição: tabela final de fatos de vendas, registrando cada item vendido com
--            referência ao cliente, produto e data da transação.
-- Origem: int_fct_sales
-- Materialização: view
-- Objetivo: disponibilizar a base granular de vendas para relatórios e métricas analíticas.
-- =============================================================================

{{
    config(
        materialized = 'view',
    )
}}

select
*
from {{ ref('int_fct_sales') }} 
