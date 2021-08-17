with
    orders as (
        select *
        from {{ ref('stg_orders')}}
    ),
    
    detalhes as (
        select *
        from {{ ref('stg_order_details')}}
    ),

    clientes as (
        select *
        from {{ ref('dim_clientes')}}
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

    pedidos as(
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
    ),

    ordem_detalhes as (
        select
            id_pedido,
            sk_produto, -- chave autoincremental
            detalhes.preco_unit,
            quantidade,
            desconto
        from detalhes
        left join produtos on detalhes.id_produto = produtos.id_produto
    ),

    tabela_fato as (
        select
            pedidos.id_pedido,
            pedidos.sk_funcionario, -- chave autoincremental
            pedidos.sk_cliente, -- chave autoincremental
            pedidos.sk_transportadora, -- chave autoincremental
            pedidos.data_pedido,
            pedidos.data_prevista,
            pedidos.endereco_entrega,
            pedidos.cidade_entrega,
            pedidos.regiao_entrega,
            pedidos.pais_entrega,
            pedidos.data_expedicao,
            pedidos.recebedor,
            pedidos.cep_entrega,
            pedidos.frete,
            ordem_detalhes.sk_produto, -- chave autoincremental
            ordem_detalhes.preco_unit,
            ordem_detalhes.quantidade,
            ordem_detalhes.desconto
        from pedidos
        left join ordem_detalhes on pedidos.id_pedido = ordem_detalhes.id_pedido
    )

select * from tabela_fato