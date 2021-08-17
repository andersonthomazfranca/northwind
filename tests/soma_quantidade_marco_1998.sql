with soma_quantidade as (
    select
        sum (quantidade) as qnt
        from {{ ref('fact_pedidos')}}
        where data_pedido
        between '1998-03-01' and '1998-03-31'
)
Select * from soma_quantidade where qnt != 4065