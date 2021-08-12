with dados_fonte as (
    select
        row_number() over (order by shipper_id) as sk_transportadora, -- chave autoincremental
        shipper_id as id_transportadora,
        company_name as nome_transportadora,
        phone as telefone
    from {{ source('northwind_etl', 'shippers')}}
)
select * from dados_fonte