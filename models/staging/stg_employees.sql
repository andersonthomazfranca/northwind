with dados_fonte as (
    select
        row_number() over (order by employee_id) as sk_funcionario, -- chave autoincremental
        employee_id as id_funcionario,
        first_name as nome,
        last_name as sobrenome,
        title as cargo,
        country as pais,
        city as cidade,
        address as endereco,
        postal_code as cep,
        hire_date as data_adimissao,
        extension as extensao,
        home_phone as telefone,
        birth_date as anivesario,
        region as regiao,
        reports_to as superior
    from {{ source('northwind_etl', 'employees')}}
)
select * from dados_fonte