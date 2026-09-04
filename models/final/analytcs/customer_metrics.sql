-- =============================================================================
-- FINAL: customer_metrics
-- =============================================================================
-- Descrição: tabela analítica final com métricas agregadas por cliente, incluindo
--            pedidos, itens comprados, gasto total e ticket médio.
-- Origem: int_customer_metrics
-- Materialização: view
-- Objetivo: apoiar análise de retenção, comportamento e segmentação de clientes.
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
*
from {{ ref('int_customer_metrics') }} 