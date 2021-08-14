with dados_fonte as (
    select
        row_number() over (order by supplier_id) as sk_fornecedor, -- chave autoincremental
        supplier_id as id_fornecedor,
        company_name as nome_empresa,
        contact_name as contato,
        contact_title as cargo,
        phone as telefone,
        address as endereco,
        city as cidade,
        country as pais,
        postal_code as cep,
        homepage as site,
        region as regiao
    from {{ source('northwind_etl', 'suppliers')}}
)
select * from dados_fonte