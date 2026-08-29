-- =============================================================================
-- FINAL: Tabela de Fatos - Vendas
-- =============================================================================
-- Descrição: Tabela de fatos central que registra cada venda com suas dimensões
--            (cliente, produto, etc). Centro da análise analítica.
-- Materialización: VIEW (com agregações)
-- Frequência: Atualizada a cada execução dbt run
-- Uso: Análises de vendas, receita, produtos mais vendidos, comportamento de compra
-- Granularidade: Um registro por item de pedido
-- =============================================================================

{{
    config(
        materialized = 'view',
        schema = 'final_facts'
    )
}}

select
    a.order_id,
    a.product_id,
    a.customer_id,
    a.sell_date,
    a.quantity,
    a.price,
    sum(a.total) as total_amount  -- Soma do total dos itens
from {{ ref('int_order_details') }} a
group by 1, 2, 3, 4, 5, 6
