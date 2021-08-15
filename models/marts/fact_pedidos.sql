with orders as (
    select *
    from {{ ref('stg_orders')}}
    ),

    clientes as (
        select *
        from {{ ref('dim_clientes')}}
    ),

    fornecedores as (
        select *
        from {{ ref('dim_fornecedores')}}
    ),

    funcionarios as (
        select *
        from {{ ref('dim_funcionarios')}}
    ),

    produtos as (
        select *
        from {{ ref('dim_produtos')}}
    ),

    transportadoras as (
        select *
        from {{ ref('dim_transportadoras')}}
    ),

    tabela_fato as(
        select
            id_pedido,
            sk_funcionario, -- chave autoincremental
            sk_cliente, -- chave autoincremental
            sk_transportadora, -- chave autoincremental
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
        from orders
        left join clientes on orders.id_cliente = clientes.id_cliente
        left join funcionarios on orders.id_funcionario = funcionarios.id_funcionario
        left join transportadoras on orders.id_transportadora = transportadoras.id_transportadora
    )

select * from tabela_fato