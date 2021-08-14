with dados_fonte as (
    select
        order_id as id_pedido,
        employee_id as id_funcionario,
        customer_id as id_cliente,
        ship_via as id_transportadora,
        order_date as data_pedido,
        required_date as data_prevista,
        ship_address as endereco_entrega,
        ship_city as cidade_entrega,
        ship_region as regiao_entrega,
        ship_country as pais_entrega,
        shipped_date as data_expedicao,
        ship_name as recebedor,
        ship_postal_code as cep_entrega,
        freight as frete
    from {{ source('northwind_etl', 'orders')}}
)
select * from dados_fonte