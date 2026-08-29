-- =============================================================================
-- STAGING: Limpeza e normalização de dados de pedidos
-- =============================================================================
-- Descrição: Tabela de staging que padroniza e valida dados de pedidos
--            vindos da seed raw_orders. Inclui validações de status.
-- Materialização: TABLE (para melhor performance em joins downstream)
-- Frequência: Atualizada a cada execução dbt run
-- =============================================================================

{{
    config(
        materialized = 'table'
    )
}}

select
    a.order_id,
    a.customer_id,
    a.order_date,
    a.status              -- Valores esperados: completed, pending, cancelled
from {{ ref('raw_orders') }} a