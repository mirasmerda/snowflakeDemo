{{- config(schema='vlt', tags='t_link') -}}

{{ dbtvault.t_link(var('src_pk'), var('src_fk'), var('src_payload'), var('src_eff'),
                   var('src_ldts'), var('src_source'), var('source')) }}