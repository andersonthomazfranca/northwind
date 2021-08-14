with dados_fonte as (
    select
        row_number() over (order by customer_id) as sk_cliente, -- chave autoincremental
        customer_id as id_cliente,
        company_name as nome_empresa,
        contact_name as contato,
        contact_title as cargo,
        phone as telefone,
        address as endereco,
        country as pais,
        city as cidade,
        region as regiao,
        postal_code as cep,
        fax
    from {{ source('northwind_etl', 'customers')}}
)
select * from dados_fonte