with dados_fonte as (
    select
        order_id as id_pedido,
        product_id as id_produto,
        unit_price as preco_unit,
        quantity as quantidade,
        discount as desconto
    from {{ source('northwind_etl', 'order_details')}}
)
select * from dados_fonte