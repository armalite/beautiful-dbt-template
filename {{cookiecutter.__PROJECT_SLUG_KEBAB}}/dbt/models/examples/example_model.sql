{%- raw %}

{{ config(

  schema="EXAMPLES",
  materialized='table',
)

}}

SELECT 'ABC123' AS organisationid, 'Jaffle Shop' AS organisationname
UNION
SELECT 'DEF456' AS organisationid, 'XADE Cafe' AS organisationname
{%- endraw %}
