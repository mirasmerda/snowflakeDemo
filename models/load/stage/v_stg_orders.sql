{{- config(schema='stg', enabled=true, tags='stage') -}}

{%- set source_table = ref('raw_orders') -%}

{{ dbtvault.multi_hash([('customerkey', 'customer_pk'),
(['customerkey', 'customer_nationkey'], 'link_customer_nation_pk'),
('customer_nationkey', 'customer_nation_pk'),
('customer_regionkey', 'customer_region_pk'),
('customer_nationkey', 'nation_pk'),
('customer_regionkey', 'region_pk'),
(['customer_nationkey', 'customer_regionkey'], 'nation_region_pk'),
('orderkey', 'order_pk'),
(['customerkey', 'orderkey'], 'order_customer_pk'),
(['orderkey', 'linenumber'], 'lineitem_pk'),
(['orderkey', 'orderkey', 'linenumber'], 'link_lineitem_order_pk'),
('partkey', 'part_pk'),
('supplierkey', 'supplier_pk'),
(['partkey', 'supplierkey'], 'inventory_pk'),
(['linenumber', 'partkey', 'supplierkey'], 'inventory_allocation_pk'),
(['customerkey', 'customer_name', 'customer_address', 'customer_phone', 'customer_accbal', 'customer_mktsegment', 'customer_comment'], 'customer_hashdiff', true),
(['customer_nationkey', 'customer_nation_comment', 'customer_nation_name'], 'customer_nation_hashdiff', true),
(['customer_regionkey', 'customer_region_comment', 'customer_region_name'], 'customer_region_hashdiff', true),
(['orderkey', 'linenumber', 'commitdate', 'discount', 'extendedprice', 'linestatus', 'line_comment', 'quantity', 'receiptdate', 'returnflag', 'shipdate', 'shipinstruct', 'shipmode', 'tax'], 'lineitem_hashdiff', true),
(['orderkey', 'clerk', 'orderdate', 'orderpriority', 'orderstatus', 'order_comment', 'shippriority', 'totalprice'], 'order_hashdiff', true)]) -}},

{{ dbtvault.add_columns(source_table,
[('customer_name', 'name'),
('customer_address', 'address'),
('customer_phone', 'phone'),
('customer_accbal', 'accbal'),
('customer_mktsegment', 'mktsegment'),
('customer_comment', 'comment'),
('customer_nationkey', 'customer_nation_key'),
('customer_nationkey', 'nation_key'),
('customer_nation_name', 'customer_nation_name'),
('customer_nation_comment', 'customer_nation_comment'),
('customer_regionkey', 'customer_region_key'),
('customer_regionkey', 'region_key'),
('customer_region_name', 'customer_region_name'),
('customer_region_comment', 'customer_region_comment'),
('customerkey', 'customer_key'),
('partkey', 'part_key'),
('supplierkey', 'supplier_key'),
('linenumber', 'lineitem_key'),
('orderkey', 'order_key'),
(var('date'), 'loaddate'),
('orderdate', 'effective_from'),
('!tpch-orders', 'source')]) }}

{{ dbtvault.from(source_table) }}