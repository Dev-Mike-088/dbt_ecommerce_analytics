-- =============================================================================
-- FINAL: Análise - Performance de Produtos
-- =============================================================================
-- Descrição: Tabela analítica com métricas de performance por produto.
--            Inclui quantidade vendida, receita total, número de compradores.
--            Usada para análises de produto e estratégia de portfólio.
-- Materialización: VIEW
-- Frequência: Atualizada a cada execução dbt run
-- Granularidade: Um registro por produto
-- Uso: Product profitability, bestsellers, underperforming products
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
    a.product_id,
    b.product,
    b.category,
    count(a.quantity) as units_sold,                          -- Quantidade vendida
    round(sum(a.total_amount)::numeric, 2) as revenue         -- Receita total
from {{ ref('fct_sales') }} a
left join {{ ref('dim_products') }} b
    on a.product_id = b.id
group by 1, 2, 3