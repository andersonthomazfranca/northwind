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
),

    pedido_item as (
        select
        order_id as id_pedido,
        sum(quantity) as quantidade_total,
        sum(unit_price*(1-discount)*quantity) as valor_faturado,
        count (*) as quantidade_itens
        from {{ source('northwind_etl', 'order_details')}}
        group by order_id
    ),

    unificar_dados as (
        select
        dados_fonte.id_pedido,
        id_funcionario,
        id_cliente,
        id_transportadora,
        data_pedido,
        data_prevista,
        endereco_entrega,
        cidade_entrega,
        regiao_entrega,
        pais_entrega,
        data_expedicao,
        recebedor,
        cep_entrega,
        frete,
        quantidade_total,
        valor_faturado,
        quantidade_itens
        from dados_fonte
        left join pedido_item on dados_fonte.id_pedido = pedido_item.id_pedido
    )
select * from unificar_dados