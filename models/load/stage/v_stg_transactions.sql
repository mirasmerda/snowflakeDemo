{{- config(schema='stg', enabled=true, tags='stage') -}}

{%- set source_table = ref('raw_transactions') -%}
{%- set loaddate = dbt_utils.dateadd(datepart='day', interval=1, from_date_or_timestamp="transaction_date") -%}

{{ dbtvault.multi_hash([
([ 'customer_id', 'transaction_number'], 'transaction_pk'),
('customer_id', 'customer_fk'),
('order_id', 'order_fk')]) -}},

{{ dbtvault.add_columns(source_table,
[(loaddate, 'loaddate'),
('transaction_date', 'effective_from'),
('!raw_transactions', 'source')]) }}

{{ dbtvault.from(source_table) }}