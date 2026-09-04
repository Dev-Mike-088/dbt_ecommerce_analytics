-- =============================================================================
-- INTERMEDIATE: int_fct_sales
-- =============================================================================
-- Descrição: tabela intermediária de fatos com enriquecimento de cliente, produto
--            e pedido, consolidando o detalhamento da venda por item.
-- Origem: stg_orders, stg_customers, stg_order_items, stg_products
-- Materialização: incremental
-- Objetivo: servir como base para métricas agregadas de clientes, produtos e vendas.
-- =============================================================================

{{
    config(
        materialized = 'incremental'
    )
}}

with order_details as (
    select
        a.order_id,
        d.product_id,
        a.customer_id,
        b.name,                              -- Nome do cliente
        d.product,                           -- Nome do produto
        d.category,                          -- Categoria do produto
        c.quantity,                          -- Quantidade do item
        d.price,                             -- Preço unitário
        sum(c.quantity * d.price) as total,  -- Total do item (qty * price)
        a.order_date as sell_date            -- Data da venda
    from {{ ref('stg_orders') }} a
    inner join {{ ref('stg_customers') }} b
        on b.customer_id = a.customer_id
    inner join {{ ref('stg_order_items') }} c
        on c.order_id = a.order_id
    inner join {{ ref('stg_products') }} d
        on d.product_id = c.product_id
    group by 1, 2, 3, 4, 5, 6, 7, 8, 10
)



select
    a.order_id,
    a.product_id,
    a.customer_id,
    a.sell_date,
    a.quantity,
    a.price,
    sum(a.total) as total_amount  -- Soma do total dos itens
from order_details a
group by 1, 2, 3, 4, 5, 6
