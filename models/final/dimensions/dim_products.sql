-- =============================================================================
-- FINAL: Dimensão de Produtos
-- =============================================================================
-- Descrição: Tabela de dimensão contendo informações sobre produtos,
--            categorias e preços. Utilizada para análises de performance de produtos.
-- Materialización: VIEW
-- Frequência: Atualizada a cada execução dbt run
-- Uso: Análises de vendas por produto, comparações de categoria, trends de preço
-- =============================================================================

{{
    config(
        materialized = 'view'
    )
}}

select
    a.product_id as id,
    a.product,
    a.category,
    a.price
from {{ ref('int_products') }} a