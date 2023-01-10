{%- raw %}
/*
    This example captures 'meta' arguments which are required for Highway workspaces
*/

{{ config(

  schema="TEST_SCHEMA_1",
  materialized='table'

)

}}

SELECT TOP 10 *
FROM {{ source('myxero_c2', 'organisation') }}
{%- endraw %}
