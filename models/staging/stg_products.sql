with dados_fonte as (
    select
        row_number() over (order by product_id) as sk_produto, -- chave autoincremental
        product_id as id_produto,
        category_id as id_categoria,
        supplier_id as id_fornecedor,
        product_name as nome_produto,
        unit_price as preco_unit,
        units_in_stock as estoque,
        units_on_order as unidades_em_pedido,
        reorder_level as quantidade_reposicao,
        quantity_per_unit as volume,
        discontinued as descontinuado
    from {{ source('northwind_etl', 'products')}}
)
select * from dados_fonte