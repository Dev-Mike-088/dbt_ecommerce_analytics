-- =============================================================================
-- FINAL: sales_summary
-- =============================================================================
-- Descrição: tabela analítica final com resumo mensal de vendas, consolidando
--            pedidos, itens, receita e ticket médio por período.
-- Origem: int_sales_summary
-- Materialização: view
-- Objetivo: fornecer indicadores de saúde do negócio para acompanhamento por mês.
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
*
from {{ ref('int_sales_summary') }} 