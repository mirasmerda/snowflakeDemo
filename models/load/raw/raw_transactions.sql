{{config(enabled=true, tags='raw')}}

select
    b.orderkey as order_id,
    b.custkey as customer_id,
    b.orderdate as order_date,
    {{ dbt_utils.dateadd(datepart='day', interval=20, from_date_or_timestamp="b.orderdate") }}  as transaction_date,
    cast(rpad(concat(b.orderkey, b.custkey, format_date('%d%m%y', b.orderdate)),  24, '0') as numeric) as transaction_number, -- todo: adapt for cross-db
    b.totalprice as amount,
    cast(
    case abs(mod(cast(rand() as numeric), 2)) + 1   -- todo: adapt for cross-db
        when 1 then 'DR'
        when 2 then 'CR'
    end as {{ dbt_utils.type_string() }}) as type
from {{ source('tpch', 'orders') }} as b
left join {{ source('tpch', 'customer') }} as c on b.custkey = c.custkey
where b.orderdate = {{var("date")}}
