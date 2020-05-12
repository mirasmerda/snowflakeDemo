{{- config(schema='stg', enabled=true, tags='stage') -}}

{%- set source_table = ref('raw_inventory') -%}

{{ dbtvault.multi_hash([('supplierkey', 'supplier_pk'),
('supplier_nation_key', 'supplier_nation_pk'),
('supplier_region_key', 'supplier_region_pk'),
('supplier_nation_key', 'nation_pk'),
('supplier_region_key', 'region_pk'),
(['supplier_nation_key', 'supplier_region_key'], 'nation_region_pk'),
(['supplierkey', 'supplier_nation_key'], 'link_supplier_nation_pk'),
('partkey', 'part_pk'),
(['partkey', 'supplierkey'], 'inventory_pk'),
(['supplierkey', 'supplier_acctbal', 'supplier_address', 'supplier_phone', 'supplier_comment', 'supplier_name'], 'supplier_hashdiff', true),
(['partkey', 'part_brand', 'part_comment', 'part_container', 'part_mfgr', 'part_name', 'part_retailprice', 'part_size', 'part_type'], 'part_hashdiff', true),
(['supplier_region_key', 'supplier_region_comment', 'supplier_region_name'], 'supplier_region_hashdiff', true),
(['supplier_nation_key', 'supplier_nation_comment', 'supplier_nation_name'], 'supplier_nation_hashdiff', true),
(['partkey', 'supplierkey', 'availqty', 'supplycost', 'part_supply_comment'], 'inventory_hashdiff', true)]) -}},

{{ dbtvault.add_columns(source_table,
[('supplier_nation_key', 'supplier_nationkey'),
('supplier_nation_key', 'nation_key'),
('supplier_region_key', 'supplier_regionkey'),
('supplier_region_key', 'region_key'),
('supplierkey', 'supplier_key'),
('partkey', 'part_key'),
(var('date'), 'loaddate'),
(var('date'), 'effective_from'),
('!tpch-inventory', 'source')]) }}

{{ dbtvault.from(source_table) }}