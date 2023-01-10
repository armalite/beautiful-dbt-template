#!/bin/bash
dbt deps
dbt run --full-refresh --models ./models/examples/zzz_example_test_model/ --profiles-dir .
