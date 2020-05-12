{{config(enabled=true, tags='raw')}}

select
    a.orderkey as orderkey,
    a.partkey as partkey ,
    a.suppkey as supplierkey,
    a.linenumber as linenumber,
    a.quantity as quantity,
    a.extendedprice as extendedprice,
    a.discount as discount,
    a.tax as tax,
    a.returnflag as returnflag,
    a.linestatus as linestatus,
    case when a.shipdate > {{var("date")}} then null else a.shipdate end as shipdate,
    case when a.commitdate > {{var("date")}}  then null else a.commitdate end as commitdate,
    case when a.receiptdate > {{var("date")}}  then null else a.receiptdate end as receiptdate,
    a.shipinstruct as shipinstruct,
    a.shipmode as shipmode,
    a.comment as line_comment,
    b.custkey as customerkey,
    b.orderstatus as orderstatus,
    b.totalprice as totalprice,
    b.orderdate as orderdate,
    b.orderpriority as orderpriority,
    b.clerk as clerk,
    b.shippriority as shippriority,
    b.comment as order_comment,
    c.name as customer_name,
    c.address as customer_address,
    c.nationkey as customer_nationkey,
    c.phone as customer_phone,
    c.acctbal as customer_accbal,
    c.mktsegment as customer_mktsegment,
    c.comment as customer_comment,
    d.name as customer_nation_name,
    d.regionkey as customer_regionkey,
    d.comment as customer_nation_comment,
    e.name as customer_region_name,
    e.comment as customer_region_comment
from {{ source('tpch', 'orders') }} as b
left join {{ source('tpch', 'lineitem') }} as a on a.orderkey=b.orderkey
left join {{ source('tpch', 'customer') }} as c on b.custkey = c.custkey
left join {{ source('tpch', 'nation') }} as d on c.nationkey = d.nationkey
left join {{ source('tpch', 'region') }} as e on d.regionkey = e.regionkey
left join {{ source('tpch', 'part') }} as g on a.partkey = g.partkey
left join {{ source('tpch', 'supplier') }} as h on a.suppkey = h.suppkey
left join {{ source('tpch', 'nation') }} as j on h.nationkey = j.nationkey
left join {{ source('tpch', 'region') }} as k on j.regionkey = k.regionkey

where b.orderdate = {{var("date")}}