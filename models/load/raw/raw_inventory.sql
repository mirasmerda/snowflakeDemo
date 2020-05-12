{{ config(enabled=true, tags='raw')}}

select
  a.partkey as partkey
, a.suppkey as supplierkey
, a.availqty as availqty
, a.supplycost as supplycost
, a.comment as part_supply_comment
, b.name as supplier_name
, b.address as supplier_address
, b.nationkey as supplier_nation_key
, b.phone as supplier_phone
, b.acctbal as supplier_acctbal
, b.comment as supplier_comment
, c.name as part_name
, c.mfgr as part_mfgr
, c.brand as part_brand
, c.type as part_type
, c.size as part_size
, c.container as part_container
, c.retailprice as part_retailprice
, c.comment as part_comment
, d.name as supplier_nation_name
, d.comment as supplier_nation_comment
, d.regionkey as supplier_region_key
, e.name as supplier_region_name
, e.comment as supplier_region_comment
from {{ source('tpch', 'partsupp') }} as a
left join {{ source('tpch', 'supplier') }} as b on a.suppkey=b.suppkey
left join {{ source('tpch', 'part') }} as c on a.partkey=c.partkey
left join {{ source('tpch', 'nation') }} as d on b.nationkey=d.nationkey
left join {{ source('tpch', 'region') }} as e on d.regionkey=e.regionkey
join {{ ref('raw_orders') }} as f on a.partkey = f.partkey and a.suppkey=f.supplierkey
order by a.partkey, a.suppkey