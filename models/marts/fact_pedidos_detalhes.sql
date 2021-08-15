with detalhes as (
    select *
    from {{ ref('stg_order_details')}}
    ),

    fornecedores as (
        select *
        from {{ ref('dim_fornecedores')}}
    ),

    produtos as (
        select *
        from {{ ref('dim_produtos')}}
    ),

    tabela_fato_detalhes as(
        select
        id_pedido,
        sk_produto, -- chave autoincremental
        detalhes.preco_unit,
        quantidade,
        desconto
        from detalhes
        left join produtos on detalhes.id_produto = produtos.id_produto
    )

select * from tabela_fato_detalhes