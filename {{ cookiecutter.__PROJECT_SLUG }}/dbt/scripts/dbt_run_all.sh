#!/bin/bash
dbt deps
dbt run --full-refresh --exclude ./models/examples/zzz_example_test_model/ --profiles-dir .
