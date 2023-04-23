#!/bin/bash
dbt deps
dbt run --profiles-dir .
