{%- raw %}
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if target.name == "sandbox" or target.name == "sandbox_local" or target.name == "lab" or target.name == "hway"  -%}

        {{ custom_schema_name | trim }}

    {%- elif target.name == "sandbox_ci" or target.name == "lab_ci" -%}

        {{ default_schema | trim }}

    {%- elif custom_schema_name is none -%}

        {{ default_schema | trim }}

    {%- else -%}

      {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
{%- endraw %}