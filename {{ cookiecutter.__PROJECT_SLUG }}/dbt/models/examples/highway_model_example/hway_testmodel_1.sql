{%- raw %}
/*
    This example captures 'meta' arguments which are required for Highway workspaces
*/

{{ config(

  schema="TEST_SCHEMA_1",
  materialized='table',
  persist_docs={"relation": true, "columns": true},
  meta = {
            "dataset_sensitivity_level": "s",
            "personal_data_indicator": "p",
            "dataset_classification_v1": "C3",
            "kotahi_id": "BWzpyN4O9PGJBcaN4PhHLG"
          }
)

}}

SELECT TOP 10 *
FROM {{ source('myxero_c2', 'organisation') }}
{%- endraw %}
