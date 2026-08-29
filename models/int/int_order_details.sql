-- =============================================================================
-- INTERMEDIATE: Detalhes enriquecidos de pedidos
-- =============================================================================
-- Descrição: Tabela intermediária que enriquece os itens de pedidos com dados
--            de clientes e produtos. Realiza joins complexos entre múltiplas
--            tabelas de staging e calcula totais por item.
-- Materialización: INCREMENTAL (para otimizar atualizações)
-- Frequência: Atualizada incrementalmente a cada execução dbt run
-- Depende de: stg_orders, stg_customers, stg_order_items, stg_products
-- =============================================================================

{{
    config(
        materialized = 'incremental',
        schema = 'int'
    )
}}

select
    a.order_id,
    d.product_id,
    a.customer_id,
    b.name,              -- Nome do cliente
    d.product,           -- Nome do produto
    d.category,          -- Categoria do produto
    c.quantity,          -- Quantidade do item
    d.price,             -- Preço unitário
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